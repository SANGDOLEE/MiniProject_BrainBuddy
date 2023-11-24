import UIKit

import SnapKit

extension UIColor {
    static var mainPink = UIColor(red: 232/255, green: 68/255, blue: 133/255, alpha: 1)
}

class OnboardingView: UIView {
    
    var currentPage = 0
    
    let skipButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Skip", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        button.setTitleColor(.tintColor, for: .normal)
        button.backgroundColor = UIColor.white
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
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
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 42, weight: .bold),
                NSAttributedString.Key.foregroundColor: UIColor.tintColor,
                NSAttributedString.Key.paragraphStyle: paragraphStyle
            ]
        )

        let descriptionString = NSAttributedString(
            string: "\n\n\(page.discriptionText.string)",
            attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: .regular),
                NSAttributedString.Key.foregroundColor: UIColor.systemGray2,
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
        button.setTitle("Prev", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.tintColor
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let viewCornerRadius : CGFloat = 30
        button.layer.cornerRadius = viewCornerRadius
        button.layer.masksToBounds = true
        
        return button
    }()
    
    let nextButton: UIButton = {
        let button = UIButton(type:.system)
        button.setTitle("Next", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.tintColor
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let viewCornerRadius : CGFloat = 30
        button.layer.cornerRadius = viewCornerRadius
        button.layer.masksToBounds = true
        
        return button
    }()
    
    let pageControl : UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = 4
        pc.currentPageIndicatorTintColor = .systemBlue
        pc.pageIndicatorTintColor = .systemGray5
        
        return pc
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        addSubview(skipButton)
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
        
        skipButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.right.equalToSuperview().inset(60)
        }
        
        previousButton.snp.makeConstraints { make in
            make.width.equalTo(200)
        }

        nextButton.snp.makeConstraints { make in
            make.width.equalTo(200)
        }
        
        let bottomControlsStackView = UIStackView(arrangedSubviews: [previousButton, pageControl, nextButton])

        bottomControlsStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomControlsStackView.distribution = .fill

        self.addSubview(bottomControlsStackView)

        bottomControlsStackView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(50)
            make.left.equalToSuperview().offset(60)
            make.right.equalToSuperview().inset(60)
            make.height.equalTo(60)
        }
    }

    
    private func setupLayout() {
        let topImageContainerView = UIView()
        addSubview(topImageContainerView)
        
        topImageContainerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        mainImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(120) // Adjust the top offset as needed
            make.left.equalToSuperview().offset(60)
            make.right.equalToSuperview().inset(60)
            // Set the height to be 2/3 of the screen height
            make.height.equalToSuperview().multipliedBy(2.5 / 5.0)
        }
        
        descriptionTextView.snp.makeConstraints { make in
            make.top.equalTo(mainImage.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(100)
        }
    }

    
}
