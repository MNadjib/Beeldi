//
//  EquipementsViewController.swift
//  TechnicalTest
//
//  Created by nbellouni on 15/12/2019.
//  Copyright © 2019 c2s. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class EquipementsViewController: UIViewController {
    var viewModel: EquipementsViewModelProtocol?
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    private func setupUI() {
        self.title = localize("equipements")
        tableView.register(UINib(nibName: "EquipementTableViewCell", bundle: nil), forCellReuseIdentifier: "EquipementTableViewCellIdentifier")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tableView.delegate = nil
        self.tableView.dataSource = nil
        setupBindings()
    }
    
    private func setupBindings () {
        guard let viewModel = viewModel else {
            log("Error: view model null")
            return
        }
        
        //seach  bar text
        searchBar.rx.text.orEmpty
            .bind(to: viewModel.searchText)
            .disposed(by: disposeBag)
        
        // table view cell select
        tableView.rx.itemSelected
            .map({$0.row})
            .bind(to: viewModel.selectCell)
            .disposed(by: disposeBag)
        
        //keyboard close
        tableView.rx.contentOffset
            .subscribe(onNext: { [unowned self] _  in
                if self.searchBar.isFirstResponder {
                    self.searchBar.resignFirstResponder()
                }
            }).disposed(by: disposeBag)
        
        //TableView load
        viewModel.fetchedDatas
        .bind(to: tableView.rx
            .items(cellIdentifier: "EquipementTableViewCellIdentifier", cellType: EquipementTableViewCell.self)) { [unowned self]
            i, equipement, cell in
            cell.equipement = equipement
            cell.searchedText = self.searchBar.text ?? ""
        }.disposed(by: disposeBag)
    }
}
