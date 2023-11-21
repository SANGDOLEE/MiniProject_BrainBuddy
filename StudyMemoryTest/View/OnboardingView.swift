import UIKit

import SnapKit

extension UIColor {
    static var mainPink = UIColor(red: 232/255, green: 68/255, blue: 133/255, alpha: 1)
}

// 온보딩 1 : + 버튼 눌러서 공부할 이미지 추가
// 온보딩 2 : 공부할 내용의 사진을 추가
// 온보딩 3 : 내가 암기한 내용들을 자유롭게 적어봅니다.
// 온보딩 4 : 정답보기를 눌러 정답을 확인하고 저장합니다 !

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
        
        func configure(with page: OnboardingPage) {
            mainImage.image = UIImage(named: page.imageName)

            let attributedText = NSMutableAttributedString(string: page.attributedDescription.string, attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)])
            attributedText.append(NSAttributedString(string: "\n\n\(page.attributedDescription.string)",
                                                     attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13),
                                                                  NSAttributedString.Key.foregroundColor: UIColor.gray]))

            descriptionTextView.attributedText = attributedText
            // 추가적으로 다른 페이지에 필요한 설정도 수행할 수 있음
        }
    
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
