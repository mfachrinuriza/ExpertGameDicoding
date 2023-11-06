//
//  FavoriteRepository.swift
//  final project
//
//  Created by Muhammad Fachri Nuriza on 09/10/22.
//

import RxSwift

public protocol FavoriteRepositoryProtocol {
    func requestFavoriteList() -> Observable<[GameData]>
    func requestFavoriteDetail(id: Int) -> Observable<GameData>
    func requestCreateFavorite(request: GameData) -> Observable<String>
    func requestDeleteFavorite(id: Int) -> Observable<String>
}

public class FavoriteRepository: NSObject {
    public let storage: FavoriteStorageProtocol
    public init(storage: FavoriteStorageProtocol) {
        self.storage = storage
    }
}

extension FavoriteRepository: FavoriteRepositoryProtocol {
    public func requestFavoriteList() -> RxSwift.Observable<[GameData]> {
        self.storage.requestFavoriteList()
    }
    
    public func requestFavoriteDetail(id: Int) -> RxSwift.Observable<GameData> {
        self.storage.requestFavoriteDetail(id: id)
    }
    
    public func requestCreateFavorite(request: GameData) -> RxSwift.Observable<String> {
        self.storage.requestCreateFavorite(request: request)
    }
    
    public func requestDeleteFavorite(id: Int) -> RxSwift.Observable<String> {
        self.storage.requestDeleteFavorite(id: id)
    }
}
