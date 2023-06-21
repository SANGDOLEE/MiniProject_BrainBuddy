//
//  MainCollecionView.swift
//  StudyMemoryTest
//
//  Created by 이상도 on 2023/05/17.
//

import UIKit

import SnapKit

let cellID = "Cell" // Cell ID 등록

class MainCollectionView: UIView {
    
    let collectionView: UICollectionView = {
        let flowlayout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowlayout)
        return cv
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.tintColor
        
        addSubview(collectionView)
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.layer.cornerRadius = 10
        collectionView.layer.masksToBounds = true
        
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        
        //배경색 설정
        // self.backgroundColor = UIColor.systemBlue
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.left.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
            make.right.equalToSuperview()
            
            collectionView.backgroundColor = .tintColor
        }
        
    }
    
    func setGradient(color1: UIColor, color2: UIColor){
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [color1.cgColor, color2.cgColor]
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x:0.0, y:1.0)
        gradient.endPoint = CGPoint(x:1.0, y:1.0)
        gradient.frame = bounds
        layer.addSublayer(gradient)
        
        // backgroundColor = .clear
    }
}
