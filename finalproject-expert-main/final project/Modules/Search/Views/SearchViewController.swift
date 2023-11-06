//
//  SearchViewController.swift
//  final project
//
//  Created by Muhammad Fachri Nuriza on 25/08/22.
//

import UIKit
import Cores

class SearchViewController: BaseVIewController {
    @IBOutlet weak var iconSearch: UIImageView!
    @IBOutlet weak var iconBack: UIButton!
    
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnRemoveText: UIButton!
    
    var gameList = [Game]()
    var filteredData = [Game]()
    
    let navigator: Navigator
    let searchViewModel: SearchViewModel
    
    init(
        navigator: Navigator,
        searchViewModel: SearchViewModel
    ) {
        self.navigator = navigator
        self.searchViewModel = searchViewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        filteredData = gameList
        setupUI()
        setupBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func setupUI() {
        btnRemoveText.isHidden = true
        iconSearch.image = UIImage(named: "ic_search_gray", in: Bundle(identifier: CoreBundle.getIdentifier()), compatibleWith: nil)
        iconBack.setImage(UIImage(named: "ic_arrow_left", in: Bundle(identifier: CoreBundle.getIdentifier()), compatibleWith: nil), for: .normal)

        txtSearch.delegate = self
        txtSearch.becomeFirstResponder()
        txtSearch.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset.bottom = 100
        tableView.register(UINib(nibName: GameCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: GameCell.cellIdentifier)
    }
    
    func updateUI() {
        tableView.reloadData()
    }
    
    func setupBinding() {
        searchViewModel.filtered.subscribe(onNext: { filtered in
            self.filteredData = filtered
            self.updateUI()
        }).disposed(by: searchViewModel.disposeBag)
        
        searchViewModel.loading.subscribe(onNext: { loading in
            if loading {
                self.showLoading()
            } else {
                self.removeLoading()
            }
        }).disposed(by: searchViewModel.disposeBag)
    }
    
    func loadData() {
        searchViewModel.getFilteredData(data: gameList, search: txtSearch.text)
    }
    
    @IBAction func btnRemoveTextTapped(_ sender: Any) {
        txtSearch.text = ""
        btnRemoveText.isHidden = true
        
        loadData()
    }
    
    @IBAction func btnBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GameCell.cellIdentifier, for: indexPath) as! GameCell
        let data = filteredData[indexPath.row]
        
        cell.update(data: data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = filteredData[indexPath.row]
        self.navigator.push(.detail(gameId: data.id ?? 0))
    }
}

extension SearchViewController: UITextFieldDelegate {
    @objc func textFieldDidChange(_ textfield: UITextField) {
        if textfield.text != "" && textfield.text != nil {
            btnRemoveText.isHidden = false
        } else {
            btnRemoveText.isHidden = true
        }
        
        loadData()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtSearch.resignFirstResponder()
    }
}
