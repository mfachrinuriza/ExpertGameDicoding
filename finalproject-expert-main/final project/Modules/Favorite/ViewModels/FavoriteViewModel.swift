//
//  FavoriteViewModel.swift
//  final project
//
//  Created by Muhammad Fachri Nuriza on 09/10/22.
//

import UIKit
import RxSwift
import RxCocoa
import Cores

class FavoriteViewModel: BaseViewModel {
    let error: PublishRelay<String> = PublishRelay()
    let loading: PublishRelay<Bool> = PublishRelay()
    
    let favoriteList: BehaviorRelay<[Game]> = BehaviorRelay(value: [])
    let detailGame: BehaviorRelay<Game?> = BehaviorRelay(value: nil)
    let favoriteDetail: BehaviorRelay<Game?> = BehaviorRelay(value: nil)
    
    let isDeleteSuccess: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    public var favoriteUseCase: FavoriteUseCase
    
    init(
        favoriteUseCase: FavoriteUseCase
    ) {
        self.favoriteUseCase = favoriteUseCase
    }
}

extension FavoriteViewModel {
    func requestFavoriteList() {
        self.loading.accept(true)
        favoriteUseCase.requestFavoriteList().subscribe(onNext: { [unowned self] result in
            self.favoriteList.accept(result)
            Logger.printLog("FAVORITE LIST ====== \(result)")
            self.loading.accept(false)
        }, onError: { [unowned self] error in
            self.error.accept(ServiceError.pleaseCheckConnectionError)
            self.loading.accept(false)
        }).disposed(by: disposeBag)
    }
    
    func requestDeleteFavorite(id: Int) {
        self.loading.accept(true)
        favoriteUseCase.requestDeleteFavorite(id: id).subscribe(onNext: { [unowned self] result in
            self.loading.accept(false)
            self.isDeleteSuccess.accept(true)
        }, onError: { [unowned self] error in
            self.error.accept(ServiceError.deleteFavoriteFailed)
            self.loading.accept(false)
        }).disposed(by: disposeBag)
    }
}
