//
//  OnboardingController.swift
//  StudyMemoryTest
//
//  Created by 이상도 on 2023/07/12.
//

import UIKit

class OnboardingController: UIViewController {

    private var onboardingView: OnboardingView! // 뷰 프로퍼티
    
    override func viewDidLoad() {
        super.viewDidLoad()

        onboardingView = OnboardingView(frame: view.bounds)
        view.addSubview(onboardingView)
        
        
        onboardingView.previousButton.addTarget(self, action: #selector(previousButtonTapped), for: .touchUpInside) // 온보딩 PREV 버튼
        onboardingView.nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside) // 온보딩 NEXT 버튼
        
    }
    
    @objc private func previousButtonTapped() {
        
        guard onboardingView.currentPage > 0 else {
            
            return
        }
        
        onboardingView.currentPage -= 1
        onboardingView.pageControl.currentPage = onboardingView.currentPage
        
    }
    @objc private func nextButtonTapped() {
        
        guard onboardingView.currentPage < 3 else {
            return
        }
        
        onboardingView.currentPage += 1
        onboardingView.pageControl.currentPage = onboardingView.currentPage
    }
    
}
