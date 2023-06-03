//
//  UserTestViewController.swift
//  StudyMemoryTest
//
//  Created by 이상도 on 2023/05/23.
//

import UIKit
import PencilKit

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
        
     
        /// trash undo redo palette
        let undoTapGesture = UITapGestureRecognizer(target: self, action: #selector(undoTapped))
        userTestView.undoImageButton.addGestureRecognizer(undoTapGesture)
        userTestView.undoImageButton.isUserInteractionEnabled = true
        
        let redoTapGesture = UITapGestureRecognizer(target: self, action: #selector(redoTapped))
        userTestView.redoImageButton.addGestureRecognizer(redoTapGesture)
        userTestView.redoImageButton.isUserInteractionEnabled = true
        
        let trashTapGesture = UITapGestureRecognizer(target: self, action: #selector(trashTapped))
        userTestView.trashImageButton.addGestureRecognizer(trashTapGesture)
        userTestView.trashImageButton.isUserInteractionEnabled = true
        
        let paletteTapGesture = UITapGestureRecognizer(target: self, action: #selector(paletteTapped))
        userTestView.paletteImageButton.addGestureRecognizer(paletteTapGesture)
        userTestView.paletteImageButton.isUserInteractionEnabled = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemBlue
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        appearance.shadowColor = .none
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    
    @objc private func trashTapped() {
        clearCanvas()
    }
    func clearCanvas(){
        userTestView.canvasView.drawing = PKDrawing()
    }
    
    @objc private func undoTapped() {
        userTestView.canvasView.undoManager?.undo()
    }
    
    @objc private func redoTapped() {
        userTestView.canvasView.undoManager?.redo()
    }
    
    @objc func paletteTapped() {
       
    }
    
    @objc func saveTapped(){
        
    }
}
