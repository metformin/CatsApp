//
//  CatCollectionViewCell.swift
//  CatsApp
//
//  Created by Darek on 12/11/2021.
//

import UIKit

class CatCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    var cat: Cat? {
        didSet{
            configureContent()
        }
    }
    
    private lazy var imageDownloadIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        indicator.backgroundColor = .lightGray.withAlphaComponent(0.6)
        indicator.layer.cornerRadius = 10
        return indicator
    }()
    private lazy var catNameLabel: UILabel = {
        let catNameLabel = UILabel()
        catNameLabel.font = UIFont(name: "Futura-Medium", size: 20)
        catNameLabel.numberOfLines = 1
        catNameLabel.adjustsFontSizeToFitWidth = true
        catNameLabel.contentMode = .center
        catNameLabel.textAlignment = .center
        catNameLabel.textColor = .white
        catNameLabel.backgroundColor = .gray.withAlphaComponent(0.6)
        return catNameLabel
    }()
    private lazy var catImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.tintColor = .white
        return image
    }()


    //MARK: - Lifecicle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .appLightGrey
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI Helper Functions
    func configureUI(){
        self.addSubview(catImage)
        catImage.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor)
        
        self.addSubview(imageDownloadIndicator)
        imageDownloadIndicator.centerX(inView: self)
        imageDownloadIndicator.centerY(inView: self)
        imageDownloadIndicator.setDimensions(height: 50, width: 50)
        
    }
    
    func addCatName(){
        self.addSubview(catNameLabel)
        catNameLabel.anchor(left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, height: 40)
        catNameLabel.text = cat?.name
    }
    
    func configureContent(){
        guard let cat = cat else {
            return
        }
        if let _ = cat.name{
            addCatName()
        } else {
            catNameLabel.removeFromSuperview()
        }
        catImage.image = .none
        imageDownloadIndicator.startAnimating()
        if let imageURL = URL(string: cat.pictrue){
            ImageDownloader.shared.fetchImageData(forImage: imageURL) { [weak self] data, res, err in
                if let data = data {
                    DispatchQueue.main.async {
                        self?.catImage.image = UIImage(data: data)
                        self?.imageDownloadIndicator.stopAnimating()
                    }
                }
            }
        }
    }
}
