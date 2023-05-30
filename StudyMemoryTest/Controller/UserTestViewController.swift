//
//  UserTestViewController.swift
//  StudyMemoryTest
//
//  Created by 이상도 on 2023/05/23.
//

import UIKit

class UserTestViewController: UIViewController {
    
    public var userTestView : UserTestView! // View
    private var addImageView : AddImageView!
    
    var receivedText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "테스트"
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTapped))
        saveButton.tintColor = .white
        navigationItem.rightBarButtonItem = saveButton
        
        
        userTestView = UserTestView(frame: view.bounds)
        view.addSubview(userTestView)
        
        userTestView.serveTextView.text = receivedText
        
        
        
    }
    
    @objc func saveTapped(){
        
    }
}
