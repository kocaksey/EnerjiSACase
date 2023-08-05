//
//  PopUpView.swift
//  EnerjiSA
//
//  Created by Seyhun Koçak on 5.08.2023.
//

import UIKit
import SnapKit

class CustomPopupView: UIView {
    
    let infoLabel = UILabel()
    var installNum = String()
    var onClose: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 10
        
        let infoImage = UIImageView()
        infoImage.image = UIImage(named: "infoBig")
        self.addSubview(infoImage)
        infoImage.snp.makeConstraints { make in
            make.width.height.equalTo(100)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(25)
        }
        
        lazy var infoLb = UILabel()
        infoLb.text = "Bilgilendirme"
        infoLb.textAlignment = .center
        infoLb.font = UIFont(name: "Helvetica-Bold", size: 20)
        self.addSubview(infoLb)
        infoLb.snp.makeConstraints { make in
            make.top.equalTo(infoImage.snp.bottom).offset(20)
            make.height.equalTo(30)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().inset(25)
        }
        
        infoLabel.textAlignment = .center
        infoLabel.numberOfLines = .zero
        infoLabel.font = UIFont(name: "Helvetica", size: 15)
        self.addSubview(infoLabel)
        infoLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().inset(15)
            make.height.equalTo(76)
            make.top.equalTo(infoLb.snp.bottom).offset(20)
        }
        
        let okBtn = UIButton()
        okBtn.setImage(UIImage(named: "ok"), for: .normal)
        okBtn.addTarget(self, action: #selector(closeInfo), for: .touchUpInside)
        self.addSubview(okBtn)
        okBtn.snp.makeConstraints { make in
            make.top.equalTo(infoLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
    }
    @objc func closeInfo(){
        onClose?()

    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with installNum: String, dueDates: String) {
        infoLabel.text = "\(installNum) döküman numaralı faturanızın \(dueDates) tarihine kadar ödenmesi gerekmektedir."
    }
}

