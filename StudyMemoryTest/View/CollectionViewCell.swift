import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    private var imageView: UIImageView!
    
 
    func configure(with image: UIImage) {
        imageView.image = image
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        imageView = UIImageView(frame: contentView.bounds)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)
        
        self.layer.cornerRadius = 30
        self.layer.masksToBounds = true
        self.backgroundColor = .systemRed
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
