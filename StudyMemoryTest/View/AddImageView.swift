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
        mainView.backgroundColor = .systemBlue
        return mainView
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
        mainView.addSubview(imageView)
        addSubview(label)
        addSubview(mainView)
        addSubview(button)
        self.backgroundColor = UIColor.systemBlue
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder: has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        mainView.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide.snp.topMargin).offset(20)
            make.width.height.equalTo(300)
            make.left.right.equalToSuperview()

        }
        
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(mainView.snp.top).offset(10)
            make.left.equalTo(mainView.snp.left).offset(10)
            make.right.equalTo(mainView.snp.right).offset(-10)
            make.bottom.equalTo(mainView.snp.bottom).offset(-10)
        }
        
        button.snp.makeConstraints{ (make) in
            make.width.height.equalTo(150)
            make.center.equalToSuperview()
        }
        
        label.snp.makeConstraints { (make) in
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
