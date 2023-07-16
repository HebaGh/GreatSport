//
//  PlayersRepository.swift
//  GreatSport
//
//  Created by mac on 7/15/23.
//



import Foundation
protocol PlayersRepository
{
  
    func fetchPlayers( completion: @escaping (Result<[Player]>) -> Void)
}

