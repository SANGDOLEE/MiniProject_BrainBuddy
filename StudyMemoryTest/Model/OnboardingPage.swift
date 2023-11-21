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
    let discriptionText: NSAttributedString
    let pageNumber: Int
    let backColor: UIColor
}

extension OnboardingPage {
    static func page1() -> OnboardingPage {
        return OnboardingPage(
            imageName: "palette",
            attributedDescription: NSAttributedString(string: "Quick & Easy Payment", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 36)]),
            discriptionText: NSAttributedString(string: "우측 상단의 + 버튼을 터치하여 사진을 추가하는 화면으로 넘어갑니다.", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24)]),
            pageNumber: 0,
            backColor: .white
        )
    }
    
    static func page2() -> OnboardingPage {
        return OnboardingPage(
            imageName: "trash",
            attributedDescription: NSAttributedString(string: "텍스트로 변환", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 36)]),
            discriptionText: NSAttributedString(string: "텍스트로 변환하여 학습 할 사진을 앨범에서 추가하거나 촬영하세요.\n텍스트가 없을 시 다른 사진으로 재업로드 하세요.", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24)]),
            pageNumber: 1,
            backColor: .white
        )
    }
    
    static func page3() -> OnboardingPage {
        return OnboardingPage(
            imageName: "undo",
            attributedDescription: NSAttributedString(string: "학습", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 36)]),
            discriptionText: NSAttributedString(string: "본인이 암기했던 내용을 바탕으로 빈칸을 자유롭게 메모하며 적어보세요.", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24)]),
            pageNumber: 2,
            backColor: .white
        )
    }
    
    static func page4() -> OnboardingPage {
        return OnboardingPage(
            imageName: "redo",
            attributedDescription: NSAttributedString(string: "정답확인 및 저장", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 36)]),
            discriptionText: NSAttributedString(string: "정답을 확인하여 내가 적은 것과 실제 정답과 비교하여 채점해보세요.\n이후 해당 파일을 저장하여 나중에 다시 확인해보세요.", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24)]),
            pageNumber: 3,
            backColor: .white
        )
    }
}
