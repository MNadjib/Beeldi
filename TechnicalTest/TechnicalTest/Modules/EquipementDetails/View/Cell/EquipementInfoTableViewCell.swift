//
//  EquipementInfoTableViewCell.swift
//  TechnicalTest
//
//  Created by nbellouni on 23/12/2019.
//  Copyright © 2019 nbellouni. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class EquipementInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var domainLbl: UILabel!
    @IBOutlet weak var faultsLbl: UILabel!
    
    @IBOutlet weak var imgv: UIImageView!
    @IBOutlet weak var nameTxtField: UITextField!
    @IBOutlet weak var domainTxtField: UITextField!
    @IBOutlet weak var faultTxtField: UITextField!
    
    private var disposeBag = DisposeBag()
    
    var viewModel: EquipementDetailsViewModelProtocol? {
        didSet {
            guard let vm = viewModel else { return }
            let disposeBag = DisposeBag()
            nameTxtField.rx.text.orEmpty
            .map({["name":$0]})
                .bind(to: vm.editInfoEquipement)
                .disposed(by: disposeBag)
            
            domainTxtField.rx.text.orEmpty
                .map({["domain":$0]})
                .bind(to: vm.editInfoEquipement)
                .disposed(by: disposeBag)
            
            faultTxtField.rx.text.orEmpty
                  .map({["nbFaults":$0]})
                  .bind(to: vm.editInfoEquipement)
                  .disposed(by: disposeBag)
            
            self.disposeBag = disposeBag
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let tableView:UITableView = self.superview as! UITableView
        tableView.rx.contentOffset
            .subscribe(onNext: { [unowned self] _  in
            if self.nameTxtField.isFirstResponder {
                self.nameTxtField.resignFirstResponder()
            }
            
            if self.domainTxtField.isFirstResponder {
                self.domainTxtField.resignFirstResponder()
            }
                
            if self.faultTxtField.isFirstResponder {
                self.faultTxtField.resignFirstResponder()
            }
                
        }).disposed(by: disposeBag)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var equipement:Equipement? {
        didSet {
            nameLbl.text = localize("Name")
            domainLbl.text = localize("Domain")
            faultsLbl.text = localize("Faults")
            if let ph = equipement?.photo {
                imgv.loadImageAsync(with: ph)
            }
           
            nameTxtField.text = equipement?.name
            domainTxtField.text = equipement?.domain
            if let nbf = equipement?.nbFaults {
                faultTxtField.text = "\(nbf)"
            }
        }
    }
    
}
