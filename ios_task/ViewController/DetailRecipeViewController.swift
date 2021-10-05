//
//  DetailRecipeViewController.swift
//  ios_task
//
//  Created by Belkhadir anas on 28/8/2021.
//

import UIKit
import Kingfisher
class DetailRecipeViewController: UIViewController {

    // Mark: - private properties
    private let imageView = UIImageView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 21)
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    private let chefNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .systemGray2
        return label
    }()
    
    private let descriptionLabel: UILabel = {
         let label = UILabel()
         label.font = UIFont.systemFont(ofSize: 14)
         label.numberOfLines = 0
         label.textColor = .black
         return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor =  .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.heightAnchor.constraint(equalToConstant: TagCollectionViewCell.cellHeight).isActive = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(TagCollectionViewCell.self, forCellWithReuseIdentifier: TagCollectionViewCell.reuseIdentifier)
        return collectionView
    }()
    
    
    // Mark: private model
    private var tags = [String]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    // Mark: - object life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = false
        setupLayout()
    }
    
    // Mark: - setup layout
    private func setupLayout() {
        [imageView , titleLabel, chefNameLabel, descriptionLabel, collectionView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        // setup image layout
        imageView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        [imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
         imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
         imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)].forEach{ $0.isActive = true }
        
        // setup title layout
        [titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 12),
         titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
         titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12)].forEach{ $0.isActive = true }
        
        // setup chefName layout
        [chefNameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
         chefNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
         chefNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12)].forEach{ $0.isActive = true }
        
        // setup description layout
        [descriptionLabel.topAnchor.constraint(equalTo: chefNameLabel.bottomAnchor, constant: 12),
         descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
         descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12)].forEach{ $0.isActive = true }
        
        // setup collectionView layout
        [collectionView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 12),
         collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
         collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12)].forEach{ $0.isActive = true }
        
    }

    // Mark: update the view controller with data
    func configure(with recipe: Recipe) {
        if let url =  recipe.imageURL {
            imageView.contentMode = .scaleAspectFit
            imageView.kf.setImage(with: url)
        }
        titleLabel.text = recipe.title
        descriptionLabel.text = recipe.description
        chefNameLabel.text = recipe.chef
        tags = recipe.tags
        title = recipe.title
    }
}

// Mark: - UICollection View Data Source
extension DetailRecipeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.reuseIdentifier, for: indexPath) as! TagCollectionViewCell
        let tag = tags[indexPath.item]
        cell.configure(with: tag)
        return cell
    }
}

// Mark: - UICollection View Delegate
extension DetailRecipeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: TagCollectionViewCell.width, height: TagCollectionViewCell.cellHeight)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
