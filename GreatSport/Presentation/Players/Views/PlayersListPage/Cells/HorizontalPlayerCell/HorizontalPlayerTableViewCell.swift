//
//  MostPopularLawsTableViewCell.swift
//  Mawa
//
//  Created by Rama Shaaban on 22/02/2022.
//

import UIKit

class HorizontalPlayerTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    
    var items: [Player] = []
    
  //  var delegate: LawsTableViewCellProtocol?
    
 
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.configure()
        
   //     collectionViewHeight.constant = ((screenWidth / 1.3) * 0.6) + 16

    }

    func configure() {
     
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "PlayerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PlayerCollectionViewCell")
    }
    
    func configure(items: [Player]) {
        self.items = items
       
        self.collectionView.reloadData()
        
    }
    
}


extension HorizontalPlayerTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlayerCollectionViewCell", for: indexPath) as? PlayerCollectionViewCell {
            cell.configure(item: self.items[indexPath.row])
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w = collectionView.frame.width / 1.3
        return CGSize(width: 136, height: 186)
    }
//
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
}

//extension HorizontalPlayerTableViewCell: RoundedViewDelegate {
//    func didTap(roundedView: RoundedView) {
//        MainCoordinator.shared?.push(destination: .AllLaws)
//    }
//
//}
