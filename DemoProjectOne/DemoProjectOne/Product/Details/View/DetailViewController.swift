//
//  DetailViewController.swift
//  DemoProjectOne
//
//  Created by Sparsh Singh on 16/02/26.
//

protocol DetailViewProtocl {
    func didUpdateColor(color : UIColor)
}

import UIKit

class DetailViewController: UIViewController {
    
    var delegate : DetailViewProtocl?

    override func viewDidLoad() {
        super.viewDidLoad()

       includSubView()
    }
    
    private let tableView : UITableView = {
        let tableView = UITableView()
        tableView.layer.cornerRadius = 10
        tableView.backgroundColor = .orange
        tableView.separatorStyle = .none
        return tableView
    }()
    
    func includSubView() {
        
        self.view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
            
        ])
        
    }
    
   
   
}
