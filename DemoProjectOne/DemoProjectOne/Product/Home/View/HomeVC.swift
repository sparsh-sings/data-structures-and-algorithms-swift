//
//  HomeVC.swift
//  DemoProjectOne
//
//  Created by Sparsh Singh on 16/02/26.
//

import UIKit

final class HomeVC: UIViewController {
    
    let viewModel = HomeViewModel()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
//        tableView.register(UINib(nibName: "ProductTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductTableViewCell")
        
        tableView.register(ProductProgramaticallyTableViewCell.self, forCellReuseIdentifier: ProductProgramaticallyTableViewCell.resusableIdentifier)
        
        tableView.separatorColor = .clear
        updateStatus()
        
        viewModel.fetchProductData()
    }
    
    func updateStatus() {
        viewModel.events = { [weak self] events in
            switch events {
            case .dataLoading:
                
                break
            case .dataLoaded:
                break
            case .fetchSuccess:
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
                break
            case .fetchFailure(let error):
                print(error)
            }
        }
    }
    
    let headerView : UIView = {
       let headerView = UIView()
        headerView.backgroundColor = .yellow
        return headerView
    }()
    
    let searchBar : UISearchBar = {
        let searchBar = UISearchBar()
        return searchBar
    }()


}

extension HomeVC : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.products?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductProgramaticallyTableViewCell.resusableIdentifier, for: indexPath) as? ProductProgramaticallyTableViewCell else { return UITableViewCell() }
        cell.product = viewModel.products?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headView = headerView
        headerView.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchBar.leadingAnchor.constraint(equalTo: headView.leadingAnchor, constant: 20),
            searchBar.trailingAnchor.constraint(equalTo: headView.trailingAnchor, constant: -20),
            searchBar.topAnchor.constraint(equalTo: headView.topAnchor, constant: 10),
            searchBar.bottomAnchor.constraint(equalTo: headView.bottomAnchor, constant: -10)
        ])
        
        searchBar.delegate = self
        
        return headView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    
}

extension HomeVC : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            viewModel.products = viewModel.allProducts
        } else {
            viewModel.products = viewModel.products?.filter {
                $0.title?.lowercased().contains(searchText.lowercased()) ?? false
            }
        }
        
        self.tableView.reloadData()
    }
    
}

