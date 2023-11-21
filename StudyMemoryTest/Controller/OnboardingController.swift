import UIKit

import UIKit

class OnboardingController: UIViewController {

    private var onboardingView: OnboardingView!
    
    private let onboardingPages: [OnboardingPage] = [
        OnboardingPage.page1(),
        OnboardingPage.page2(),
        OnboardingPage.page3(),
        OnboardingPage.page4()
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        onboardingView = OnboardingView(frame: view.bounds)
        view.addSubview(onboardingView)

        // 초기 페이지 설정
        onboardingView.configure(with: onboardingPages[0])
        
        // 온보딩 PREV, NEXT 버튼
        onboardingView.skipButton.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
        onboardingView.previousButton.addTarget(self, action: #selector(previousButtonTapped), for: .touchUpInside)
        onboardingView.nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        
    }

    @objc private func skipButtonTapped() {
        hideOnboardingView()
    }
    
    @objc private func previousButtonTapped() {
        guard onboardingView.currentPage > 0 else {
            return
        }
        onboardingView.currentPage -= 1
        onboardingView.pageControl.currentPage = onboardingView.currentPage
        onboardingView.configure(with: onboardingPages[onboardingView.currentPage])
        onboardingView.nextButton.setTitle("NEXT", for: .normal)
    }

    @objc private func nextButtonTapped() {
        guard onboardingView.currentPage < onboardingPages.count - 1 else {
            hideOnboardingView()
            return
        }

        onboardingView.currentPage += 1
        onboardingView.pageControl.currentPage = onboardingView.currentPage
        onboardingView.configure(with: onboardingPages[onboardingView.currentPage])

        if onboardingView.currentPage == onboardingPages.count - 1 {
            onboardingView.nextButton.setTitle("DONE", for: .normal)
        } else {
            onboardingView.nextButton.setTitle("NEXT", for: .normal)
        }
    }

    private func hideOnboardingView() {
        let collectionVC = CollectionViewController()
        let navigationController = UINavigationController(rootViewController: collectionVC)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true, completion: nil)
    }
}
