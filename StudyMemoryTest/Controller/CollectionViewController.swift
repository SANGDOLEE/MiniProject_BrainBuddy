//
//  CollectionViewController.swift
//  StudyMemoryTest
//
//  Created by 이상도 on 2023/05/17.
//

import UIKit

class CollectionViewController: UIViewController {
    
    private var mainView : MainCollectionView! // 뷰 프로퍼티
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView = MainCollectionView(frame: view.bounds)
        view.addSubview(mainView)
        
        mainView.collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        
        // MARK: 네비게이션
        title = "오늘의 암기"
       
        let backButton = UIBarButtonItem() /// AddImageVC에서 현재화면으로 돌아오는 버튼 설정
        backButton.title = ""
        backButton.tintColor = UIColor.white
        navigationItem.backBarButtonItem = backButton
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped)) /// 문제집 추가하는 버튼 설정
        addButton.tintColor = .white
        navigationItem.rightBarButtonItem = addButton
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let apperance = UINavigationBarAppearance() /// 네비게이션 바 타이틀 컬러 고정
        apperance.backgroundColor = .systemBlue
        apperance.titleTextAttributes = [.foregroundColor: UIColor.white]
        apperance.shadowColor = .none
        navigationController?.navigationBar.scrollEdgeAppearance = apperance
    }
    
    /// 이미지 추가하기로 넘어가는 메소드
    @objc func addButtonTapped() {
        let addImageViewController = AddImageViewController()
        navigationController?.pushViewController(addImageViewController, animated: true)
        
    }
}

// MARK: 콜렉션 뷰
extension CollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = mainView.collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! CollectionViewCell
        
        return cell
    }
}

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    
    // cell size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width - 40) / 4.5, height: (view.frame.width - 40) / 4.5)
    }
    
    // cell 사이 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 22
    }
    
    // cell과 view의 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
}
