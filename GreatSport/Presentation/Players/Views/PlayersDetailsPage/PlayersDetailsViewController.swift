//
//  ArticleDetailsViewController.swift
//  GithubApiSample
//
//  Created by Hiba on 24/05/2023.
//

import UIKit

class PlayersDetailsViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var KeywordsLabel: UILabel!
    @IBOutlet weak var ArticleImage: UIImageView!
    
    @IBOutlet weak var abstractLabel: UILabel!
    var article: Article?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData()
    }
    
    func loadData(){
        if let article = article{
            abstractLabel.text = article.abstract
            KeywordsLabel.text = article.adx_keywords
            titleLabel.text = article.Title
            if article.media.count > 0 {
                let url = article.media[0].mediaMetadata[1].url
                ArticleImage.kf.indicatorType = .activity
                ArticleImage.kf.setImage(with: URL(string: url) )
            }
        }
    }
    
    @IBAction func openTheArticleAction(_ sender: Any) {
        
        if let url = URL(string: self.article?.url ?? "") {
            UIApplication.shared.open(url, options: [:]) { success in
                if success {
                    print("URL opened successfully")
                } else {
                    print("Failed to open URL")
                }
            }
        }
        
        
    }
    
    @IBAction func backButton(_ sender: Any) {
        MainCoordinator.shared?.pop()
    }
    
    
}

// MARK: - Instance
extension PlayersDetailsViewController {
    
    static func getInstance() -> PlayersDetailsViewController {
        
        let playersDetailsViewController = PlayersDetailsViewController(nibName: "PlayersDetailsViewController", bundle: nil)
        
        return playersDetailsViewController
    }
}
