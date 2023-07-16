//
//  RelatedNewsCollectionViewCell.swift
//  twofour54-ios
//
//  Created by Rama Shaaban on 24/02/2021.
//

import UIKit

class PlayerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var imageImageView: UIImageView!
    
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var cardView: CardView!
    
    var item: Player?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        self.cardView.delegate = self
            //   cardView.layer.cornerRadius = 10.0

      //  cardView.backgroundColor = .white

        // Set corner radius
        cardView.layer.cornerRadius = 8
//
//        // Set shadow
//        cardView.layer.shadowColor = UIColor.black.cgColor
//        cardView.layer.shadowOpacity = 0.5
//        cardView.layer.shadowOffset = CGSize(width: 2, height: 2)
//        cardView.layer.shadowRadius = 4.0
//
//        // Ensure the shadow and corner radius are visible
//        cardView.layer.masksToBounds = false
//
//        cardView.layer.shadowPath = UIBezierPath(roundedRect: cardView.bounds, cornerRadius: cardView.layer.cornerRadius).cgPath
//
//
      //  layer.cornerRadius = 12
             layer.shadowColor = UIColor.black.cgColor
             layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
             layer.shadowRadius = 4.0
             layer.masksToBounds = false

    }
    
    func configure(item: Player) {
        
        self.item = item
        
        self.titleLabel.text = item.name
        self.teamName.text = item.teamName
        if let url = item.photo {
            self.imageImageView.kf.setImage(with: URL(string: url))
        }
        
    }
    
}

extension PlayerCollectionViewCell: CardViewDelegate {
    func didTap(cardView: CardView) {
        if let item = self.item  {
       //     MainCoordinator.shared?.pushLawsByGovernmentDetailsVC(item: item)
        }
    }
    
    
}
