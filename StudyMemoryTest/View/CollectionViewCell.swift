//
//  CollectionViewCell.swift
//  StudyMemoryTest
//
//  Created by 이상도 on 2023/05/22.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        self.layer.cornerRadius = 30
        self.layer.masksToBounds = true
        self.backgroundColor = .systemRed
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
