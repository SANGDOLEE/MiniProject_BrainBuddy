import UIKit
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
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = mainView.collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        let canvas = canvasData[indexPath.item]
        cell.configure(with:canvas)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        ///
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
