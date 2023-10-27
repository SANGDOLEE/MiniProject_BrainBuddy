import UIKit

import SnapKit

let cellID = "Cell" /// Cell ID 등록
class MainCollectionView: UIView {
    
    let collectionView: UICollectionView = {
        let flowlayout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowlayout)
        return cv
    }()
    
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.backgroundColor = UIColor.tintColor
        
        addSubview(collectionView)
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.layer.cornerRadius = 10
        collectionView.layer.masksToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.left.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
            make.right.equalToSuperview()
            collectionView.backgroundColor = .tintColor
        }
        
    }
}
