//
//  RecipeViewController.swift
//  ios_task
//
//  Created by Belkhadir anas on 28/8/2021.
//

import UIKit
import Combine
import JGProgressHUD

class RecipeViewController: UICollectionViewController {

    // Mark: webservice
    private var webService: APIServiceProtocol?
    
    // Mark: subscriber
    private var subscription: AnyCancellable!
    
    // Mark: Properties model
    private var recipes = [Recipe]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    // Loader View
    private let loadingView = JGProgressHUD(style: JGProgressHUDStyle.dark)
    
    
    // Mark: Object life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        registerCell()
        fetchRecipe()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupUI() {
        collectionView.backgroundColor = .systemGroupedBackground
        title = "Recipe"
    }
    
    private func registerCell() {
        collectionView.register(RecipeCollectionViewCell.self, forCellWithReuseIdentifier: RecipeCollectionViewCell.reuseIdentifier)
    }
    
    // Mark: -  webservice method
    
    func fetchRecipe() {
        webService = MarleySpoonAPIService()
        loadingView.show(in: view)
        subscription = webService?
            .getAllRecipe()
            .sink(receiveCompletion: { status in
                switch status {
                case .failure(let error):
                    print(error)
                case .finished:
                    print("finfished")
                }
            }, receiveValue: { [weak self] result in
                guard let weakSelf = self else { return }
                let recipes = RecipeViewModel(result: result)
                weakSelf.recipes = recipes.recipes
                DispatchQueue.main.async {
                    weakSelf.loadingView.dismiss()
                }                
            })
    }
    

}

// Mark: UICollection view data source
extension RecipeViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeCollectionViewCell.reuseIdentifier, for: indexPath) as! RecipeCollectionViewCell
        let recipe = recipes[indexPath.item]
        cell.configure(cell: recipe)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let recipe = recipes[indexPath.item]
        let detailVC = DetailRecipeViewController()
        detailVC.configure(with: recipe)
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

// Mark: UICollection view delegate
extension RecipeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width - 2*20.0
        let height = (width/3)*2
        return CGSize(width: width, height: height + 6)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}
