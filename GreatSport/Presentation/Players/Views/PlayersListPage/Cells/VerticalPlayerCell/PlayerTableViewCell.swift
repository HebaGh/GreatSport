import UIKit
import Kingfisher

class PlayerTableViewCell: UITableViewCell {
  

    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var playerImage: UIImageView!
    
    @IBOutlet weak var positionName: UILabel!
    @IBOutlet weak var teamName: UILabel!
    
    @IBOutlet weak var playerRating: UILabel!
    private var player : Player! {
    didSet
    {
        playerName.text = player.name
        teamName.text = player.teamName
        positionName.text = " | \(player.positionName)"
        playerRating.text = player.rating
        if let url = player.photo
        {
            playerImage.kf.indicatorType = .activity
            
            playerImage.kf.setImage(with: URL(string: url) )
            
        }
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  func configure(player : Player) {
    self.player = player
  }
 
}
