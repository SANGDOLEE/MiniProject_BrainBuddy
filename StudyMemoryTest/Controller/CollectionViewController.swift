import UIKit
import PencilKit
import CoreData

class CollectionViewController: UIViewController {
    
    private var mainView : MainCollectionView! /// 뷰 프로퍼티
    private var canvasData: [CanvasData] = [] /// CoreData데이터 배열
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView = MainCollectionView(frame: view.bounds)
        view.addSubview(mainView)
        
        mainView.collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        
        fetchCanvasData() /// CoreData 데이터 가져오기
        
        // MARK: 네비게이션
        title = "오늘의 암기"
        
        let backButton = UIBarButtonItem() /// AddImageVC에서 현재화면으로 돌아오는 버튼 설정
        backButton.title = ""
        backButton.tintColor = UIColor.white
        navigationItem.backBarButtonItem = backButton
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped)) /// 문제집 추가하는 버튼 설정
        addButton.tintColor = .white
        navigationItem.rightBarButtonItem = addButton
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let apperance = UINavigationBarAppearance() /// 네비게이션 바 타이틀 컬러 고정
        apperance.backgroundColor = .systemBlue
        apperance.titleTextAttributes = [.foregroundColor: UIColor.white]
        apperance.shadowColor = .none
        navigationController?.navigationBar.scrollEdgeAppearance = apperance
    }
    
    // 이미지 추가하기로 넘어가는 메소드
    @objc func addButtonTapped() {
        let addImageViewController = AddImageViewController()
        navigationController?.pushViewController(addImageViewController, animated: true)
        
    }
    
    // CoreData에서 CanvasData 가져오기
    func fetchCanvasData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<CanvasData> = CanvasData.fetchRequest()
        
        do {
            self.canvasData = try context.fetch(fetchRequest)
            mainView.collectionView.reloadData()
        } catch {
            print("데이터 검색 실패: \(error.localizedDescription)")
        }
    }
}

// MARK: 콜렉션 뷰
extension CollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return canvasData.count
    }
    
    func captureScreen() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, UIScreen.main.scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        view.layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = mainView.collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        
        let reversedIndex = canvasData.count - 1 - indexPath.item /// 역순 인덱스 계산 ( 사용자가 저장하는 데이터 최신일수록 cell 0번에 )
            
            if reversedIndex >= 0 && reversedIndex < canvasData.count {
                let canvas = canvasData[reversedIndex]
                if let imageData = canvas.imageData, let image = UIImage(data: imageData) {
                    cell.configure(with: image)
                }
            }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedData = canvasData[indexPath.row] // dataSource는 적절한 데이터 소스 배열이어야 합니다.
            
            // UserTestViewController 인스턴스 생성 및 초기화
            let userTestViewController = UserTestViewController()
            
            // 필요한 데이터 설정
            userTestViewController.receivedText = selectedData.receivedText
        userTestViewController.pasteReceivedText = selectedData.pasteReceivedText!
            userTestViewController.originalText = selectedData.originalText
            
            // canvasState 설정
            if let canvasStateData = selectedData.canvasState,
               let canvasState = NSKeyedUnarchiver.unarchiveObject(with: canvasStateData as! Data) as? PKDrawing {
                // 사용자 테스트 뷰 컨트롤러의 canvasView 설정
                userTestViewController.loadViewIfNeeded() // userTestView 로드
                userTestViewController.userTestView.canvasView.drawing = canvasState
            }
            
            // UserTestViewController 화면으로 이동
            navigationController?.pushViewController(userTestViewController, animated: true)
    }
}

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width - 40) / 4.5, height: (view.frame.width - 40) / 4.5) /// cell size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 22  /// cell 사이 간격
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20) /// cell과 view의 간격
    }
    
}
