//
//  ProductTableViewCell.swift
//  DemoProjectTwo
//
//  Created by Sparsh Singh on 16/02/26.
//

import UIKit

class ProductTableViewCell : UITableViewCell {
    
    static let reusableIdentifier = "ProductTableViewCell"
    
    var productElement : ProductElement? {
        didSet {
            titleLabel.text = productElement?.title ?? ""
            ratingLabel.text = "Rating : " + "\(productElement?.rating?.rate ?? 0)"
            countLabel.text = "Count : " + "\(productElement?.rating?.count ?? 0)"
            titleLabel.text = productElement?.title ?? ""
            priceLabel.text = "$\(productElement?.price ?? 0)"
            descriptionTextView.text = productElement?.description ?? ""
            
            if let actualURL = URL(string: productElement?.image ?? "") {
                let request = URLRequest(url: actualURL)
                URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
                    if let data,
                       error == nil {
                        DispatchQueue.main.async {
                            self?.localImageView.image = UIImage(data: data)
                        }
                    }
                }.resume()
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle,reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        laySubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let localImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 12
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    let ratingLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.backgroundColor = .clear
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    let countLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .right
        label.textColor = .white
        return label
    }()
    
    let priceLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    let categoryLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    let descriptionTextView : UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        textView.textAlignment = .left
        textView.layer.cornerRadius = 1.0
        textView.layer.borderColor = UIColor.darkGray.cgColor
        textView.layer.borderWidth = 1.0
        textView.textColor = .white
        textView.isEditable = false
        return textView
    }()
    
    lazy var ratingStack : UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 0
        stackView.axis = .vertical
        stackView.addArrangedSubview(ratingLabel)
        stackView.addArrangedSubview(countLabel)
        return stackView
    }()
    
    func laySubviews() {
        
        self.contentView.addSubview(localImageView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(priceLabel)
        self.contentView.addSubview(categoryLabel)
        self.contentView.addSubview(descriptionTextView)
        self.contentView.addSubview(ratingStack)
        
        
        localImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        ratingStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            localImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            localImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10),
            localImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            localImageView.widthAnchor.constraint(equalToConstant: self.contentView.frame.width/3),
            
            titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20),
            titleLabel.heightAnchor.constraint(equalToConstant: self.contentView.frame.height/5),
            titleLabel.leadingAnchor.constraint(equalTo: self.localImageView.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            ratingStack.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 5),
            ratingStack.heightAnchor.constraint(equalToConstant:  self.contentView.frame.height/5),
            ratingStack.leadingAnchor.constraint(equalTo: self.localImageView.trailingAnchor, constant: 10),
            ratingStack.trailingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            categoryLabel.topAnchor.constraint(equalTo: self.ratingStack.bottomAnchor, constant: 5),
            categoryLabel.heightAnchor.constraint(equalToConstant:  self.contentView.frame.height/5),
            categoryLabel.leadingAnchor.constraint(equalTo:self.localImageView.trailingAnchor, constant: 10),
            categoryLabel.trailingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            descriptionTextView.topAnchor.constraint(equalTo: self.categoryLabel.bottomAnchor, constant: 5),
            descriptionTextView.heightAnchor.constraint(equalToConstant:  self.contentView.bounds.height),
            descriptionTextView.leadingAnchor.constraint(equalTo: self.localImageView.trailingAnchor, constant: 10),
            descriptionTextView.trailingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            priceLabel.topAnchor.constraint(equalTo: self.descriptionTextView.bottomAnchor, constant: 5),
            priceLabel.heightAnchor.constraint(equalToConstant: self.contentView.bounds.height/5),
            priceLabel.leadingAnchor.constraint(equalTo: self.localImageView.trailingAnchor, constant: 10),
            priceLabel.trailingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.trailingAnchor, constant: -10),
        ])
        
    }
    
}
