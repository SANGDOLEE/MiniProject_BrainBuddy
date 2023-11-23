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
        
        let subViewcornerRadius : CGFloat = 30.0
        subView.layer.cornerRadius = subViewcornerRadius
        subView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        subView.layer.masksToBounds = true
        
        return subView
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = nil
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let photoLabel : UILabel = {
        let photolabel = UILabel()
        photolabel.text = "학습 할 사진을 추가해주세요."
        photolabel.textColor = .systemGray6
        return photolabel
    }()
    
    let albumImageView: UIImageView = {
        let albumImageView = UIImageView()
        albumImageView.image = UIImage(named: "AlbumImage")
        return albumImageView
    }()
    
    let textView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .white
        textView.font = UIFont.systemFont(ofSize: 24)
        textView.text = ""
        textView.textAlignment = .center
        textView.isEditable = false
        
        textView.layer.borderWidth = 1.0
        textView.layer.borderColor = UIColor.systemGray6.cgColor
        
        let textViewCornerRadius : CGFloat = 30.0
        textView.layer.cornerRadius = textViewCornerRadius
        textView.layer.masksToBounds = true
        
        return textView
    }()
    
    let button: UIButton = {
        let button = UIButton()
        button.setTitle("학습 시작", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        button.backgroundColor = UIColor.tintColor
        button.setTitleColor(UIColor.white, for: .normal)
        
        let buttonCornerRadius : CGFloat = 20.0
        button.layer.cornerRadius = buttonCornerRadius
        button.layer.masksToBounds = true
        
        return button
    }()
    
    // MARK: 이니셜라이저
    override init(frame: CGRect){
        super.init(frame:frame)
        addSubview(mainView)
        addSubview(subView)
        addSubview(photoLabel)
        addSubview(albumImageView)
        mainView.addSubview(imageView)
        mainView.addSubview(photoLabel)
        mainView.addSubview(albumImageView)
        
        
        addSubview(textView)
        addSubview(button)
        subView.addSubview(textView)
        subView.addSubview(button)
        
        self.backgroundColor = UIColor.tintColor /// 슈퍼뷰 배경색
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder: has not been implemented")
    }
    
    // MARK: 뷰 - 스냅킷
    override func layoutSubviews() {
        super.layoutSubviews()
        
        mainView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.topMargin).offset(20)
            make.width.equalToSuperview()
            make.height.equalToSuperview().dividedBy(3) /// Height = 해상도의 1/3
            make.left.right.equalToSuperview()
        }
        
        subView.snp.makeConstraints { make in
            make.top.equalTo(mainView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(mainView.snp.top).offset(10)
            make.left.equalTo(mainView.snp.left).offset(10)
            make.right.equalTo(mainView.snp.right).offset(-10)
            make.bottom.equalTo(mainView.snp.bottom).offset(-10)
        }
        
        photoLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        albumImageView.snp.makeConstraints { make in
            let size = UIScreen.main.bounds.width * 0.06 /// 현재 시뮬레이터의 화면 너비
            make.width.height.equalTo(size)
            make.bottom.equalTo(photoLabel.snp.top).offset(-10)
            make.centerX.equalToSuperview()
        }
        
        textView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalToSuperview().multipliedBy(0.8) /// superView의 75% 높이 일관
        }
        
        button.snp.makeConstraints{ make in
            make.width.equalToSuperview().multipliedBy(0.25) /// width = 스크린 길이의 1/4
            make.height.equalToSuperview().multipliedBy(0.1) /// height
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(30)
            make.top.equalTo(textView.snp.bottom).offset(30)
        }
    }
    
    func setImage(_ image: UIImage?){
        imageView.image = image
    }
    
    func setTextViewText(_ text: String) {
         textView.text = text
    }
}
