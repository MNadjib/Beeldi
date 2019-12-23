//
//  EquipementDetailsViewController.swift
//  TechnicalTest
//
//  Created by nbellouni on 21/12/2019.
//  Copyright © 2019 c2s. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

protocol EquipementDetailsViewControllerProtocol: class {
    func  reloadData()
}

class EquipementDetailsViewController: UIViewController {
    var viewModel: EquipementDetailsViewModelProtocol?
    @IBOutlet weak var tableView: UITableView!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel?.retrieveData()
        // Do any additional setup after loading the view.
    }
    
    private func setupUI() {
        tableView.register(UINib(nibName: "CheckpointTableViewCell", bundle: nil), forCellReuseIdentifier: "CheckpointTableViewCellIdentifier")
        
        tableView.register(UINib(nibName: "EquipementInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "EquipementInfoTableViewCellIdentifier")
    }
    
    //keyboard close
    private func setupBindings ()  {
        tableView.rx.contentOffset
        .subscribe(onNext: { [unowned self] _  in
            self.resignFirstResponder()
        }).disposed(by: disposeBag)
    }
}

extension EquipementDetailsViewController: EquipementDetailsViewControllerProtocol {
    func reloadData() {
        tableView.reloadData()
    }
}

extension EquipementDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return viewModel?.nomberOfRow ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
          let cell:EquipementInfoTableViewCell = tableView.dequeueReusableCell(withIdentifier: "EquipementInfoTableViewCellIdentifier", for: indexPath) as! EquipementInfoTableViewCell
            cell.equipement = viewModel?.equipementInfoData
            cell.viewModel = viewModel
            return cell
        } else {
            let cell: CheckpointTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CheckpointTableViewCellIdentifier", for: indexPath) as! CheckpointTableViewCell
            cell.checkpoint = viewModel?.checkPointData(for: indexPath.row)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return localize("informattion")
        }
        return localize("checkpoints")
    }
}
