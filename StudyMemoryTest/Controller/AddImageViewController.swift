//
//  AddImageViewController.swift
//  StudyMemoryTest
//
//  Created by 이상도 on 2023/05/18.
//

import UIKit
import AVFoundation
import Photos
import Vision

class AddImageViewController: UIViewController {
    
    private var addImageView : AddImageView! /// 뷰 프로퍼티
    
    var textTemp : String? /// Image -> Text 변환되어 임시저장 될 text변수
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        addImageView = AddImageView(frame: view.bounds)
        view.addSubview(addImageView)
        
        // MARK: 네비게이션
        title = "문제집"
        
        let backButton = UIBarButtonItem() /// UserTestVC에서 현재화면으로 돌아오는 버튼 설정
        backButton.title = ""
        backButton.tintColor = UIColor.white
        navigationItem.backBarButtonItem = backButton
        
        let addCameraButton = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(addCameraTapped)) /// 사진추가 버튼
        addCameraButton.tintColor = .white
        
        let trashButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(trashTapped)) /// 사진 삭제 버튼
        trashButton.tintColor = .white
        navigationItem.rightBarButtonItems = [ trashButton, addCameraButton ] // 네비게이션 버튼2개 배열로 할당
        
        let addImageTapGesture = UITapGestureRecognizer(target: self, action: #selector(moveAlbumTapped))  /// 앨범이미지 Touch -> 앨범 제스쳐
        addImageView.albumImageView.addGestureRecognizer(addImageTapGesture)
        addImageView.albumImageView.isUserInteractionEnabled = true
        addImageView.setImage(nil)
        recognizerText(image: addImageView.imageView.image)
        
        addImageView.button.addTarget(self, action: #selector(smartButtonTapped(_:)), for: .touchUpInside) /// 스마트출제 버튼
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let appearance = UINavigationBarAppearance() /// 네비게이션 바 타이틀 컬러 고정 및 네비게이션 설정
        appearance.backgroundColor = .tintColor
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.shadowColor = .none
        navigationController?.navigationBar.tintColor = .tintColor
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.standardAppearance = appearance
    }
    
    /// 스마트 출제 버튼
    @IBAction func smartButtonTapped(_ sender: UIButton) {
        print("스마트 출제 터치됨")
        
        if addImageView.imageView.image != nil { /// 사진이 있는데
            if !addImageView.textView.text.isEmpty { /// 텍스트도 있는데
                let nextVC = UserTestViewController()
                nextVC.receivedText = self.textTemp
                navigationController?.pushViewController(nextVC, animated: true)
            } else { /// 사진은 있는데, 변환된 텍스트는 없는 사진이면
                addImageView.button.isEnabled = false
                showTextPhotoAlert()
            }
        } else {
            addImageView.button.isEnabled = false
            showPhotoAlert()
        }
    }
    
    /// 사진관련 알림 메소드
    func showPhotoAlert() {
        let alert = UIAlertController(title: "알림", message: "사진을 추가해주세요.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default) { _ in
            self.addImageView.button.isEnabled = true
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    func showTextPhotoAlert() {
        let alert = UIAlertController(title: "알림", message: "해당 사진은 텍스트로 변환될 수 없습니다.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default) { _ in
            self.addImageView.button.isEnabled = true
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    
    // Visision : Image -> Text
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
                self?.addImageView.setTextViewText(text)
                self?.textTemp = text
            }
            
        }
        
        // 텍스트 감지 언어 -> 한국어, 영어
        request.recognitionLevel = .accurate
        request.recognitionLanguages = ["ko","en","zh-Hans","ja"]
        request.usesLanguageCorrection = true
        request.revision = VNRecognizeTextRequestRevision3
        
        // Process request
        do {
            try handler.perform([request]) // Handler에서 요청 수행
        }
        catch {
            addImageView.setTextViewText("\(error)")
        }
    }
    
    
    
    // 카메라 선택
    @objc func addCameraTapped() {
        checkCameraPermissions()
        checkAlbumPermission()
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        let alertController = UIAlertController(title: "사진 선택", message: nil, preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "카메라", style: .default) { _ in
            imagePicker.sourceType = .camera
            self.present(imagePicker, animated: true, completion: nil)
        }
        alertController.addAction(cameraAction)
        
        let albumAction = UIAlertAction(title: "앨범", style: .default) { _ in
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }
        alertController.addAction(albumAction)
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        if let popoverController = alertController.popoverPresentationController {
            popoverController.barButtonItem = navigationItem.rightBarButtonItem
        }
        
        present(alertController, animated: true, completion: nil)
        
    }
    @objc func moveAlbumTapped() {
        addCameraTapped()
    }
    
    // Camera -> 사진 추가 or 취소
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let image = info[.originalImage] as? UIImage {
            addImageView.imageView.image = image
            recognizerText(image: image)
        }
        addImageView.photoLabel.isHidden = true // 사진이 선택되면 Label 숨김
        addImageView.albumImageView.isHidden = true // 사진이 선택되면 albumImage 숨김
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    // 카메라 Permission
    func checkCameraPermissions() {
        AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
            if granted {
                print("Camera: 권한 허용")
            } else {
                print("Camera: 권한 거부")
            }
            
        })
    }
    // 앨범 Permission
    func checkAlbumPermission() {
        PHPhotoLibrary.requestAuthorization( { status in
            switch status {
            case .authorized:
                print("Album : 권한 허용")
            case .denied:
                print("Album : 권한 거부")
            case .restricted, .notDetermined:
                print("Album : 선택되지 않음")
            default:
                break
            }
        })
    }
    
    // imageView에 추가된 image, text 제거
    @objc func trashTapped() {
        addImageView.imageView.image = nil
        addImageView.textView.text = nil
        
        addImageView.photoLabel.isHidden = false // 사진이 선택되면 Label 숨김
        addImageView.albumImageView.isHidden = false
    }

}

extension AddImageViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    
}
