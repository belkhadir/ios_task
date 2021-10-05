//
//  BaseCollectionView.swift
//  ios_task
//
//  Created by Belkhadir anas on 28/8/2021.
//

import UIKit

class BaseCollectionView: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func setupLayout() {
        
    }
}
