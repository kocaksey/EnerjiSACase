//
//  BillTableViewCell.swift
//  EnerjiSA
//
//  Created by Seyhun Koçak on 5.08.2023.
//

import UIKit
import SnapKit

class BillTableViewCell: UITableViewCell {
    
    static let identifier = "BillCell"
    
    let dueDateLabel = UILabel()
    let amountLabel = UILabel()
    let documentBtn = UIButton()
    let payBtn = UIImageView()
    let rightImg = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        addSubview(dueDateLabel)
        addSubview(amountLabel)
        addSubview(documentBtn)
        addSubview(payBtn)
        addSubview(rightImg)
        dueDateLabel.font = UIFont(name: "Helvetica", size: 14)
        dueDateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.left.equalToSuperview().offset(8)
            make.width.equalTo(70)
            make.height.equalTo(24)
            
        }
        amountLabel.font = UIFont(name: "Helvetica", size: 14)
        amountLabel.snp.makeConstraints { make in
            make.top.equalTo(dueDateLabel.snp.top)
            make.left.equalTo(dueDateLabel.snp.right).offset(18)
            make.width.equalTo(70)
            make.height.equalTo(24)
        }
        documentBtn.setTitle("documentBtn", for: .normal)
        documentBtn.layer.zPosition = 1
        documentBtn.setImage(UIImage(named: "invoice"), for: .normal)
        documentBtn.snp.makeConstraints { make in
            make.top.equalTo(amountLabel.snp.top)
            make.left.equalTo(amountLabel.snp.right).offset(29)
            make.height.width.equalTo(20)
            
        }
        payBtn.image = UIImage(named: "pay")
        payBtn.snp.makeConstraints { make in
            make.top.equalTo(documentBtn.snp.top).inset(-2)
            make.left.equalTo(documentBtn.snp.right).offset(29)
            make.width.equalTo(26)
            make.height.equalTo(18)
        }
        rightImg.image = UIImage(named: "right")
        rightImg.snp.makeConstraints { make in
            make.top.equalTo(payBtn.snp.top)
            make.leading.equalTo(payBtn.snp.trailing)
            make.width.equalTo(24)
            make.height.equalTo(24)
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.bringSubviewToFront(self.documentBtn)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
