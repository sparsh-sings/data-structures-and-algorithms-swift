//
//  HomeViewModel.swift
//  DemoProjectOne
//
//  Created by Sparsh Singh on 16/02/26.
//

import Foundation

class HomeViewModel {
    
    var products : Product?
    var allProducts : Product?
    
    var events : ((_ events : Events) -> Void)?
    
    func fetchProductData() {
        events?(.dataLoading)
        NetworkLayer.sharedInstance.request(url: DefaultURL.productURL, model: Product.self) { [weak self] result in
            guard let self else { return }
                self.events?(.dataLoaded)
            switch result {
            case.success(let data):
                self.products = data
                self.allProducts = data
                self.events?(.fetchSuccess)
            case .failure(let error):
                self.events?(.fetchFailure(error: error.localizedDescription))
            }
        }
    }
}

enum Events {
    case dataLoading
    case dataLoaded
    case fetchSuccess
    case fetchFailure(error: String)
}
