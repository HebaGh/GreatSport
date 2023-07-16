//
//  DefaultPlayersRepository.swift
//  GreatSport
//
//  Created by mac on 7/15/23.
//
import Foundation

final class DefaultPlayersRepository {
    private let config: ApiDataNetworkConfig
    private let remoteDataSource : RemoteDataSource
    
    init( config : ApiDataNetworkConfig , remoteDataSource : RemoteDataSource) {
        self.config = config
        self.remoteDataSource = remoteDataSource
    }
}

extension DefaultPlayersRepository: PlayersRepository {
    
    func fetchPlayers( completion: @escaping (Result<[Player]>) -> Void) {
        
        
        let endpoint = APIEndpoints.getPlayersEndPoint()
        do {
            let ( urlRequest ,  parameter) = try endpoint.urlRequest(with: config)
            remoteDataSource.sendRequest( urlRequest, param: parameter  , completion: {
                (result: Result<[Player]>) in
                switch result {
                case .success( let data , let code , let message):
                    
                
                    
                    completion(.success(data: data , code: code , message: message))
                    break
                case .failure(let error):
                    completion(.failure(error))
                    break
                case .loading:
                    completion(.loading)
                    break
                }
            })
        }
        catch {
            completion(.failure(nil))
            
        }
        
    }
}
