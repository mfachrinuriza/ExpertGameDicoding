//
//  ProfileViewModel.swift
//  final project
//
//  Created by Muhammad Fachri Nuriza on 10/10/22.
//

import UIKit
import RxSwift
import RxCocoa
import Cores

public class ProfileViewModel: NSObject {
    let loading: PublishSubject<Bool> = PublishSubject()
    let profile: BehaviorRelay<Profile?> = BehaviorRelay(value: nil)
    
    let disposeBag = DisposeBag()
    
    func requestProfileData() {
        loading.onNext(true)
        
        var name: String? {
            return UserDefaults.standard.value(forKey: "SAVED_NAME") as? String
        }
        
        let data = Profile(
            email: "  mfachrinuriza@gmail.com  ",
            name: "\(name ?? "Muhammad Fachri Nuriza")",
            origin: "Palembang"
        )
        profile.accept(data)
        loading.onNext(false)
    }
}
