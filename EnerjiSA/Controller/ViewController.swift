//
//  ViewController.swift
//  EnerjiSA
//
//  Created by Seyhun Koçak on 2.08.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    

    
    let scrollView: UIScrollView = {
       let scrollView = UIScrollView()
       scrollView.showsVerticalScrollIndicator = false
       return scrollView
   }()
   
    let stackView: UIStackView = {
       let stackView = UIStackView()
       stackView.axis = .vertical
       stackView.distribution = .equalSpacing
       stackView.spacing = 32
       return stackView
   }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        NetworkManager.shared.fetchData()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.7){

            self.setupUI()

        }

    }
    
    private func setupUI() {
        
        let navBarView = UIView()
        self.view.addSubview(navBarView)

        navBarView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(108)
        }
        
        let backgroundImageView = UIImageView()
        navBarView.addSubview(backgroundImageView)

        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        if let image = UIImage(named: "top2") {
            backgroundImageView.image = image
        }
        let titleLabel = UILabel()
        titleLabel.text = "FATURA LİSTESİ"
        titleLabel.textColor = .white
        titleLabel.font = UIFont(name:"Helvetica-Bold", size: 16)
        navBarView.addSubview(titleLabel)

        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(35)
        }
        

        let scrollView = UIScrollView()
        view.addSubview(scrollView)

        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide).inset(UIEdgeInsets(top: 36, left: 30, bottom: 0, right: 30))
        }

        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 32

        scrollView.addSubview(stackView)

        stackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.width.equalTo(scrollView)
        }
        
        
        let box1 = UIView()
        box1.backgroundColor = .white
        box1.layer.shadowColor = UIColor(red: 0.682, green: 0.682, blue: 0.753, alpha: 0.4).cgColor
        box1.layer.shadowOffset = CGSize(width: 5, height: 5)
        box1.layer.shadowOpacity = 1
        box1.layer.shadowRadius = 20
        box1.layer.cornerRadius = 10

        let infoImage = UIImageView()
        infoImage.image = UIImage(named: "info")
        box1.addSubview(infoImage)
        
        infoImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalToSuperview().offset(12)
            make.height.width.equalTo(24)
        }
        let infoLabel = UILabel()
        infoLabel.text = "Tüm sözleşme hesaplarınıza ait \(NetworkManager.shared.totalPriceCount) adet ödenmemiş fatura bulunmaktadır."
        infoLabel.font = UIFont(name: "Helvetica-Bold", size: 14)


        infoLabel.numberOfLines = .zero
        box1.addSubview(infoLabel)
        infoLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(6)
            make.leading.equalTo(infoImage.snp.trailing).offset(12)
            make.trailing.equalToSuperview().inset(12)
            make.height.equalTo(48)
        }

        lazy var debtLabel = UILabel()
        debtLabel.text = "Toplam Borç:"
        debtLabel.font = UIFont(name: "Helvetica-Bold", size: 14)
        box1.addSubview(debtLabel)
        debtLabel.snp.makeConstraints { make in
            make.leading.equalTo(infoLabel.snp.leading)
            make.width.equalTo(141)
            make.top.equalTo(infoLabel.snp.bottom).offset(10)
            make.height.equalTo(24)
        }

        let debtAmountLabel = UILabel()
        debtAmountLabel.text = "₺ \(NetworkManager.shared.totalPrice)"
        debtAmountLabel.font = UIFont(name: "Helvetica-Bold", size: 14)
        box1.addSubview(debtAmountLabel)
        debtAmountLabel.snp.makeConstraints { make in
            make.top.equalTo(debtLabel.snp.top)
            make.trailing.equalToSuperview().inset(12)
            make.width.equalTo(80)
            make.height.equalTo(24)
        }
        
        stackView.addArrangedSubview(box1)
        box1.snp.makeConstraints { make in
            make.height.equalTo(104)
        }


        for i in 0..<NetworkManager.shared.company.count {
           
            
            let box = UIView()
            
            box.backgroundColor = .white
            box.layer.shadowColor = UIColor(red: 0.682, green: 0.682, blue: 0.753, alpha: 0.4).cgColor
            box.layer.shadowOffset = CGSize(width: 5, height: 5)
            box.layer.shadowOpacity = 1
            box.layer.shadowRadius = 20
            box.layer.cornerRadius = 10
            
            let locationNameLabel = UILabel()
            locationNameLabel.text = "\(NetworkManager.shared.company[i])"
            locationNameLabel.font = UIFont(name: "Helvetica-Bold", size: 15)
            box.addSubview(locationNameLabel)
            locationNameLabel.snp.makeConstraints { make in
                make.top.leading.equalToSuperview().offset(12)
                make.trailing.equalToSuperview().inset(12)
                make.height.equalTo(24)
            }
            


            let seperatorLine1 = UIView()
            seperatorLine1.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1)
            box.addSubview(seperatorLine1)

            seperatorLine1.snp.makeConstraints { make in
                make.top.equalTo(locationNameLabel.snp.bottom).offset(10)
                make.height.equalTo(1)
                make.leading.equalToSuperview().offset(12)
                make.trailing.equalToSuperview().inset(12)
            }

            let locationLabel = UILabel()
            locationLabel.text = "Adres:"
            locationLabel.font = UIFont(name: "Helvetica-Bold", size: 15)
            box.addSubview(locationLabel)
            locationLabel.snp.makeConstraints { make in
                make.top.equalTo(seperatorLine1.snp.bottom).offset(10)
                make.leading.equalToSuperview().offset(12)
                make.trailing.equalToSuperview().inset(12)
                make.height.equalTo(24)
            }

            let addressLabel = UILabel()
            addressLabel.text = "\(NetworkManager.shared.address[i])"
            addressLabel.font = UIFont(name: "Helvetica", size: 15)
            addressLabel.numberOfLines = .zero
            box.addSubview(addressLabel)
            addressLabel.snp.makeConstraints { make in
                make.top.equalTo(locationLabel.snp.bottom)
                make.leading.equalToSuperview().offset(12)
                make.trailing.equalToSuperview().inset(12)
                make.height.equalTo(49)
            }

            let seperatorLine2 = UIView()
            seperatorLine2.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1)
            box.addSubview(seperatorLine2)

            seperatorLine2.snp.makeConstraints { make in
                make.top.equalTo(addressLabel.snp.bottom).offset(10)
                make.height.equalTo(1)
                make.leading.equalToSuperview().offset(12)
                make.trailing.equalToSuperview().inset(12)
            }

            let fittingNumLabel = UILabel()
            fittingNumLabel.text = "Tesisat Numarası:"
            fittingNumLabel.font = UIFont(name: "Helvetica-Bold", size: 15)
            box.addSubview(fittingNumLabel)
            fittingNumLabel.snp.makeConstraints { make in
                make.top.equalTo(seperatorLine2.snp.bottom).offset(10)
                make.leading.equalToSuperview().offset(12)
                make.width.equalTo(141)
                make.height.equalTo(24)
            }

            let copyFittingNumBtn = UIButton()
            copyFittingNumBtn.setImage(UIImage(named: "copy"), for: .normal)
            copyFittingNumBtn.addTarget(self, action: #selector(copyToClipboard), for: .touchUpInside)
            box.addSubview(copyFittingNumBtn)
            copyFittingNumBtn.snp.makeConstraints { make in
                make.trailing.equalToSuperview().inset(12)
                make.width.height.equalTo(15)
                make.top.equalTo(seperatorLine2.snp.bottom).offset(14.5)
            }

            let fittingNumberLabel = UILabel()
            fittingNumberLabel.text = "\(NetworkManager.shared.installationNum[i])"
            fittingNumberLabel.font = UIFont(name: "Helvetica", size: 15)
            fittingNumberLabel.textAlignment = .right
            box.addSubview(fittingNumberLabel)
            fittingNumberLabel.snp.makeConstraints { make in
                make.top.equalTo(seperatorLine2.snp.bottom).offset(10)
                make.leading.equalTo(fittingNumLabel.snp.trailing).offset(10)
                make.width.equalTo(115)
                make.height.equalTo(24)
            }

            let copyContractNumBtn = UIButton()
            copyContractNumBtn.setImage(UIImage(named: "copy"), for: .normal)
            box.addSubview(copyContractNumBtn)
            copyContractNumBtn.snp.makeConstraints { make in
                make.trailing.equalToSuperview().inset(12)
                make.width.height.equalTo(15)
                make.top.equalTo(copyFittingNumBtn.snp.bottom).offset(31)
            }

            let contractNumLabel = UILabel()
            contractNumLabel.text = "Sözleşme\nHesap Numarası:"
            contractNumLabel.font = UIFont(name: "Helvetica-Bold", size: 15)
            contractNumLabel.numberOfLines = .zero
            box.addSubview(contractNumLabel)
            contractNumLabel.snp.makeConstraints { make in
                make.top.equalTo(fittingNumLabel.snp.bottom).offset(10)
                make.leading.equalToSuperview().offset(12)
                make.width.equalTo(141)
                make.height.equalTo(48)
            }
            let contractNumberLabel = UILabel()
            contractNumberLabel.text = "\(NetworkManager.shared.contractNum[i])"
            contractNumberLabel.font = UIFont(name: "Helvetica", size: 15)
            contractNumberLabel.textAlignment = .right
            box.addSubview(contractNumberLabel)
            contractNumberLabel.snp.makeConstraints { make in
                make.top.equalTo(fittingNumberLabel.snp.bottom).offset(22)
                make.leading.equalTo(contractNumLabel.snp.trailing).offset(10)
                make.width.equalTo(115)
                make.height.equalTo(24)
            }

            let seperatorLine3 = UIView()
            seperatorLine3.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1)
            box.addSubview(seperatorLine3)

            seperatorLine3.snp.makeConstraints { make in
                make.top.equalTo(contractNumLabel.snp.bottom).offset(10)
                make.height.equalTo(1)
                make.leading.equalToSuperview().offset(12)
                make.trailing.equalToSuperview().inset(12)
            }

            let currentDebtLabel = UILabel()
            currentDebtLabel.text = "Güncel Borç:"
            currentDebtLabel.font = UIFont(name: "Helvetica-Bold", size: 15)
            currentDebtLabel.numberOfLines = .zero
            box.addSubview(currentDebtLabel)
            currentDebtLabel.snp.makeConstraints { make in
                make.top.equalTo(seperatorLine3.snp.bottom).offset(10)
                make.leading.equalToSuperview().offset(12)
                make.width.equalTo(141)
                make.height.equalTo(24)
            }

            let currentDebtAmountLabel = UILabel()
            currentDebtAmountLabel.text = "₺ \(NetworkManager.shared.debtAmount[i])"
            currentDebtAmountLabel.font = UIFont(name: "Helvetica", size: 15)
            currentDebtAmountLabel.textAlignment = .right
            box.addSubview(currentDebtAmountLabel)
            currentDebtAmountLabel.snp.makeConstraints { make in
                make.top.equalTo(currentDebtLabel.snp.top)
                make.trailing.equalToSuperview().inset(12)
                make.width.equalTo(140)
                make.height.equalTo(24)
            }

            let showDetailBtn = UIButton()
            showDetailBtn.setImage(UIImage(named: "show"), for: .normal)
            showDetailBtn.setTitle("Button \(i)", for: .normal)
            showDetailBtn.tag = i
            showDetailBtn.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
            box.addSubview(showDetailBtn)
            showDetailBtn.snp.makeConstraints { make in
                make.leading.equalToSuperview().offset(12)
                make.trailing.equalToSuperview().inset(12)
                make.top.equalTo(currentDebtLabel.snp.bottom).offset(10)
                make.height.equalTo(50)
            }

            stackView.addArrangedSubview(box)
            box.snp.makeConstraints { make in
                make.height.equalTo(346)
            }
        }

    }
    
    @objc func copyToClipboard() {
        let stringToCopy = NetworkManager.shared.installationNum[0]
        UIPasteboard.general.string = stringToCopy

        let alert = UIAlertController(title: "Kopyalandı", message: "Numara Panoya Kopyalandı", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true, completion: nil)
    }

    
    @objc func buttonPressed(_ sender: UIButton) {
        
        let billDetailVC = BillDetailVC()
        billDetailVC.receivedBillNumber = sender.tag
        billDetailVC.modalPresentationStyle = .fullScreen
        present(billDetailVC, animated: true)
        
    }
}

