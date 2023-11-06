//
//  HomeViewController.swift
//  final project
//
//  Created by Muhammad Fachri Nuriza on 24/08/22.
//

import UIKit
import Kingfisher
import Cores

class HomeViewController: BaseVIewController {

    @IBOutlet weak var iconSearch: UIImageView!
    @IBOutlet weak var collectionView: FittedCollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    var navigator: Navigator
    var homeViewModel: HomeViewModel
    let noWarning :String = "" 
    
    init(
        homeViewModel: HomeViewModel,
        navigator: Navigator
    ) {
        self.homeViewModel = homeViewModel
        self.navigator = navigator
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBinding()
        loadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func loadData() {
        homeViewModel.requestGamePopular()
    }
    
    func setupUI() {
        iconSearch.image = UIImage(named: "ic_search_gray", in: Bundle(identifier: CoreBundle.getIdentifier()), compatibleWith: nil)

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: BestCell.cellIdentifier, bundle: nil), forCellWithReuseIdentifier: BestCell.cellIdentifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: GameCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: GameCell.cellIdentifier)
    }
    
    func updateUI() {
        tableView.reloadData()
        collectionView.reloadData()
    }
    
    func setupBinding() {
        homeViewModel.error.subscribe(onNext: { error in
            self.showAlert(title: "Perhatian", message: error)
        }).disposed(by: homeViewModel.disposeBag)
        
        homeViewModel.loading.subscribe(onNext: { loading in
            if loading {
                self.showLoading()
            } else {
                self.removeLoading()
            }
        }).disposed(by: homeViewModel.disposeBag)
        
        homeViewModel.gameList.subscribe(onNext: { result in
            self.updateUI()
        }).disposed(by: homeViewModel.disposeBag)
        
        homeViewModel.gamePupular.subscribe(onNext: { result in
            self.updateUI()
        }).disposed(by: homeViewModel.disposeBag)
    }
    
    func presentDetail(gameId: Int) {
        navigator.push(.detail(gameId: gameId))
    }
    
    @IBAction func btnSearchTapped(_ sender: Any) {
        navigator.push(.search(gameList: homeViewModel.gameList.value))
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeViewModel.gameList.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GameCell.cellIdentifier, for: indexPath) as! GameCell
        let data = homeViewModel.gameList.value[indexPath.row]
        
        cell.update(data: data)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = homeViewModel.gameList.value[indexPath.row]
        self.presentDetail(gameId: data.id ?? 0)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeViewModel.gamePupular.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BestCell.cellIdentifier, for: indexPath) as! BestCell
        let data = homeViewModel.gamePupular.value[indexPath.row]
        cell.update(data: data)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = homeViewModel.gamePupular.value[indexPath.row]
        self.homeViewModel.selectedGameId.accept(data.id)
        self.presentDetail(gameId: data.id ?? 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 250)
    }
}
