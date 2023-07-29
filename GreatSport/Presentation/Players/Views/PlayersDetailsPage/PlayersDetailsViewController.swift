//
//  ArticleDetailsViewController.swift
//  GithubApiSample
//
//  Created by Hiba on 24/05/2023.
//

import UIKit

class PlayersDetailsViewController: UIViewController {
    
    @IBOutlet weak var playerName: UILabel!
    
    @IBOutlet weak var playerNumber: UILabel!
  
    @IBOutlet weak var playerMarketPrice: UILabel!
    
    @IBOutlet weak var playerAge: UILabel!
    
    @IBOutlet weak var playerPosition: UILabel!
    
    @IBOutlet weak var playerRating: UILabel!
    
    @IBOutlet weak var playerImage: UIImageView!
    
    var player: Player?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData()
    }
    
    func loadData(){
        if let player = player{
            playerName.text = player.name
            playerPosition.text = player.positionName
            playerMarketPrice.text = NumbersFormats.formatNumber(player.marketValue) 
            playerAge.text = player.age
            playerRating.text = player.rating
            playerNumber.text = player.shirtNumber
            if let url = player.photo
            {
                playerImage.kf.indicatorType = .activity
                
                playerImage.kf.setImage(with: URL(string: url) )
                
            }
        }
    }
    
  
    
}

// MARK: - Instance
extension PlayersDetailsViewController {
    
    static func getInstance() -> PlayersDetailsViewController {
        
        let playersDetailsViewController = PlayersDetailsViewController(nibName: "PlayersDetailsViewController", bundle: nil)
        
        return playersDetailsViewController
    }
}
