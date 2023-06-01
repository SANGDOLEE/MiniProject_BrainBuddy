//
//  UserTestView.swift
//  StudyMemoryTest
//
//  Created by 이상도 on 2023/05/23.
//

import UIKit
import SnapKit
import PencilKit

class UserTestView: UIView {
    
    let upView: UIView = {
        let mainView = UIView()
        mainView.backgroundColor = .systemYellow
        return mainView
    }()
    
    let serveTextView: UITextView = {
        let serveTextView = UITextView()
        serveTextView.backgroundColor = .systemYellow
        serveTextView.font = UIFont.systemFont(ofSize: 20)
        serveTextView.text = nil
        serveTextView.textAlignment = .center
        serveTextView.isEditable = false
        return serveTextView
    }()
    
    ///
    
    let bottomView : UIView = {
        let subView = UIView()
        subView.backgroundColor = .systemYellow
        return subView
    }()
    
    let canvasView : PKCanvasView = {
        let canvasView = PKCanvasView()
        
        return canvasView
    }()
    
    override init(frame: CGRect){
        super.init(frame:frame)
        
        self.backgroundColor = UIColor.white // SuperView 배경색
        
        addSubview(upView)
        upView.addSubview(serveTextView)
        addSubview(bottomView)
        bottomView.addSubview(canvasView)
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
            serveTextView.layer.borderColor = UIColor.systemYellow.cgColor
            
            serveTextView.layer.cornerRadius = 30
            serveTextView.layer.masksToBounds = true
            
            serveTextView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        
        bottomView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(upView.snp.bottomMargin).offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(20)
            
            bottomView.layer.cornerRadius = 30
            bottomView.layer.masksToBounds = true
        }
        
        canvasView.snp.makeConstraints { make in
            make.top.equalTo(bottomView.snp.top).offset(20)
            make.left.equalTo(bottomView.snp.left).offset(20)
            make.right.equalTo(bottomView.snp.right).offset(-20)
            make.bottom.equalTo(bottomView.snp.bottom).offset(-20)
        }
    }
}

