import UIKit

class OnboardingController: UIViewController {
    
    private var onboardingView: OnboardingView! // 뷰 프로퍼티
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        onboardingView = OnboardingView(frame: view.bounds)
        view.addSubview(onboardingView)
        
        // 온보딩 PREV, NEXT 버튼
        onboardingView.previousButton.addTarget(self, action: #selector(previousButtonTapped), for: .touchUpInside)
        onboardingView.nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        
    }
    
    @objc private func previousButtonTapped() {
        
        guard onboardingView.currentPage > 0 else {
            
            return
        }
        onboardingView.currentPage -= 1
        onboardingView.pageControl.currentPage = onboardingView.currentPage
        
        if onboardingView.currentPage < 3 {
            onboardingView.nextButton.setTitle("NEXT", for: .normal)
        }
        
    }
    
    @objc private func nextButtonTapped() {
        
        guard onboardingView.currentPage < 3 else {
            
            hideOnboardingView() // 마지막페이지에서 "DONE" 터치시 호출
            return
        }
        
        onboardingView.currentPage += 1
        onboardingView.pageControl.currentPage = onboardingView.currentPage
        
        // 마지막 페이지로 갈시 "NEXT" -> "DONE"
        if onboardingView.currentPage == 3 {
            onboardingView.nextButton.setTitle("DONE", for: .normal)
        }
    }
    
    private func hideOnboardingView() {
        
        let collectionVC = CollectionViewController() // 이동할 뷰 컨트롤러 인스턴스 생성
        
        // 네비게이션 컨트롤러를 생성하고 컬렉션 뷰 컨트롤러로 전환
        let navigationController = UINavigationController(rootViewController: collectionVC)
        navigationController.modalPresentationStyle = .fullScreen
        
        // 컬렉션 뷰 컨트롤러로 화면 전환
        present(navigationController, animated: true, completion: nil)
    }
    
}
