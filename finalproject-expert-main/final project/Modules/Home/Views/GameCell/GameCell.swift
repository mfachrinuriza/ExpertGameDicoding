//
//  GameCell.swift
//  final project
//
//  Created by Muhammad Fachri Nuriza on 09/10/22.
//

import UIKit
import RxCocoa
import RxSwift
import Cores

class GameCell: UITableViewCell {
    @IBOutlet weak var iconStar: UIImageView!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var btnDelete: UIButton!
    
    static let cellIdentifier = "GameCell"
    var disposeBag = DisposeBag()
    
    var onDelete: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setupUI() {
        iconStar.image = UIImage(named: "ic_star", in: Bundle(identifier: CoreBundle.getIdentifier()), compatibleWith: nil)
        btnDelete.setImage(UIImage(named: "ic_trash_black", in: Bundle(identifier: CoreBundle.getIdentifier()), compatibleWith: nil), for: .normal)
    }
    
    override func prepareForReuse() {
        disposeBag = DisposeBag()
    }
    
    func update(data: Game, isDeleteEnable: Bool? = false) {
        if let url = URL(string: data.background_image!) {
            backgroundImage.kf.setImage(with: url)
        }
        
        btnDelete.isHidden = isDeleteEnable ?? false ? false : true

        title.text = data.name
        rating.text = "\(data.rating ?? 0)"
    }
    
    @IBAction func btnDeleteTapped(_ sender: Any) {
        self.onDelete?()
    }
}
