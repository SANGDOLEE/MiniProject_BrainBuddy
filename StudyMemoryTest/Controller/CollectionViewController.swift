import UIKit
import PencilKit
import CoreData

class CollectionViewController: UIViewController {
    
    public var mainView : MainCollectionView! /// 뷰 프로퍼티
    private var canvasData: [CanvasData] = [] /// CoreData데이터 배열
    
    private var selectedIndexPaths: [IndexPath] = [] // Cell 삭제용 배열
    
    /// 전역변수로 선언
    var addButton: UIBarButtonItem!
    var deleteButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView = MainCollectionView(frame: view.bounds)
        view.addSubview(mainView)
        
        mainView.collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.collectionView.allowsSelection = true // Cell Delete할때 선택가능하게
        mainView.collectionView.allowsMultipleSelection = true
        mainView.collectionView.allowsSelectionDuringEditing = true
        
        fetchCanvasData() /// CoreData 데이터 가져오기
        
        // MARK: 네비게이션
        title = "오늘의 암기"
        
        let backButton = UIBarButtonItem() /// AddImageVC에서 현재화면으로 돌아오는 버튼 설정
        backButton.title = ""
        backButton.tintColor = UIColor.white
        navigationItem.backBarButtonItem = backButton
        
        addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped)) /// 문제집 추가하는 버튼 설정
        addButton.tintColor = .white
        
        // 처음에는 addButton를 보여줍니다.
        navigationItem.rightBarButtonItem = addButton
        
        let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editButtonTapped))
        editButton.tintColor = .white
        navigationItem.leftBarButtonItem = editButton
        
        deleteButton = UIBarButtonItem(title: "Delete", style: .plain, target: self, action: #selector(deleteButtonTapped))
        deleteButton.tintColor = .red
        
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
    
    @objc func editButtonTapped() {
        if mainView.collectionView.isEditing {
            mainView.collectionView.isEditing = false
            mainView.collectionView.allowsMultipleSelection = false
            navigationItem.leftBarButtonItem?.title = "Edit"
            navigationItem.setRightBarButton(addButton, animated: true)
        } else {
            mainView.collectionView.isEditing = true
            mainView.collectionView.allowsMultipleSelection = true
            navigationItem.leftBarButtonItem?.title = "Done"
            navigationItem.setRightBarButton(deleteButton, animated: true)
        }
        
    }
    @objc func deleteButtonTapped() {
        // 선택한 셀을 삭제
        for indexPath in selectedIndexPaths {
            let selectedItem = indexPath.item
            if selectedItem >= 0 && selectedItem < canvasData.count {
                let selectedCanvas = canvasData[selectedItem]
                deleteCanvasData(selectedCanvas)
            }
        }
        
        // 삭제한 후 선택 상태 초기화
        mainView.collectionView.indexPathsForSelectedItems?.forEach {
            mainView.collectionView.deselectItem(at: $0, animated: false)
        }
        
        // 선택 배열 초기화
        selectedIndexPaths.removeAll()
        
        // 삭제한 후 테이블 뷰 업데이트
        fetchCanvasData()
    }
    
    func deleteCanvasData(_ canvas: CanvasData) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        context.delete(canvas)
        
        do {
            try context.save()
            fetchCanvasData()
        } catch {
            print("데이터 삭제 실패: \(error.localizedDescription)")
        }
    }
    
    // CoreData에서 CanvasData 가져오기
    func fetchCanvasData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<CanvasData> = CanvasData.fetchRequest()
        
        do {
            var fetchedData = try context.fetch(fetchRequest)
            fetchedData.reverse() // 데이터 배열의 순서를 역순으로 변경
            
            self.canvasData = fetchedData
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
        
        let reversedIndex = indexPath.item
        
        if reversedIndex >= 0 && reversedIndex < canvasData.count {
            let canvas = canvasData[reversedIndex]
            if let imageData = canvas.imageData, let image = UIImage(data: imageData) {
                cell.configure(with: image)
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if mainView.collectionView.isEditing {
               // Edit 모드에서는 해당 셀을 선택한 셀 배열에 추가
               if !selectedIndexPaths.contains(indexPath) {
                   selectedIndexPaths.append(indexPath)
               }
           } else {
               // Edit 모드가 아닌 경우, 해당 셀의 내용을 보여주기 위해 기존 코드 사용
               let selectedData = canvasData[indexPath.item]
               
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
               userTestViewController.selectedCanvasData = selectedData // 선택한 데이터 전달
               navigationController?.pushViewController(userTestViewController, animated: true)
           }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if mainView.collectionView.isEditing {
               // Edit 모드에서는 해당 셀을 선택한 셀 배열에서 제거
               if let index = selectedIndexPaths.firstIndex(of: indexPath) {
                   selectedIndexPaths.remove(at: index)
               }
           }
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
