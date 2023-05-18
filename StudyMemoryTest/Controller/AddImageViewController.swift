//
//  AddImageViewController.swift
//  StudyMemoryTest
//
//  Created by 이상도 on 2023/05/18.
//

import UIKit
import AVFoundation
import Photos

class AddImageViewController: UIViewController {
    
    private var addImageView : AddImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addImageView = AddImageView(frame: view.bounds)
        view.addSubview(addImageView)
        
        // MARK: 네비게이션
        title = "오늘의 문제집" // 네비게이션 타이틀 제목
        navigationController?.navigationBar.tintColor = UIColor.black
        
        let addCameraButton = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(addCameraTapped))
        addCameraButton.tintColor = .black
        
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTapped))
        saveButton.tintColor = .black
        
        navigationItem.rightBarButtonItems = [ saveButton, addCameraButton ] // 네비게이션 버튼2개 배열로 할당
        
        /*
         let navigationBar = UINavigationBar(frame: CGRect(x:0, y:0, width:view.frame.size.width, height:view.frame.size.height))
         navigationBar.backgroundColor = .systemBlue
         
         let navigationItem = UINavigationItem(title: "오늘의 문제집")
         navigationBar.items = [navigationItem]
         view.addSubview(navigationBar)
         */
        
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
    // 카메라 Permission 함수
    func checkCameraPermissions() {
        AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
            if granted {
                print("Camera: 권한 허용")
            } else {
                print("Camera: 권한 거부")
            }
            
        })
    }
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
    
    @objc func saveTapped() {
        
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}


extension AddImageViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    
}
