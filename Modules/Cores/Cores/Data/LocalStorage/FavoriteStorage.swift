//
//  FavoriteStorage.swift
//  final project
//
//  Created by Muhammad Fachri Nuriza on 09/10/22.
//

import CoreData
import RxSwift
import RxCocoa

public protocol FavoriteStorageProtocol {
    func requestFavoriteList() -> Observable<[GameData]>
    func requestFavoriteDetail(id: Int) -> Observable<GameData>
    func requestCreateFavorite(request: GameData) -> Observable<String>
    func requestDeleteFavorite(id: Int) -> Observable<String>
}

public class FavoriteStorage: NSObject {
    public var manageContext: NSManagedObjectContext
    public init(
        manageContext: NSManagedObjectContext
    ) {
        self.manageContext = manageContext
    }
}

extension FavoriteStorage: FavoriteStorageProtocol {
    public func requestFavoriteList() -> Observable<[GameData]> {
        return Observable.create { observer in
            var favoriteList = [GameData]()
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName : "Favorite")
            
            do {
                let result = try self.manageContext.fetch(fetchRequest) as! [NSManagedObject]
                for data in result {
                    favoriteList.append(
                        GameData(
                            id: data.value(forKey: "id") as? Int,
                            slug: data.value(forKey: "slug") as? String,
                            name: data.value(forKey: "name") as? String,
                            released: data.value(forKey: "released") as? String,
                            description: data.value(forKey: "description_game") as? String,
                            background_image: data.value(forKey: "background_image") as? String,
                            rating: data.value(forKey: "rating") as? Double
                        )
                    )
                }
            } catch let error {
                Logger.printLog(error)
            }
            
            observer.onNext(favoriteList)
            observer.onCompleted()
            
            return Disposables.create()
        }
    }
    
    public func requestFavoriteDetail(id: Int) -> Observable<GameData> {
        return Observable.create { observer in
            var favoriteDetail = [GameData]()
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName : "Favorite")
            fetchRequest.predicate = NSPredicate(format: "id = %d", id)
            
            do {
                let result = try self.manageContext.fetch(fetchRequest) as! [NSManagedObject]
                for data in result {
                    favoriteDetail.append(
                        GameData(
                            id: data.value(forKey: "id") as? Int,
                            slug: data.value(forKey: "slug") as? String,
                            name: data.value(forKey: "name") as? String,
                            released: data.value(forKey: "released") as? String,
                            description: data.value(forKey: "description_game") as? String,
                            background_image: data.value(forKey: "background_image") as? String,
                            rating: data.value(forKey: "rating") as? Double
                        )
                    )
                }
            } catch let error {
                Logger.printLog(error)
            }
            
            observer.onNext(favoriteDetail[0])
            observer.onCompleted()
            
            return Disposables.create()
        }
    }
    
    public func requestCreateFavorite(request: GameData) -> Observable<String> {
        return Observable.create { observer in
            
            let entity = NSEntityDescription.entity(forEntityName: "Favorite", in: self.manageContext)
            
            let insert = NSManagedObject(entity: entity!, insertInto: self.manageContext)
            insert.setValue(request.id, forKey: "id")
            insert.setValue(request.slug, forKey: "slug")
            insert.setValue(request.name, forKey: "name")
            insert.setValue(request.released, forKey: "released")
            insert.setValue(request.description, forKey: "description_game")
            insert.setValue(request.background_image, forKey: "background_image")
            insert.setValue(request.rating, forKey: "rating")
            
            do{
                try self.manageContext.save()
                observer.onNext(ServiceSuccess.createFavoriteSuccess)
                observer.onCompleted()
            } catch let error {
                observer.onError(error)
            }
            
            return Disposables.create()
        }
    }
    
    public func requestDeleteFavorite(id: Int) -> Observable<String> {
        return Observable.create { observer in
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName : "Favorite")
            fetchRequest.predicate = NSPredicate(format: "id = %d", id)
            do {
                let fetch = try self.manageContext.fetch(fetchRequest)
                let delete = fetch[0] as! NSManagedObject
                self.manageContext.delete(delete)
                try self.manageContext.save()
                
                observer.onNext(ServiceSuccess.deleteFavoriteSuccess)
                observer.onCompleted()
            } catch let error {
                observer.onError(error)
            }
            
            return Disposables.create()
        }
    }
}
