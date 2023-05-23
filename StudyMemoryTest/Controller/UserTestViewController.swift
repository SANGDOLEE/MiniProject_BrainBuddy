//
//  UserTestViewController.swift
//  StudyMemoryTest
//
//  Created by 이상도 on 2023/05/23.
//

import UIKit

class UserTestViewController: UIViewController {

    
    private var userTestView : UserTestView! // View
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userTestView = UserTestView(frame: view.bounds)
        view.addSubview(userTestView)
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
