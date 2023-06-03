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
    
    let size = UIScreen.main.bounds.width * 0.02 // 현재 시뮬레이터의 화면 너비
    
    /// 텍스트 뷰
    let upView: UIView = {
        let mainView = UIView()
        mainView.backgroundColor = .systemYellow
        return mainView
    }()
    
    let serveTextView: UITextView = {
        let serveTextView = UITextView()
        serveTextView.backgroundColor = .systemYellow
        serveTextView.font = UIFont.systemFont(ofSize: 18)
        serveTextView.text = nil
        serveTextView.textAlignment = .center
        serveTextView.isEditable = false
        return serveTextView
    }()
    
    /// 그리기 뷰
    
    let bottomView : UIView = {
        let subView = UIView()
        subView.backgroundColor = .systemYellow
        return subView
    }()
    
    let canvasView : PKCanvasView = {
        let canvasView = PKCanvasView()
        
        return canvasView
    }()
    
    // 스택뷰 / 이미지 버튼 4개
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    let trashImageButton : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "trash")
        return imageView
    }()
    
    let undoImageButton : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "undo")
        return imageView
    }()
    
    let redoImageButton : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "redo")
        return imageView
    }()
    
    let paletteImageButton : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "palette")
        return imageView
    }()
    
    
    
    override init(frame: CGRect){
        super.init(frame:frame)
        
        self.backgroundColor = UIColor.white // SuperView 배경색
        
        addSubview(upView)
        upView.addSubview(serveTextView)
        addSubview(bottomView)
        bottomView.addSubview(canvasView)
        
        bottomView.addSubview(stackView)
        stackView.addArrangedSubview(trashImageButton)
        stackView.addArrangedSubview(undoImageButton)
        stackView.addArrangedSubview(redoImageButton)
        stackView.addArrangedSubview(paletteImageButton)
        
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
            make.height.equalToSuperview().dividedBy(5) // Height = 해상도의 1/4
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().inset(20)
            
            upView.layer.cornerRadius = 30
            upView.layer.masksToBounds = true
        }
        
        serveTextView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(10)
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
            make.top.equalTo(bottomView.snp.top).offset(10)
            make.left.equalTo(bottomView.snp.left).offset(10)
            make.right.equalTo(bottomView.snp.right).offset(-10)
            make.bottom.equalTo(bottomView.snp.bottom).offset(-100)
            
            canvasView.layer.cornerRadius = 30
            bottomView.layer.masksToBounds = true
            
        }
        
        stackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(canvasView.snp.bottom).offset(10)
            make.bottom.equalToSuperview().offset(-10) // offset과 inset의 차이
            make.width.equalToSuperview()
            make.height.equalTo(30)
            
        }
        
        
        
    }
}

