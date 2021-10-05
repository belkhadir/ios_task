//
//  TagCollectionViewCell.swift
//  ios_task
//
//  Created by Belkhadir anas on 28/8/2021.
//

import UIKit

class TagCollectionViewCell: BaseCollectionView {
    
    // Mark: - private UI propeties
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Mark: static properties
    static let cellHeight: CGFloat = 35
    static let width: CGFloat = 90
    
    // Mark: - object lyfe cycle
    override func setupLayout() {
        super.setupLayout()

        let view = UIView(frame: .init(x: 0, y: 0, width: TagCollectionViewCell.width, height: TagCollectionViewCell.cellHeight))
        view.backgroundColor = .black
        view.clipsToBounds = true
        view.layer.cornerRadius = view.frame.height/2
        
        contentView.addSubview(view)
        [view.topAnchor.constraint(equalTo: topAnchor),
         view.trailingAnchor.constraint(equalTo: trailingAnchor),
         view.leadingAnchor.constraint(equalTo: leadingAnchor),
         view.bottomAnchor.constraint(equalTo: bottomAnchor)].forEach{ $0.isActive = true }
        
        view.addSubview(titleLabel)
        
        [titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
         titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)].forEach { $0.isActive = true }
                
    }
    
    func configure(with tag: String) {
        titleLabel.text = tag.capitalized
    }
}
