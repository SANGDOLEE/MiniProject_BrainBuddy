//
//  ViewController.swift
//  StudyMemoryTest
//
//  Created by 이상도 on 2023/05/17.
//

import UIKit
import Vision

class ViewController: UIViewController {
    
    private var customView: CustomView! // 뷰
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView = CustomView(frame: view.bounds)
        view.addSubview(customView)
        
        customView.setImage(UIImage(named: "example1"))
        recognizerText(image: customView.imageView.image)
    }

    private func recognizerText(image: UIImage?) { // 이미지는 선택사항
        guard let cgImage = image?.cgImage else { return } // Ui 이미지의 CG이미지 버전을 얻는 것
        
        // Handler
        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        
        // Reqeust ( 텍스트 감지를 위한 요청 생성 )
        let request = VNRecognizeTextRequest{ [weak self] request, error in
            // 실제 관찰된 정보 가져오기 ( request.results = 관찰 / 여기에서 문자열을 가져오고 )
            guard let observations = request.results as? [VNRecognizedTextObservation],
                  error == nil else {
                return
            }
            
            // 압축매핑
            let text = observations.compactMap({
                $0.topCandidates(1).first?.string
            }).joined(separator:"\n") // 줄바꿈으로 구분
            
            DispatchQueue.main.async {
                self?.customView.setLabelText(text)
            }
        }
        
        // 텍스트 감지 언어 -> 한국어, 영어
        request.recognitionLevel = .accurate
        request.recognitionLanguages = ["ko","en"]
        request.usesLanguageCorrection = true
        request.revision = VNRecognizeTextRequestRevision3
        
        // Process request
        do {
            try handler.perform([request]) // Handler에서 요청 수행
        }
        catch {
            customView.setLabelText("\(error)")
        }
        
    }
    
    
    
    
}

