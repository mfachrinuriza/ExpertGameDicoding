//
//  ProfileEditViewModel.swift
//  final project
//
//  Created by Muhammad Fachri Nuriza on 10/10/22.
//

import UIKit
import RxSwift
import RxCocoa
import Cores

public class ProfileEditViewModel: BaseViewModel {
    let success: PublishSubject<Bool> = PublishSubject()
    
    func requestChangeData(name: String) {
        UserDefaults.standard.set(name, forKey: "SAVED_NAME")
        success.onNext(true)
    }
}
