//
//  UserTestView.swift
//  StudyMemoryTest
//
//  Created by 이상도 on 2023/05/23.
//

import UIKit
import SnapKit

class UserTestView: UIView {
    
    override init(frame: CGRect){
        super.init(frame:frame)
        
        self.backgroundColor = UIColor.tintColor // SuperView 배경색
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder: has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
}

