//
//  FavoriteInteractor.swift
//  final project
//
//  Created by Muhammad Fachri Nuriza on 03/08/23.
//

import RxSwift

public protocol FavoriteUseCase {
    func requestFavoriteList() -> Observable<[Game]>
    func requestFavoriteDetail(id: Int) -> Observable<Game>
    func requestCreateFavorite(request: Game) -> Observable<String>
    func requestDeleteFavorite(id: Int) -> Observable<String>
}

public class FavoriteInteractor: FavoriteUseCase {
    public var favoriteRepository: FavoriteRepositoryProtocol
    
    public init(
        favoriteRepository: FavoriteRepositoryProtocol
    ) {
        self.favoriteRepository = favoriteRepository
    }
    
    let disposedBag = DisposeBag()

    public func requestFavoriteList() -> RxSwift.Observable<[Game]> {
        return Observable.create { observer in
            self.favoriteRepository.requestFavoriteList().subscribe(onNext: { gameDataList in
                let gameList = gameDataList.map { gameData in
                    return Game(from: gameData)
                }
                observer.onNext(gameList)
                observer.onCompleted()
            }, onError: { error in
                observer.onError(error)
            }).disposed(by: self.disposedBag)
            
            return Disposables.create()
        }
    }
    
    public func requestFavoriteDetail(id: Int) -> RxSwift.Observable<Game> {
        return Observable.create { observer in
            self.favoriteRepository.requestFavoriteDetail(id: id).subscribe(onNext: { gameData in
                let game = Game(from: gameData)
                observer.onNext(game)
                observer.onCompleted()
            }, onError: { error in
                observer.onError(error)
            }).disposed(by: self.disposedBag)
            
            return Disposables.create()
        }
    }
    
    public func requestCreateFavorite(request: Game) -> RxSwift.Observable<String> {
        let requestGameData = GameData(from: request)
        return favoriteRepository.requestCreateFavorite(request: requestGameData)
    }
    
    public func requestDeleteFavorite(id: Int) -> RxSwift.Observable<String> {
        return favoriteRepository.requestDeleteFavorite(id: id)
    }
}
