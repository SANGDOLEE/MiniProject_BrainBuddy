//
//  AddImageViewController.swift
//  StudyMemoryTest
//
//  Created by 이상도 on 2023/05/18.
//

import UIKit
import AVFoundation

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
    
    @objc func addCameraTapped() {
        checkCameraPermissions()
        
        
        
        
    }
    
    func checkCameraPermissions() {
        AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
            if granted {
                print("Camera: 권한 허용")
            } else {
                print("Camera: 권한 거부")
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
