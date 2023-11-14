import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    private var imageView: UIImageView!
    
    // 삭제할 때 Edit 모드에서 Cell 선택 시 색상 변화
    override var isSelected: Bool {
        didSet {
            // Edit 모드에서만 알파값 변경
            if let collectionView = self.superview as? UICollectionView, collectionView.isEditing {
                updateSelectedState()
            }
        }
    }
    
    func configure(with image: UIImage) {
        // 이미지 뷰가 nil이면 초기화
        if imageView == nil {
            imageView = UIImageView(frame: contentView.bounds)
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            contentView.addSubview(imageView)
        }
        imageView.image = image
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        updateSelectedState()
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        self.layer.cornerRadius = 30
        self.layer.masksToBounds = true
        self.backgroundColor = .systemRed
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 선택 상태에 따라 UI 업데이트
    private func updateSelectedState() {
        if let collectionView = self.superview as? UICollectionView, collectionView.isEditing {
            UIView.animate(withDuration: 0.3) {
                self.alpha = self.isSelected ? 0.5 : 1.0
            }
        }
    }
}
