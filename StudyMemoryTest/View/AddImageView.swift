//
//  AddImageView.swift
//  StudyMemoryTest
//
//  Created by 이상도 on 2023/05/18.
//

import UIKit

import SnapKit

class AddImageView : UIView{
    
    let mainView: UIView = {
        let mainView = UIView()
        mainView.backgroundColor = .tintColor
        return mainView
    }()
    
    let subView: UIView = {
        let subView = UIView()
        subView.backgroundColor = .white
        return subView
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 30)
        label.text = "Starting..."
        label.textAlignment = .center
        return label
    }()
    
    let button: UIButton = {
        let button = UIButton()
        button.setTitle("Click", for: .normal)
        button.backgroundColor = UIColor.white
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        return button
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = nil
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect){
        super.init(frame:frame)
        addSubview(mainView)
        addSubview(subView)
        mainView.addSubview(imageView)
        addSubview(label)
        addSubview(button)
        self.backgroundColor = UIColor.tintColor // SuperView 배경색
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder: has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        mainView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.topMargin).offset(20)
            make.width.equalToSuperview()
            make.height.equalToSuperview().dividedBy(3) // Height = 해상도의 1/3
            make.left.right.equalToSuperview()

        }
        
        subView.snp.makeConstraints { make in
            make.top.equalTo(mainView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        let cornerRadius : CGFloat = 30.0
        subView.layer.cornerRadius = cornerRadius
        subView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        subView.layer.masksToBounds = true
        
        
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(mainView.snp.top).offset(10)
            make.left.equalTo(mainView.snp.left).offset(10)
            make.right.equalTo(mainView.snp.right).offset(-10)
            make.bottom.equalTo(mainView.snp.bottom).offset(-10)
        }
        
        button.snp.makeConstraints{ make in
            make.width.height.equalTo(150)
            make.center.equalToSuperview()
        }
        
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(frame.size.width + safeAreaInsets.top)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(200)
        }
    }
    
    func setImage(_ image: UIImage?){
        imageView.image = image
    }
    
    func setLabelText(_ text: String) {
        label.text = text
    }
    
    
}
