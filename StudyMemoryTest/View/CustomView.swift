//
//  CustomView.swift
//  StudyMemoryTest
//
//  Created by 이상도 on 2023/05/17.
//

import UIKit
import Vision

class CustomView: UIView {
    
    let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Starting..."
        label.textAlignment = .center
        return label
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named:"example1")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect){
        super.init(frame:frame)
        addSubview(label)
        addSubview(imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = CGRect(x: 20, y: safeAreaInsets.top, width: frame.size.width-40, height: frame.size.width-40)
        label.frame = CGRect(x: 20,
                             y: frame.size.width + safeAreaInsets.top,
                             width:frame.size.width-40,
                             height:200)
    }
    
    func setImage(_ image: UIImage?){
        imageView.image = image
    }
    
    func setLabelText(_ text: String) {
        label.text = text
    }
}


