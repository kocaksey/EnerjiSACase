//
//  BillDetailVC.swift
//  EnerjiSA
//
//  Created by Seyhun Koçak on 3.08.2023.
//

import UIKit
import SnapKit

class BillDetailVC: UIViewController, UITextFieldDelegate{
    static let sharred = BillDetailVC()
    var receivedBillNumber : Int?
    let tcField = UITextField()
    let idErrorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Girdiğiniz T.C. Kimlik numarası doğru değildir"
        label.isHidden = true
        return label
    }()
    
    let phoneField = UITextField()
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    let scrollView = UIScrollView()
    
    let tableView = UITableView()

    let invoices = NetworkManager.shared.invoices
    var grouppedBill = [Invoice]()
    
    
    let popupView = CustomPopupView()
    let overlayView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        tcField.delegate = self
        phoneField.delegate = self
        view.backgroundColor = .white
        tableView.allowsSelection = true

        setupUI()

    }
    func setupUI(){
 
        for x in invoices {
            if x.installationNumber == NetworkManager.shared.installationNum[receivedBillNumber!] {
                grouppedBill.append(x)
            }
        }

        let navBarView = UIView()
        self.view.addSubview(navBarView)

        navBarView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(108)  
        }
    
        view.addSubview(scrollView)
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false

        scrollView.snp.makeConstraints { make in
            make.top.equalTo(navBarView.snp.bottom)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
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
        titleLabel.text = "FATURA DETAYI"
        titleLabel.textColor = .white
        titleLabel.font = UIFont(name:"Helvetica-Bold", size: 16)

        navBarView.addSubview(titleLabel)

        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(35)

        }

        let backButton = UIButton()
        backButton.setImage(UIImage(named: "back"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
        navBarView.addSubview(backButton)

        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(54)
            make.height.width.equalTo(24)
        }
        lazy var personalLabel = UILabel()
        personalLabel.text = "KİŞİSEL BİLGİLER"
        personalLabel.font = UIFont(name: "Helvetica-Bold", size: 14)
        scrollView.addSubview(personalLabel)
        personalLabel.snp.makeConstraints { make in
            make.top.equalTo(scrollView).offset(28)
            make.leading.equalToSuperview().offset(30)
            make.width.equalTo(132)
            make.height.equalTo(23)
        }
        
        lazy var nameLabel = UILabel()
        nameLabel.text = "Adınız Soyadınız"
        nameLabel.font = UIFont(name: "Helvetica-Bold", size: 14)
        scrollView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(personalLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().inset(30)
            make.height.equalTo(23)
        }
        
        let nameField = UITextField()
        nameField.placeholder = " Adınız Soyadınız"
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 2.0))
        nameField.leftView = leftView
        nameField.leftViewMode = .always
        nameField.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        nameField.layer.cornerRadius = 10
        nameField.autocorrectionType = .no
        nameField.autocapitalizationType = .none
        
        scrollView.addSubview(nameField)
        nameField.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().inset(30)
            make.width.equalTo(315)
            make.height.equalTo(44)
        }
        
        lazy var tcLabel = UILabel()
        tcLabel.text = "T.C. Kimlik Numaranız:"
        tcLabel.font = UIFont(name: "Helvetica-Bold", size: 14)
        scrollView.addSubview(tcLabel)
        tcLabel.snp.makeConstraints { make in
            make.top.equalTo(nameField.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().inset(30)
            make.height.equalTo(24)
        }
        
        tcField.placeholder = " XXXXXXXXXXX"
        let leftView2 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 2.0))
        tcField.leftView = leftView2
        tcField.leftViewMode = .always
        tcField.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        tcField.layer.cornerRadius = 10
        tcField.autocorrectionType = .no
        tcField.autocapitalizationType = .none
        scrollView.addSubview(tcField)
        tcField.snp.makeConstraints { make in
            make.top.equalTo(tcLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().inset(30)
            make.width.equalTo(315)
            make.height.equalTo(44)
        }
        scrollView.addSubview(idErrorLabel)
        idErrorLabel.snp.makeConstraints { make in
            make.top.equalTo(tcField.snp.bottom).offset(4)
            make.leading.trailing.equalTo(tcField)
        }
        
        lazy var mailLabel = UILabel()
        mailLabel.text = "E-Posta Adresiniz"
        mailLabel.font = UIFont(name: "Helvetica-Bold", size: 14)
        scrollView.addSubview(mailLabel)
        mailLabel.snp.makeConstraints { make in
            make.top.equalTo(tcField.snp.bottom).offset(29)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().inset(30)
            make.height.equalTo(23)
        }
        
        let mailField = UITextField()
        mailField.placeholder = " E-Posta Adresiniz"
        let leftView3 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 2.0))
        mailField.leftView = leftView3
        mailField.leftViewMode = .always
        mailField.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        mailField.layer.cornerRadius = 10
        mailField.autocorrectionType = .no
        mailField.autocapitalizationType = .none
        scrollView.addSubview(mailField)
        mailField.snp.makeConstraints { make in
            make.top.equalTo(mailLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().inset(30)
            make.width.equalTo(315)
            make.height.equalTo(44)
        }
        
        lazy var phoneLabel = UILabel()
        phoneLabel.text = "Cep Telefonu Numaranız"
        phoneLabel.font = UIFont(name: "Helvetica-Bold", size: 14)
        scrollView.addSubview(phoneLabel)
        phoneLabel.snp.makeConstraints { make in
            make.top.equalTo(mailField.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().inset(30)
            make.height.equalTo(23)
        }
        
        phoneField.placeholder = " (5XX) XXX XX XX"
        let leftView4 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 2.0))
        phoneField.leftView = leftView4
        phoneField.leftViewMode = .always
        phoneField.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        phoneField.layer.cornerRadius = 10
        phoneField.autocorrectionType = .no
        phoneField.autocapitalizationType = .none
        scrollView.addSubview(phoneField)
        phoneField.snp.makeConstraints { make in
            make.top.equalTo(phoneLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().inset(30)
            make.width.equalTo(315)
            make.height.equalTo(44)
        }
        
        lazy var installationDetailLabel = UILabel()
        installationDetailLabel.text = "TESİSAT DETAYI"
        installationDetailLabel.font = UIFont(name: "Helvetica-Bold", size: 14)
        scrollView.addSubview(installationDetailLabel)
        installationDetailLabel.snp.makeConstraints { make in
            make.top.equalTo(phoneField.snp.bottom).offset(23)
            make.leading.equalToSuperview().offset(30)
            make.width.equalTo(120)
            make.height.equalTo(24)
        }
        
        let detailBox = UIView()
        
        detailBox.backgroundColor = .white
        detailBox.layer.shadowColor = UIColor(red: 0.682, green: 0.682, blue: 0.753, alpha: 0.4).cgColor
        detailBox.layer.shadowOffset = CGSize(width: 5, height: 5)
        detailBox.layer.shadowOpacity = 1
        detailBox.layer.shadowRadius = 20
        detailBox.layer.cornerRadius = 10
        
        let locationNameLabel = UILabel()
        locationNameLabel.text = "\(NetworkManager.shared.company[receivedBillNumber!])"
        locationNameLabel.font = UIFont(name: "Helvetica-Bold", size: 15)
        detailBox.addSubview(locationNameLabel)
        locationNameLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().inset(12)
            make.height.equalTo(24)
        }
        
        let seperatorLine1 = UIView()
        seperatorLine1.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1)
        detailBox.addSubview(seperatorLine1)

        seperatorLine1.snp.makeConstraints { make in
            make.top.equalTo(locationNameLabel.snp.bottom).offset(10)
            make.height.equalTo(1)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().inset(12)
        }

        let locationLabel = UILabel()
        locationLabel.text = "Adres:"
        locationLabel.font = UIFont(name: "Helvetica-Bold", size: 15)
        detailBox.addSubview(locationLabel)
        locationLabel.snp.makeConstraints { make in
            make.top.equalTo(seperatorLine1.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().inset(12)
            make.height.equalTo(24)
        }

        let addressLabel = UILabel()
        addressLabel.text = "\(NetworkManager.shared.address[receivedBillNumber!])"
        addressLabel.font = UIFont(name: "Helvetica", size: 15)
        addressLabel.numberOfLines = .zero
        detailBox.addSubview(addressLabel)
        addressLabel.snp.makeConstraints { make in
            make.top.equalTo(locationLabel.snp.bottom)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().inset(12)
            make.height.equalTo(49)
        }

        let seperatorLine2 = UIView()
        seperatorLine2.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1)
        detailBox.addSubview(seperatorLine2)

        seperatorLine2.snp.makeConstraints { make in
            make.top.equalTo(addressLabel.snp.bottom).offset(10)
            make.height.equalTo(1)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().inset(12)
        }

        let fittingNumLabel = UILabel()
        fittingNumLabel.text = "Tesisat Numarası:"
        fittingNumLabel.font = UIFont(name: "Helvetica-Bold", size: 15)
        detailBox.addSubview(fittingNumLabel)
        fittingNumLabel.snp.makeConstraints { make in
            make.top.equalTo(seperatorLine2.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(12)
            make.width.equalTo(141)
            make.height.equalTo(24)
        }
        let fittingNumberLabel = UILabel()
        fittingNumberLabel.text = "\(NetworkManager.shared.installationNum[receivedBillNumber!])"
        fittingNumberLabel.font = UIFont(name: "Helvetica", size: 15)
        fittingNumberLabel.textAlignment = .right
        detailBox.addSubview(fittingNumberLabel)
        fittingNumberLabel.snp.makeConstraints { make in
            make.top.equalTo(seperatorLine2.snp.bottom).offset(10)
            make.leading.equalTo(fittingNumLabel.snp.trailing).offset(10)
            make.width.equalTo(115)
            make.height.equalTo(24)
        }

        let contractNumLabel = UILabel()
        contractNumLabel.text = "Sözleşme\nHesap Numarası:"
        contractNumLabel.font = UIFont(name: "Helvetica-Bold", size: 15)
        contractNumLabel.numberOfLines = .zero
        detailBox.addSubview(contractNumLabel)
        contractNumLabel.snp.makeConstraints { make in
            make.top.equalTo(fittingNumLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(12)
            make.width.equalTo(141)
            make.height.equalTo(48)
        }
        let contractNumberLabel = UILabel()
        contractNumberLabel.text = "\(NetworkManager.shared.contractNum[receivedBillNumber!])"
        contractNumberLabel.font = UIFont(name: "Helvetica", size: 15)
        contractNumberLabel.textAlignment = .right
        detailBox.addSubview(contractNumberLabel)
        contractNumberLabel.snp.makeConstraints { make in
            make.top.equalTo(fittingNumberLabel.snp.bottom).offset(22)
            make.leading.equalTo(contractNumLabel.snp.trailing).offset(10)
            make.width.equalTo(115)
            make.height.equalTo(24)
        }
        
        let seperatorLine3 = UIView()
        seperatorLine3.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1)
        detailBox.addSubview(seperatorLine3)

        seperatorLine3.snp.makeConstraints { make in
            make.top.equalTo(contractNumLabel.snp.bottom).offset(10)
            make.height.equalTo(1)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().inset(12)
        }
        
        let infoImage = UIImageView()
        infoImage.image = UIImage(named: "info")
        detailBox.addSubview(infoImage)
        
        infoImage.snp.makeConstraints { make in
            make.top.equalTo(seperatorLine3.snp.bottom).offset(22)
            make.leading.equalToSuperview().offset(24)
            make.height.width.equalTo(24)
        }
        var invoiceCounts: [String: Int] = [:]

        for invoice in invoices {
            if let count = invoiceCounts[invoice.installationNumber] {
                invoiceCounts[invoice.installationNumber] = count + 1
            } else {
                invoiceCounts[invoice.installationNumber] = 1
            }
        }

        let infoLabel = UILabel()
        infoLabel.text = "Seçili sözleşme hesabınıza ait \(invoiceCounts[NetworkManager.shared.installationNum[receivedBillNumber!]]!) adet ödenmemiş fatura bulunmaktadır."
        infoLabel.font = UIFont(name: "Helvetica-Bold", size: 14)

        infoLabel.numberOfLines = .zero
        detailBox.addSubview(infoLabel)
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(seperatorLine3.snp.bottom).offset(22)
            make.leading.equalTo(infoImage.snp.trailing).offset(12)
            make.trailing.equalToSuperview().inset(24)
            make.height.equalTo(50)
        }
        lazy var totalDebt = UILabel()
        totalDebt.font = UIFont(name: "Helvetica-Bold", size: 14)
        totalDebt.text = "Toplam Borç:"
        detailBox.addSubview(totalDebt)
        totalDebt.snp.makeConstraints { make in
            make.leading.equalTo(infoLabel.snp.leading)
            make.height.equalTo(20)
            make.width.equalTo(130)
            make.top.equalTo(infoLabel.snp.bottom).offset(10)
        }
        
        let totalDebtAmount = UILabel()
        totalDebtAmount.font = UIFont(name: "Helvetica", size: 14)
        totalDebtAmount.textAlignment = .right
        totalDebtAmount.text = "₺\(NetworkManager.shared.debtAmount[receivedBillNumber!])"
        detailBox.addSubview(totalDebtAmount)
        totalDebtAmount.snp.makeConstraints { make in
            make.top.equalTo(totalDebt.snp.top)
            make.trailing.equalToSuperview().inset(24)
            make.width.equalTo(70)
            make.height.equalTo(20)
        }
        scrollView.addSubview(detailBox)
        detailBox.snp.makeConstraints { make in
            make.top.equalTo(installationDetailLabel.snp.bottom).offset(20)
            make.height.equalTo(355)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().inset(30)
        }
        
        let tableUiView = UIView()
        scrollView.addSubview(tableUiView)
        tableUiView.backgroundColor = .white
        tableUiView.snp.makeConstraints { make in
            make.top.equalTo(detailBox.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().inset(30)
            make.bottom.equalToSuperview().inset(40)
            make.height.equalTo(230)
        }
        
        let expiryDateLabel = UILabel()
        expiryDateLabel.text = "Vade     Tarihi"
        expiryDateLabel.numberOfLines = .zero
        expiryDateLabel.font = UIFont(name: "Helvetica", size: 14)
        expiryDateLabel.textAlignment = .center
        tableUiView.addSubview(expiryDateLabel)
        expiryDateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(9)
            make.width.equalTo(70)
            make.height.equalTo(36)
        }
        
        let paidLabel = UILabel()
        paidLabel.text = "Ödenecek   Tutar"
        paidLabel.numberOfLines = .zero
        paidLabel.font = UIFont(name: "Helvetica", size: 14)
        paidLabel.textAlignment = .center
        tableUiView.addSubview(paidLabel)
        paidLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalTo(expiryDateLabel.snp.trailing).offset(17)
            make.width.equalTo(70)
            make.height.equalTo(36)
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(BillTableViewCell.self, forCellReuseIdentifier: BillTableViewCell.identifier)

        tableUiView.addSubview(tableView)

        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(expiryDateLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().inset(8)
            make.bottom.equalToSuperview().inset(8)
        }
 
        self.view.addSubview(overlayView)
        overlayView.layer.zPosition = 1
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        overlayView.isHidden = true
        overlayView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        self.view.addSubview(popupView)
        popupView.layer.zPosition = 2
        popupView.isHidden = true
        popupView.snp.makeConstraints { make in
            make.width.height.equalTo(355)
            make.center.equalToSuperview()
        }
        
        popupView.onClose = { [weak self] in
            self?.popupView.isHidden = true
            self?.overlayView.isHidden = true
        }

    }
    
    @objc func hidePopupView() {
        popupView.isHidden = true
        overlayView.isHidden = true
    }

    @objc func backButtonAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == tcField {
            let currentText = textField.text ?? ""
            let prospectiveText = (currentText as NSString).replacingCharacters(in: range, with: string)

            guard CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: string)), prospectiveText.count <= 11 else {
                return false
            }

            if prospectiveText.count == 11 {
                let isValid = isValidTurkishNationalId(id: prospectiveText)
                
                idErrorLabel.isHidden = isValid
                tcField.layer.borderColor = isValid ? UIColor.clear.cgColor : UIColor.red.cgColor
                tcField.layer.borderWidth = isValid ? 0 : 1
                
                return isValid
            }
            
            idErrorLabel.isHidden = true
            tcField.layer.borderColor = UIColor.clear.cgColor
            tcField.layer.borderWidth = 0
            
            return true
        }
        
        if textField == phoneField {
                   let currentText = textField.text ?? ""
                   let prospectiveText = (currentText as NSString).replacingCharacters(in: range, with: string)
                   
                   let isNumeric = CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: string))
                   
                   let newLength = prospectiveText.filter { "0123456789".contains($0) }.count
                   
                   let hasLeadingOne = prospectiveText.hasPrefix("(1)")
                   
                   if isNumeric && newLength <= 10 || (string.count == 0 && newLength <= 10) {
                       if newLength == 1 && prospectiveText.count == 1 {
                           phoneField.text = "(\(prospectiveText)"
                           return false
                       } else if newLength == 3 && prospectiveText.count == 4 && !hasLeadingOne {
                           phoneField.text = "\(prospectiveText)) "
                           return false
                       } else if newLength == 6 && prospectiveText.count == 9 {
                           phoneField.text = "\(prospectiveText) "
                           return false
                       } else if newLength == 8 && prospectiveText.count == 12 {
                           phoneField.text = "\(prospectiveText) "
                           return false
                       }
                       return true
                   } else {
                       return false
                   }
               }
        return true
    }

    func isValidTurkishNationalId(id: String) -> Bool {
        guard id.count == 11, let numbers = id.compactMap({ Int(String($0)) }) as? [Int], numbers.count == 11 else {
            print("TC kimlik numarası geçersiz: yanlış format")
            return false
        }
        
        let first10 = Array(numbers[0..<10])
        let first9 = Array(numbers[0..<9])
        let tenth = (7 * (first9[0] + first9[2] + first9[4] + first9[6]) - (first9[1] + first9[3] + first9[5] + first9[7])) % 10
        let eleventh = (first10.reduce(0, +)) % 10
        let isValid = numbers[9] == tenth && numbers[10] == eleventh
        
        print("TC kimlik numarası geçerli mi? \(isValid)")
        return isValid
    }
    
}

extension BillDetailVC : UITableViewDataSource, UITableViewDelegate  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return grouppedBill.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BillTableViewCell.identifier, for: indexPath) as! BillTableViewCell
        cell.selectionStyle = .none
        cell.documentBtn.isUserInteractionEnabled = true
        cell.documentBtn.tag = indexPath.row

        
        let invoice = grouppedBill[indexPath.row]
        cell.dueDateLabel.text = "\(invoice.dueDate)"
        cell.amountLabel.text = "₺\(invoice.amount)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 39
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)
        
        let installNum = NetworkManager.shared.installationNum[receivedBillNumber!]
        let dueDates = grouppedBill[indexPath.row].dueDate
        
        
        popupView.configure(with: installNum, dueDates: dueDates)
        popupView.isHidden = false
        overlayView.isHidden = false

    }
    
}







    

    
    

    




