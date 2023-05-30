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
    
    let serveTextView: UITextView = {
        let serveTextView = UITextView()
        serveTextView.backgroundColor = .systemYellow
        serveTextView.font = UIFont.systemFont(ofSize: 24)
        serveTextView.text = nil
        serveTextView.textAlignment = .center
        serveTextView.isEditable = false
        return serveTextView
    }()
    
    override init(frame: CGRect){
        super.init(frame:frame)
        
        self.backgroundColor = UIColor.tintColor // SuperView 배경색
        
        addSubview(upView)
        upView.addSubview(serveTextView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder: has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        upView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide.snp.topMargin).offset(20)
            make.height.equalToSuperview().dividedBy(4) // Height = 해상도의 1/4
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().inset(20)
            
            upView.layer.cornerRadius = 30
            upView.layer.masksToBounds = true
        }
        
        
        serveTextView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().inset(20)
            
            serveTextView.layer.borderWidth = 1.0
            serveTextView.layer.borderColor = UIColor.systemGray6.cgColor
            
            serveTextView.layer.cornerRadius = 30
            serveTextView.layer.masksToBounds = true
        }
    }
}

