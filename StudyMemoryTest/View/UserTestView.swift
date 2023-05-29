//
//  UserTestView.swift
//  StudyMemoryTest
//
//  Created by 이상도 on 2023/05/23.
//

import UIKit
import SnapKit

class UserTestView: UIView {
    
    let upView: UIView = {
        let mainView = UIView()
        mainView.backgroundColor = .systemYellow
        return mainView
    }()
    
    override init(frame: CGRect){
        super.init(frame:frame)
        
        self.backgroundColor = UIColor.tintColor // SuperView 배경색
        
        addSubview(upView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder: has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        upView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.topMargin).offset(20)
            make.width.equalToSuperview()
            make.height.equalToSuperview().dividedBy(4) // Height = 해상도의 1/3
            make.left.right.equalToSuperview()
        }
    }
}

