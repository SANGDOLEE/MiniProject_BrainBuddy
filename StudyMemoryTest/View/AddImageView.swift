//
//  AddImageView.swift
//  StudyMemoryTest
//
//  Created by 이상도 on 2023/05/18.
//

import UIKit

class AddImageView : UIView{
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        // 배경색 설정
        self.backgroundColor = UIColor.systemBlue
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        
        //배경색 설정
        // self.backgroundColor = UIColor.systemBlue
    }
    
    
}
