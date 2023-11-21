//
//  OnboardingPage.swift
//  StudyMemoryTest
//
//  Created by 이상도 on 2023/11/17.
//

import Foundation
import UIKit

struct OnboardingPage {
    let imageName: String
    let attributedDescription: NSAttributedString
    let pageNumber: Int
}

extension OnboardingPage {
    static func page1() -> OnboardingPage {
        return OnboardingPage(
            imageName: "page1Image",
            attributedDescription: NSAttributedString(string: "첫 번째 온보딩 페이지 설명", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]),
            pageNumber: 0
        )
    }
    
    static func page2() -> OnboardingPage {
        return OnboardingPage(
            imageName: "trash",
            attributedDescription: NSAttributedString(string: "두 번째 온보딩 페이지 설명", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]),
            pageNumber: 1
        )
    }
    
    static func page3() -> OnboardingPage {
        return OnboardingPage(
            imageName: "undo",
            attributedDescription: NSAttributedString(string: "세 번째 온보딩 페이지 설명", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]),
            pageNumber: 2
        )
    }
    
    static func page4() -> OnboardingPage {
        return OnboardingPage(
            imageName: "redo",
            attributedDescription: NSAttributedString(string: "네 번째 온보딩 페이지 설명", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]),
            pageNumber: 3
        )
    }
}
