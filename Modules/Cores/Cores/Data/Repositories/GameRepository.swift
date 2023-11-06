//
//  GameRepository.swift
//  final project
//
//  Created by Muhammad Fachri Nuriza on 30/09/22.
//

import RxSwift

public protocol GameRepositoryProtocol {
    func requestGameList(totalList: Int) -> Observable<BaseResponse<[GameData]>>
    func requestGameDetail(id: Int) -> Observable<GameData>
}

public class GameRepository: NSObject {
        
    public let service: GameServiceProtocol
    
    static let sharedInstance = {
        let service = GameService.sharedInstance
        return GameRepository(service: service)
    }()
    
    public init(service: GameServiceProtocol) {
        self.service = service
    }
}

extension GameRepository: GameRepositoryProtocol {
    public func requestGameList(totalList: Int) -> Observable<BaseResponse<[GameData]>> {
        return service.requestGameList(totalList: totalList)
    }
    
    public func requestGameDetail(id: Int) -> Observable<GameData> {
        return service.requestGameDetail(id: id)
    }
}

