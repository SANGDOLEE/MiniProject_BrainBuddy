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
        
        
        userTestView.serveTextView.text = replaceCharacter(text: receivedText!) // image에서 변환된 text 전달 받기
        
    
        
        // Trash Undo Redo Palette
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
        
        userTestView.canvasView.drawingGestureRecognizer.addTarget(self, action: #selector(drawingStarted))
        
        // PKToolPicker : Palette
        setupCanvasView()
        setUpTool()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemBlue
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        appearance.shadowColor = .none
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    // 원본 text -> test용 text로 랜덤 인덱스 변환
    func replaceCharacter(text: String) -> String {
        let words = text.components(separatedBy: .whitespacesAndNewlines)
         let numberOfWordsToReplace = Int(ceil(Double(words.count) / 3.0))
         
         var modifiedWords = words
         var replacedWordIndices = Set<Int>()
         
         while replacedWordIndices.count < numberOfWordsToReplace {
             let randomIndex = Int.random(in: 0..<words.count)
             
             let word = words[randomIndex]
             if !isSpecialCharacter(word) && !isConsecutiveWordsReplaced(randomIndex, replacedWordIndices) {
                 replacedWordIndices.insert(randomIndex)
             }
         }
         
         var problemNumber = 1
         
         let sortedIndices = replacedWordIndices.sorted(by: <)
         
         for index in sortedIndices {
             let replacedWord = words[index]
             let replacedWordCount = replacedWord.count
             if replacedWordCount > 2 {
                 let numberOfUnderscores = replacedWordCount - 2
                 let underscores = String(repeating: "_", count: numberOfUnderscores)
                 let replacedWordWithNumber = "(\(problemNumber))\(underscores)"
                 modifiedWords[index] = replacedWordWithNumber
                 problemNumber += 1
             }
         }
         
         return modifiedWords.joined(separator: " ")
    }
    // 특수문자는 변환 금지
    func isSpecialCharacter(_ word: String) -> Bool {
        let specialCharacters = CharacterSet.punctuationCharacters.subtracting(CharacterSet(charactersIn: "_"))
        return word.rangeOfCharacter(from: specialCharacters) != nil
    }
    // 2개 연속 단어 변환 금지
    func isConsecutiveWordsReplaced(_ currentIndex: Int, _ replacedIndices: Set<Int>) -> Bool {
        if currentIndex > 0 && replacedIndices.contains(currentIndex - 1) {
            return true
        }
        if currentIndex < replacedIndices.count - 1 && replacedIndices.contains(currentIndex + 1) {
            return true
        }
        return false
    }
    
    
    @objc func drawingStarted() {
        userTestView.drawingLabel.isHidden = true
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
    
    // PKToolPicker : Palette
    @objc func paletteTapped() {
        print("팔레트 호출")
    }
    
    private func setupCanvasView() {
        userTestView.canvasView.allowsFingerDrawing = false
    }
    private func setUpTool() {
        if let window = UIApplication.shared.windows.first, let toolPicker =
            PKToolPicker.shared(for: window) {
            toolPicker.addObserver(userTestView.canvasView)
            toolPicker.setVisible(true, forFirstResponder: userTestView.canvasView)
            userTestView.canvasView.becomeFirstResponder()
        }
    }
    
    // CollectionView 저장
    @objc func saveTapped(){
        
    }
}

