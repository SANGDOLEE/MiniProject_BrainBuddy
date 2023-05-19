//
//  AddImageView.swift
//  StudyMemoryTest
//
//  Created by 이상도 on 2023/05/18.
//

import UIKit

import SnapKit

class AddImageView : UIView{
    
    let label: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 30)
        label.text = "Starting..."
        label.textAlignment = .center
        return label
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = nil
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect){
        super.init(frame:frame)
        addSubview(label)
        addSubview(imageView)
        self.backgroundColor = UIColor.systemBlue
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder: has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
      
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(20)
            make.left.equalToSuperview().offset(20)
            make.width.equalTo(frame.size.width - 40)
            make.height.equalTo(frame.size.width - 40)
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
