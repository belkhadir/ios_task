//
//  RecipeCollectionViewCell.swift
//  ios_task
//
//  Created by Belkhadir anas on 28/8/2021.
//

import UIKit
import Kingfisher

// Mark: RecipeCollectionViewCell
final class RecipeCollectionViewCell: BaseCollectionView {
    
    // Mark: private UI Properties
    private let imageView = UIImageView()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 0
        label.contentMode = .left
        label.textColor = .black
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    // Mark: propeties for cell
    private let cornerRadius: CGFloat = 5
    
    // Mark: Life Cycle
    override func setupLayout() {
        applyCardEffect()
        setupUI()
    }
    
    // Mark: setup the view
    fileprivate func setupUI() {
        addSubview(imageView)
        addSubview(titleLabel)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 180).isActive = true
        
        
        [imageView.topAnchor.constraint(equalTo: topAnchor),
         imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
         imageView.trailingAnchor.constraint(equalTo: trailingAnchor)].forEach{ $0.isActive = true }
        
        [titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 12),
         titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
         titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12)].forEach{ $0.isActive = true }
        
        titleLabel.sizeToFit()
    }
    
    private func applyCardEffect() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = cornerRadius
        contentView.backgroundColor = .white
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: -1, height: 2)
        layer.shadowOpacity = 0.2
        contentView.layer.shadowRadius = 10
        layer.shadowPath = shadowPath.cgPath
    }
    
    // Mark: Apply change to the cell
    func configure(cell with: Recipe) {
        titleLabel.text = with.title
        guard let url =  with.imageURL else { return }
        imageView.kf.setImage(with: url)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
}
