//
//  MainCollecionView.swift
//  StudyMemoryTest
//
//  Created by 이상도 on 2023/05/17.
//

import UIKit

class MainCollectionView: UIView {
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        // 배경색 설정
        self.backgroundColor = UIColor.tintColor
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        
        //배경색 설정
        // self.backgroundColor = UIColor.systemBlue
    }
}
