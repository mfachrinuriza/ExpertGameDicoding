//
//  ProfileViewController.swift
//  final project
//
//  Created by Muhammad Fachri Nuriza on 24/08/22.
//

import UIKit
import Cores

public class ProfileViewController: BaseVIewController {

    @IBOutlet weak var iconUser: UIImageView!
    @IBOutlet weak var iconLocation: UIImageView!
    
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var lblOrigin: UILabel!
    
    let navigator: Navigator
    let profileViewModel: ProfileViewModel
    
    public init(
        profileViewModel: ProfileViewModel,
        navigator: Navigator
    ) {
        self.profileViewModel = profileViewModel
        self.navigator = navigator
        
        super.init(nibName: nil, bundle: Bundle(for: Self.self))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBinding()
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        loadData()
    }
    
    func loadData() {
        profileViewModel.requestProfileData()
    }
    
    func setupUI() {
        iconUser.image = UIImage(named: "ic_profile_gray", in: Bundle(identifier: CoreBundle.getIdentifier()), compatibleWith: nil)
        iconLocation.image = UIImage(named: "ic_location_gray2", in: Bundle(identifier: CoreBundle.getIdentifier()), compatibleWith: nil)

        imgProfile.layer.cornerRadius = imgProfile.frame.width/2
        labelEmail.layer.cornerRadius = 12
        labelEmail.layer.masksToBounds = true
    }
    
    func updateUI() {
        if let data = profileViewModel.profile.value {
            imgProfile.image = UIImage(named: "photo_profile", in: Bundle(identifier: CoreBundle.getIdentifier()), compatibleWith: nil)
            labelEmail.text = data.email
            labelName.text = data.name
            lblOrigin.text = data.origin
        }
    }
    
    func setupBinding() {
        profileViewModel.loading.subscribe(onNext: { loading in
            if loading {
                self.showLoading()
            } else {
                self.removeLoading()
            }
        }).disposed(by: profileViewModel.disposeBag)
        
        profileViewModel.profile.subscribe(onNext: { [unowned self] result in
            self.updateUI()
        }).disposed(by: profileViewModel.disposeBag)
    }
    
    @IBAction func btnEditTapped(_ sender: Any) {
        navigator.push(.profileEdit(profile: profileViewModel.profile.value!))
    }
}
