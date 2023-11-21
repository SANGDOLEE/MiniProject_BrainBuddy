import UIKit

import SnapKit

extension UIColor {
    static var mainPink = UIColor(red: 232/255, green: 68/255, blue: 133/255, alpha: 1)
}

class OnboardingView: UIView {
    
    var currentPage = 0
    
    let mainImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    /// Onborading에 관한 Page를 관리하고 호출함
    func configure(with page: OnboardingPage) {
        mainImage.image = UIImage(named: page.imageName)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center

        let attributedText = NSMutableAttributedString()
        let titleString = NSAttributedString(
            string: page.attributedDescription.string,
            attributes: [
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 40),
                NSAttributedString.Key.foregroundColor: UIColor.systemGray5,
                NSAttributedString.Key.paragraphStyle: paragraphStyle
            ]
        )
        let descriptionString = NSAttributedString(
            string: "\n\n\(page.discriptionText.string)",
            attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24),
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.paragraphStyle: paragraphStyle
            ]
        )

        attributedText.append(titleString)
        attributedText.append(descriptionString)
        descriptionTextView.attributedText = attributedText
        descriptionTextView.backgroundColor = page.backColor
        backgroundColor = page.backColor // backColor 설정 추가
        // 추가적으로 다른 페이지에 필요한 설정도 수행할 수 있음
    }
    
    let previousButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("PREV", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let nextButton: UIButton = {
        let button = UIButton(type:.system)
        button.setTitle("NEXT", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let pageControl : UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = 4
        pc.currentPageIndicatorTintColor = .systemBlue
        pc.pageIndicatorTintColor = .white
        
        return pc
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        addSubview(mainImage)
        addSubview(descriptionTextView)
        addSubview(previousButton)
        addSubview(nextButton)
        
        setUpBottomControls()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder: has not been implemented")
    }
    
    
    fileprivate func setUpBottomControls() {
        
      
        let bottomControlsStackView = UIStackView(arrangedSubviews: [previousButton, pageControl, nextButton])
        
        bottomControlsStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomControlsStackView.distribution = .fillEqually
        
        self.addSubview(bottomControlsStackView)
        
        
        bottomControlsStackView.snp.makeConstraints { make in
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing)
            make.height.equalTo(50)
        }
        
    }
    
    private func setupLayout() {
        let topImageContainerView = UIView()
        addSubview(topImageContainerView)
        
        topImageContainerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.5)
        }
        
        topImageContainerView.addSubview(mainImage)
        mainImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(120)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().inset(20)
            make.height.equalToSuperview().multipliedBy(0.9)
        }
        
        descriptionTextView.snp.makeConstraints { make in
            make.top.equalTo(mainImage.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(100)
        }
        
    }
    
}
