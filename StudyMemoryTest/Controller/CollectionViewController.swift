//
//  CollectionViewController.swift
//  StudyMemoryTest
//
//  Created by 이상도 on 2023/05/17.
//

import UIKit

class CollectionViewController: UICollectionViewController{
    
    // Properties
    
    private var mainView : MainCollectionView!
    
    // Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView = MainCollectionView(frame: view.bounds)
        view.addSubview(mainView)
        
        // MARK: 네비게이션
        title = "암기 테스트" // 네비게이션 타이틀 제목
      
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
        
        // Additional setup
        
        // Fetch data
        
        // Configure layout
    }
    
    // 새로운 암기 추가
    @objc func addButtonTapped() {
        // "Add" 버튼을 탭했을 때 수행할 동작 구현
        // 예를 들어, 새 항목을 추가하는 화면을 표시할 수 있습니다.
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
    
    // Additional methods
    
}



extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    
    // UICollectionViewDelegateFlowLayout methods
    
}

// MARK: - Other Extensions

extension CollectionViewController {
    
    // Other functionality and method
    
}
