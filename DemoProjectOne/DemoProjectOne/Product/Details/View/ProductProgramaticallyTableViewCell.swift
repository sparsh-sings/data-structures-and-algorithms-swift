//
//  ProductProgramaticallyTableViewCell.swift
//  DemoProjectOne
//
//  Created by Sparsh Singh on 16/02/26.
//

import UIKit

class ProductProgramaticallyTableViewCell: UITableViewCell {
    
    static let resusableIdentifier = "product-cell-programatically"
    
    private let localImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let titleLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 10)
        label.textAlignment = .center
        return label
    }()
    
    private let ratingLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 10)
        label.textAlignment = .center
        return label
    }()

    
    var product : ProductElement? {
        didSet {
            titleLabel.text = product?.title ?? ""
            
            if let rate = product?.rating?.rate {
                ratingLabel.text = "Rating : " + String(rate)
            }
            
            
            guard let imageURL = product?.image,
               let actualURL = URL(string: imageURL)
                else { return }
            
            let urlRequest = URLRequest(url: actualURL)
            let session = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                guard let data, error == nil else { return }
                DispatchQueue.main.async {
                    self.localImageView.image = UIImage(data: data)
                }
            }
            session.resume()
        }
    }

    

    // ✅ Proper initializer
        override init(
            style: UITableViewCell.CellStyle,
            reuseIdentifier: String?
        ) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            defineViews()
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    
    func defineViews() {
        
        self.contentView.addSubview(localImageView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(ratingLabel)
        
        localImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            localImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            localImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            localImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 10),
            localImageView.widthAnchor.constraint(equalToConstant: self.contentView.frame.size.width/2 - 20),
            
            titleLabel.leadingAnchor.constraint(equalTo: self.localImageView.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
            titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            
            ratingLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            ratingLabel.leadingAnchor.constraint(equalTo: localImageView.trailingAnchor, constant: 10),
            ratingLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
            ratingLabel.leadingAnchor.constraint(equalTo: localImageView.trailingAnchor, constant: 10)
        ])
        
    }

}
