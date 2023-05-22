//
//  CollectionViewController.swift
//  StudyMemoryTest
//
//  Created by 이상도 on 2023/05/17.
//

import UIKit

class CollectionViewController: UIViewController {
    
    // Properties
    private var mainView : MainCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView = MainCollectionView(frame: view.bounds)
        view.addSubview(mainView)
        
        
        // MARK: 네비게이션
        title = "오늘의 암기" // 네비게이션 타이틀 제목
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        addButton.tintColor = .black
        navigationItem.rightBarButtonItem = addButton
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemBlue
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        appearance.shadowColor = .none
        //navigationController?.navigationBar.tintColor = .white
        //navigationController?.navigationBar.standardAppearance = appearance
        //navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
      
    }
    
    // 문제집 추가
    @objc func addButtonTapped() {
        
        let addImageViewController = AddImageViewController()
        navigationController?.pushViewController(addImageViewController, animated: true)
        
    }
    
    
    
    // Collection View Data Source Methods
    
    /*
     override func numberOfSections(in collectionView: UICollectionView) -> Int {
     // Return the number of sections in your collection view
     }
     
     override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
     // Return the number of items in the specified section
     }
     
     override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     // Create and configure the cell for the item at the specified index path
     // Return the configured cell
     }
     
     // Collection View Delegate Methods
     
     override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
     // Handle item selection
     }
     */
    
    //MARK: Additional methods
    
    open override var shouldAutorotate: Bool {
        return false
    }
    
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    open override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }
}

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    
    // UICollectionViewDelegateFlowLayout methods
    
}

extension CollectionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = mainView.collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! CollectionViewCell
        
        return cell
    }
}

extension CollectionViewController: UICollectionViewDelegate {
    
    
}

