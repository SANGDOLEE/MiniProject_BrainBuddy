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
    
    /// 텍스트 뷰
    let upView: UIView = {
        let mainView = UIView()
        mainView.backgroundColor = .white
        return mainView
    }()
    
    let serveTextView: UITextView = {
        let serveTextView = UITextView()
        serveTextView.backgroundColor = .white
        serveTextView.font = UIFont.systemFont(ofSize: 18)
        serveTextView.text = nil
        serveTextView.textAlignment = .center
        serveTextView.isEditable = false
        return serveTextView
    }()
    
    /// 그리기 뷰
    
    let bottomView : UIView = {
        let subView = UIView()
        subView.backgroundColor = .white
        return subView
    }()
    
    let canvasView : PKCanvasView = {
        let canvasView = PKCanvasView()
        return canvasView
    }()
    
    let drawingLabel : UILabel = {
        let label = UILabel()
        label.text = "Drawing Here"
        label.textColor = .systemGray5
        label.font = UIFont.systemFont(ofSize: 32)
        return label
    }()
    
    // 스택뷰 / 이미지 버튼 4개
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    let trashImageButton : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "trash")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let undoImageButton : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "undo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let redoImageButton : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "redo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    /*
    let paletteImageButton : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "palette")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
     */
    
    
    
    override init(frame: CGRect){
        super.init(frame:frame)
        
        //backgroundColorSetGradient(color1: .white, color2: .tintColor) // 배경색상
        backgroundColor = .tintColor
        
        addSubview(upView)
        upView.addSubview(serveTextView)
        addSubview(bottomView)
        bottomView.addSubview(canvasView)
        canvasView.addSubview(drawingLabel)
        
        bottomView.addSubview(stackView)
        stackView.addArrangedSubview(trashImageButton)
        stackView.addArrangedSubview(undoImageButton)
        stackView.addArrangedSubview(redoImageButton)
        // stackView.addArrangedSubview(paletteImageButton)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder: has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        upView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide.snp.topMargin).offset(15)
            make.height.equalToSuperview().dividedBy(5) // Height = 해상도의 1/4
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            
            upView.layer.cornerRadius = 30
            upView.layer.masksToBounds = true
        }
        
        serveTextView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(5)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().inset(5)
            
            serveTextView.layer.borderWidth = 1.0
            serveTextView.layer.borderColor = UIColor.white.cgColor
            
            serveTextView.layer.cornerRadius = 30
            serveTextView.layer.masksToBounds = true
            
            serveTextView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        
        bottomView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(upView.snp.bottomMargin).offset(20)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            
            bottomView.layer.cornerRadius = 30
            bottomView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            bottomView.layer.masksToBounds = true
            
        }
        
        canvasView.snp.makeConstraints { make in
            make.top.equalTo(bottomView.snp.top).offset(0)
            make.left.equalTo(bottomView.snp.left).offset(0)
            make.right.equalTo(bottomView.snp.right).offset(0)
            make.bottom.equalTo(bottomView.snp.bottom).offset(-60)
            
            canvasView.layer.cornerRadius = 30
            bottomView.layer.masksToBounds = true
            
        }
        
        drawingLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(canvasView.snp.bottom).offset(10)
            make.bottom.equalToSuperview().offset(-10) // offset과 inset의 차이
            make.width.equalToSuperview()
            make.height.equalTo(30)
            
        }
    }
    
    // 네비게이션 배경 
    /*
    func backgroundColorSetGradient(color1:UIColor, color2: UIColor) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [color1.cgColor, color2.cgColor]
        gradient.locations = [ 0.0, 1.0]
        gradient.startPoint = CGPoint(x:0.5, y:1.0)
        gradient.endPoint = CGPoint(x:0.5, y:0.0)
        gradient.frame = bounds
        layer.addSublayer(gradient)
    }
     */
}


