import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    func configure(with canvas: CanvasData) {
        
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
}
