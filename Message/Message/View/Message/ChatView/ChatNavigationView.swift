//
//  ChatNavigationView.swift
//  Message
//
//  Created by Caio on 20/02/21.
//

import UIKit
import Firebase

class ChatNavigationView: UIView {


    var controller:ChatViewController?{
        didSet {
            self.backBtn.addTarget(controller, action:#selector(ChatViewController.backBtnPressed), for: .touchUpInside)
        }
    }
    
    let navBackView:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .white
        v.layer.cornerRadius = 35
        v.layer.maskedCorners = [.layerMaxXMaxYCorner]
        v.layer.shadowColor = UIColor(white: 0, alpha: 0.05).cgColor
        v.layer.shadowOffset = CGSize(width: 0, height: 10)
        v.layer.shadowOpacity = 1
        v.layer.shadowRadius = 10
        return v
    }()
    
    let navBar:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .clear
        return v
    }()
    
    let searchBar:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = CustomColor.appLight
        v.layer.cornerRadius = 20
        return v
    }()
    
    let searchLabel:UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "Search"
        l.font = UIFont(name: CustomFont.poppinsMedium, size: 16)
        l.textColor = .lightGray
        return l
    }()
    
    let searchBtn:UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "search"), for: .normal)
        return btn
    }()
    
    let backBtn:UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "back"), for: .normal)
        return btn
    }()
    
    let customImage:CustomImageView = {
        let img = CustomImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(navBackView)
        self.navBackView.addSubview(navBar)
        self.navBar.addSubview(backBtn)
        self.navBar.addSubview(customImage)
        self.navBar.addSubview(searchBar)
        self.searchBar.addSubview(searchLabel)
        self.searchBar.addSubview(searchBtn)
        self.setUpConstraints()
    }
    
        func setUpConstraints(){
        NSLayoutConstraint.activate([
            self.navBackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            self.navBackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            self.navBackView.topAnchor.constraint(equalTo: topAnchor),
            self.navBackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            self.navBar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.navBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            self.navBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            self.navBar.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            self.backBtn.leadingAnchor.constraint(equalTo: navBar.leadingAnchor, constant: 30),
            self.backBtn.centerYAnchor.constraint(equalTo: navBar.centerYAnchor),
            self.backBtn.heightAnchor.constraint(equalToConstant: 30),
            self.backBtn.widthAnchor.constraint(equalToConstant: 30),
            
            self.customImage.leadingAnchor.constraint(equalTo: backBtn.trailingAnchor, constant: 20),
            self.customImage.heightAnchor.constraint(equalToConstant: 55),
            self.customImage.widthAnchor.constraint(equalToConstant: 55),
            self.customImage.centerYAnchor.constraint(equalTo: navBar.centerYAnchor),
            
            self.searchBar.leadingAnchor.constraint(equalTo: customImage.trailingAnchor, constant: 20),
            self.searchBar.centerYAnchor.constraint(equalTo: navBar.centerYAnchor),
            self.searchBar.trailingAnchor.constraint(equalTo: navBar.trailingAnchor, constant: -20),
            self.searchBar.heightAnchor.constraint(equalToConstant: 55),
            
            self.searchLabel.leadingAnchor.constraint(equalTo: searchBar.leadingAnchor, constant: 25),
            self.searchLabel.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor),
            
            self.searchBtn.trailingAnchor.constraint(equalTo: searchBar.trailingAnchor, constant: -20),
            self.searchBtn.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor),
            self.searchBtn.widthAnchor.constraint(equalToConstant: 20),
            self.searchBtn.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    public func addImageNavigationView(value:String?){
        if value == nil || value == ""{
            self.customImage.imageView.image = UIImage(named: "imagem-perfil")
        }else{
            self.customImage.imageView.sd_setImage(with: URL(string: value ?? ""), completed: nil)
        }
    }
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
