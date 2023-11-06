//
//  ProfileEditViewController.swift
//  final project
//
//  Created by Muhammad Fachri Nuriza on 10/10/22.
//

import UIKit
import Cores

public class ProfileEditViewController: BaseVIewController {
    @IBOutlet weak var iconUser: UIImageView!
    
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var txtName: UITextField!
    
    let profileEditViewModel: ProfileEditViewModel
    
    public var profileData: Profile? = nil
    
    public init(
        profileEditViewModel: ProfileEditViewModel
    ) {
        self.profileEditViewModel = profileEditViewModel
        
        super.init(nibName: nil, bundle: Bundle(for: Self.self))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.setNavigationBarWithTitleAndSaveButton(title: "Edit Profil")
        
        setupBinding()
        setupUI()
    }
    
    func setupUI() {
        imgProfile.layer.cornerRadius = imgProfile.frame.width/2
        labelEmail.layer.cornerRadius = 12
        labelEmail.layer.masksToBounds = true
        
        iconUser.image = UIImage(named: "ic_profile_gray", in: Bundle(identifier: CoreBundle.getIdentifier()), compatibleWith: nil)
        imgProfile.image = UIImage(named: "photo_profile", in: Bundle(identifier: CoreBundle.getIdentifier()), compatibleWith: nil)
        
        txtName.text = profileData?.name
    }
    
    func setupBinding() {
        profileEditViewModel.success.subscribe(onNext: { result in
            self.onBackController()
        }).disposed(by: profileEditViewModel.disposeBag)
    }
    
    public override func onRequestEdit() {
        profileEditViewModel.requestChangeData(name: txtName.text!)
    }
}
