//
//  ProductTableViewCell.swift
//  DemoProjectOne
//
//  Created by Sparsh Singh on 16/02/26.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    var imageCacheData : [String : UIImage] = [:]
    
    var product : ProductElement? {
        didSet {
            titleLabel.text = product?.title
            priceLabel.text = "Price: $" + "\(product?.price)"
            descriptionTextView.text = product?.description
            
            
            if let rating = product?.rating {
                ratingLabel.text = "Rating: " + "\(rating.rate ?? 0)"
                countLabel.text = "Count: " + "\(rating.count ?? 0)"
            }
            
            if let url = product?.image {
                
                if let cacheImage = imageCacheData[url] {
                    print("[Debug] Image Coming From Cached Image with URL - \(url)")
                    self.productImage.image = cacheImage
                } else {
                    guard let actualURL = URL(string: url) else { return }
                    let request = URLRequest(url: actualURL)
                    URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
                        guard let data = data, error == nil else { return }
                        guard let actualImage = UIImage(data: data) else { return }
                        self?.imageCacheData[url] = actualImage
                        print("[Debug] Image Coming From Live Image with URL - \(url)")
                        DispatchQueue.main.async {
                            self?.productImage.image = actualImage
                        }
                    }.resume()
                }
            }
            
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
