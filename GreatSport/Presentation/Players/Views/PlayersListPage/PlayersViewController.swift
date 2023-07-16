import UIKit
import RxSwift

class PlayersViewController: BaseViewController  {
    
    @IBOutlet weak var TopPlayersCollectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cityLabel: UILabel!
    
    var viewModel: PlayersViewModel!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "PlayerTableViewCell", bundle: nil), forCellReuseIdentifier: "PlayerTableViewCell")
        self.tableView.register(UINib(nibName: "HorizontalPlayerTableViewCell", bundle: nil), forCellReuseIdentifier: "HorizontalPlayerTableViewCell")
        
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        configureTopPlayersCollectionView()
        fetchMostPopularArticles()
    }
    
    
    func configureTopPlayersCollectionView() {
        
        self.TopPlayersCollectionView.delegate = self
        self.TopPlayersCollectionView.dataSource = self
        self.TopPlayersCollectionView.register(UINib(nibName: "PlayerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PlayerCollectionViewCell")
        
        guard let collectionViewLayout = TopPlayersCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)

        collectionViewLayout.minimumInteritemSpacing = 0

    }
    
    func fetchMostPopularArticles()  {
        let observable = viewModel.fetchPlayers()
        observable.subscribe(onNext: {
            result in
            switch result {
            case .loading:
                self.showFullScreenLoading()
                break
            case .failure(let error):
                self.finishFullScreenLoading()
                DispatchQueue.main.async {
                    self.showFullScreenError(view: self.view, message: error?.message ?? "unknown error" ,  delegate: self)
                }
                break
            case .success(_, _ , _):
                self.finishFullScreenLoading()
                self.tableView.reloadData()
                self.TopPlayersCollectionView.reloadData()
                break
            }
        }).disposed(by: disposeBag)
    }
}

// MARK: - UITableViewDataSource
extension PlayersViewController: UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
     
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerTableViewCell",
                                                       for: indexPath) as? PlayerTableViewCell else {
            
            return UITableViewCell()
        }
        
        cell.configure(player: viewModel.items[indexPath.row ])
        return cell
    }
    
    
    
    
}
extension PlayersViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        MainCoordinator.shared?.pushPlayersDetails(player: viewModel.items[indexPath.row])
    }
}

extension PlayersViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.items.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlayerCollectionViewCell", for: indexPath) as? PlayerCollectionViewCell {
            cell.configure(item: viewModel.items[indexPath.row])
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w = collectionView.frame.width / 1.3
        return CGSize(width: 136, height: 200)
    }
    //
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
}


// MARK: - Instance
extension PlayersViewController {
    
    static func getInstance() -> PlayersViewController {
        
        let playersViewController = PlayersViewController(nibName: "PlayersViewController", bundle: nil)
        
        return playersViewController
    }
}

// MARK: - Error delegate handeling
extension PlayersViewController: CustomErrorViewDelegate
{
    func didTapRetry(){
        if isOnline{
            self.hideFullScreenError()
            fetchMostPopularArticles()
        }
    }
}

