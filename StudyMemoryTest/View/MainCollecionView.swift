//
//  MainCollecionView.swift
//  StudyMemoryTest
//
//  Created by 이상도 on 2023/05/17.
//

import UIKit

let cellID = "Cell" // Cell ID 등록

class MainCollectionView: UIView {
    
    let collectionView: UICollectionView = {
        let flowlayout = UICollectionViewLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowlayout)
        return cv
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        // 배경색 설정
        self.backgroundColor = UIColor.tintColor
        
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
        collectionView.backgroundColor = .tintColor
        
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        
        //배경색 설정
        // self.backgroundColor = UIColor.systemBlue
    }
}
