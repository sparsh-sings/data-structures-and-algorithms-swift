//
//  HomeViewModel.swift
//  DemoProjectTwo
//
//  Created by Sparsh Singh on 16/02/26.
//

import Foundation

final class HomeViewModel {
    
    // MARK: - Init
    init() {}
    
    // MARK: - Data
    var actualProducts : Product?
    var filteredProduct : Product?
    
    // MARK: - Data Binding
    var eventHandler : ((_ event : Events) -> (Void))?
    
    var updatedTextEvent : (() -> ())?
    
    
    // MARK: - Network Function
    func getProductData() {
        eventHandler?(.dataLoading)
        NetworkLayer.shared.sendRequest(urlString: Constant.ProductURL, model: Product.self, requestType: .get) { [weak self] result in
            guard let self else { return }
            self.eventHandler?(.dataLoaded)
            switch result {
            case .success(let data) :
                self.eventHandler?(.loadingSuccess)
                self.actualProducts = data
                self.filteredProduct = data
            case .failure(let error) :
                self.eventHandler?(.loadingFailure(error.localizedDescription))
            }
        }
    }
    
    func didUpdateText(updateText : String) {
        if updateText != "" {
            filteredProduct = filteredProduct?.filter {
                $0.title?.lowercased().contains(updateText.lowercased()) ?? false
            }
        } else {
            filteredProduct = actualProducts
        }
        
        updatedTextEvent?()
    }
}

enum Events {
    case dataLoading
    case dataLoaded
    case loadingSuccess
    case loadingFailure(String?)
}
