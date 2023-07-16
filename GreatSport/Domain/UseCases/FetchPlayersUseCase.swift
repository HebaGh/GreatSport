//
//  FetchPlayersUseCase.swift
//  GreatSport
//
//  Created by mac on 7/15/23.
//


import Foundation
import RxSwift

protocol FetchPlayersUseCase
{
  func execute() -> Observable<Result<[Player]>>
}

final class DefaultFetchPlayersUseCase : FetchPlayersUseCase {
  
  private let defaultRepository: PlayersRepository
  
  init(defaultRepository: PlayersRepository)
  {
    self.defaultRepository = defaultRepository
  }
  
  func execute() -> Observable<Result<[Player]>> {
    
    return Observable<Result<[Player]>>.create { observer in
      if !isOnline
      {
        observer.onNext(Result.failure(AppError(reason: .networkError, message: "Please check your internet connection")))
      }
      else{
        observer.onNext(Result.loading)
        
        self.defaultRepository.fetchPlayers( completion: { result in
          
          observer.onNext(result)
        })
      }
      return Disposables.create()
    }
  }
}


