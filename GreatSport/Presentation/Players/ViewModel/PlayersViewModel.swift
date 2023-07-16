//
//  PlayersViewModel.swift
//  GreatSport
//
//  Created by mac on 7/14/23.
//

import Foundation
import RxSwift


final class PlayersViewModel {
  
  private let fetchPlayersUseCase: FetchPlayersUseCase

  var items: [Player] = [Player]()
  
  // MARK: - Init
  init( fetchPlayersUseCase: FetchPlayersUseCase)
  {
    self.fetchPlayersUseCase = fetchPlayersUseCase
  }
  
  // Execute players  use case
  func fetchPlayers() -> Observable<Result<[Player]>>
  {
    return fetchPlayersUseCase.execute().do(onNext:  { result in
      switch result {
      case .success( let data , _ , _) :
       
          self.items = data
       
        break
      default:
        break
      }

    })
  }
  
}
