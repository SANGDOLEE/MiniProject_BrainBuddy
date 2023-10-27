import UIKit

import SnapKit

extension UIColor {
    static var mainPink = UIColor(red: 232/255, green: 68/255, blue: 133/255, alpha: 1)
}

class OnboardingView: UIView {
    
    var currentPage = 0
    
    let mainImage: UIImageView = {
        let imageView = UIImageView()
        let profile = UIImage(named: "onboard")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = profile
        return imageView
    }()
    
    let descriptionTextView: UITextView = {
        let textView = UITextView()
        
        let attributedText = NSMutableAttributedString(string: "Join us today in our fun lunch!",attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)])
        
        attributedText.append(NSAttributedString(string: "\n\nAre you ready for loadsd and loads for fun? Don't wait any longer! We hope to see you in our event today.",
                                                 attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13),
                                                              NSAttributedString.Key.foregroundColor: UIColor.gray]))
        
        textView.attributedText = attributedText
        
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        return textView
    }()
    
    let previousButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("PREV", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.gray, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let nextButton: UIButton = {
        let button = UIButton(type:.system)
        button.setTitle("NEXT", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.gray, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let pageControl : UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = 4
        pc.currentPageIndicatorTintColor = .systemBlue
        pc.pageIndicatorTintColor = .gray
        
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
        
        let yellowView = UIView()
        yellowView.backgroundColor = .yellow
        
        let greenView = UIView()
        greenView.backgroundColor = .green
        
        let blueView = UIView()
        blueView.backgroundColor = .blue
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
            make.centerX.centerY.equalToSuperview()
            make.height.equalTo(200)
            make.width.equalTo(200)
        }
        
        descriptionTextView.snp.makeConstraints { make in
            make.top.equalTo(mainImage.snp.bottom)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().inset(24)
            make.bottom.equalToSuperview()
        }
        
    }
   
}
