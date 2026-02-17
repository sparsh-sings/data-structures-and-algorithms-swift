//
//  HomeVC.swift
//  DemoProjectTwo
//
//  Created by Sparsh Singh on 16/02/26.
//

import UIKit

class HomeVC: UIViewController {
    
    let viewModel = HomeViewModel()
    
    let tableView : UITableView = {
        let tableView = UITableView()
        tableView.separatorColor = .clear
        tableView.backgroundColor = .lightGray
        return tableView
    }()
    
    let searchBar : UISearchBar = {
        let searchBar = UISearchBar()
        return searchBar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.getProductData()
        mapSubviews()
        
        tableView.register(ProductTableViewCell.self, forCellReuseIdentifier: ProductTableViewCell.reusableIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        
        searchBar.delegate = self
        
        viewModel.eventHandler = { [weak self] events in
            guard let self = self else { return }
            switch events {
            case.dataLoading:
                break
            case .dataLoaded:
                break
            case .loadingSuccess :
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                break
            case .loadingFailure(let errorString):
                print(errorString)
                break
            }
        }
        
        viewModel.updatedTextEvent = { [weak self] in
            self?.tableView.reloadData()
        }
    }


}

extension HomeVC {
    
    func mapSubviews() {
        self.view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
        ])
        
        
    }
    
    
    
}


extension HomeVC : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return searchBar
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredProduct?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.reusableIdentifier, for: indexPath) as? ProductTableViewCell else { return UITableViewCell() }
        cell.productElement = viewModel.filteredProduct?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}

extension HomeVC : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.didUpdateText(updateText: searchText)
    }
    
}
