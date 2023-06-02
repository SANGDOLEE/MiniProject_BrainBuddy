//
//  UserTestViewController.swift
//  StudyMemoryTest
//
//  Created by 이상도 on 2023/05/23.
//

import UIKit

class UserTestViewController: UIViewController {
    
    public var userTestView : UserTestView! // View
    
    
    var receivedText: String? // 전달받는 텍스트 변수
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userTestView = UserTestView(frame: view.bounds)
        view.addSubview(userTestView)
        
        /// 네비게이션
        title = "테스트"
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTapped))
        saveButton.tintColor = .black
        navigationItem.rightBarButtonItem = saveButton
        
        let userTestAppearance = UINavigationBarAppearance()
        userTestAppearance.backgroundColor = .white
        userTestAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        userTestAppearance.shadowColor = .clear
        //navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.scrollEdgeAppearance = userTestAppearance
        navigationController?.navigationBar.standardAppearance = userTestAppearance
        
        
        userTestView.serveTextView.text = receivedText // image에서 변환된 text 전달 받기
        
     
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemBlue
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        appearance.shadowColor = .none
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    @objc private func undoButtonTapped() {
      
    }
    
    @objc private func redoButtonTapped() {
        
    }
    
    @objc func saveTapped(){
        
    }
}
