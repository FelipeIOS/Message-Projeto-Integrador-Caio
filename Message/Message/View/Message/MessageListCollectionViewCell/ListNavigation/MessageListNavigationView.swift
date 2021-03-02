//
//  MessageListNavigationView.swift
//  Message
//
//  Created by Caio on 15/02/21.
//

import UIKit

enum TypeConversationOrContact{
    case conversation
    case contact
}

protocol MessageListNavigationViewProtocol:class{
    func typeScreenMessage(type:TypeConversationOrContact)
}

class MessageListNavigationView: UIView {
    
    
    weak var delegate:MessageListNavigationViewProtocol?
    
    func delegate(delegate:MessageListNavigationViewProtocol){
        self.delegate = delegate
    }
    
    let navBackView:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .white
        v.layer.cornerRadius = 35
        v.layer.maskedCorners = [.layerMaxXMaxYCorner]
        v.layer.shadowColor = UIColor(white: 0, alpha: 0.02).cgColor
        v.layer.shadowOffset = CGSize(width: 0, height: 5)
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
        btn.setImage(UIImage(named: "search"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let stackView:UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.distribution = .fillEqually
        sv.axis = .horizontal
        sv.spacing = 10
        return sv
    }()
    
   lazy var conversationButton:UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(systemName: "message")?.withRenderingMode(.alwaysTemplate), for: .normal)
        btn.tintColor = .systemPink
        btn.addTarget(self, action: #selector(self.tappedConversationRegister), for: .touchUpInside)
        return btn
    }()
    
   lazy var contactButton:UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "group")?.withRenderingMode(.alwaysTemplate), for: .normal)
        btn.tintColor = .black
        btn.addTarget(self, action: #selector(self.tappedContactButton), for: .touchUpInside)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(navBackView)
        navBackView.addSubview(navBar)
        navBar.addSubview(searchBar)
        navBar.addSubview(stackView)
        stackView.addArrangedSubview(conversationButton)
        stackView.addArrangedSubview(contactButton)
        searchBar.addSubview(searchLabel)
        searchBar.addSubview(searchBtn)
        setUpConstraints()
    }
    
    func setUpConstraints(){
        NSLayoutConstraint.activate([
            navBackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            navBackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            navBackView.topAnchor.constraint(equalTo: topAnchor),
            navBackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            navBar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            navBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            navBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            navBar.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            searchBar.leadingAnchor.constraint(equalTo: navBar.leadingAnchor, constant: 30),
            searchBar.centerYAnchor.constraint(equalTo: navBar.centerYAnchor),
            searchBar.trailingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: -20),
            searchBar.heightAnchor.constraint(equalToConstant: 55),
            
            stackView.trailingAnchor.constraint(equalTo: navBar.trailingAnchor, constant: -30),
            stackView.centerYAnchor.constraint(equalTo: navBar.centerYAnchor),
            stackView.widthAnchor.constraint(equalToConstant: 100),
            stackView.heightAnchor.constraint(equalToConstant: 30),
            
            searchLabel.leadingAnchor.constraint(equalTo: searchBar.leadingAnchor, constant: 25),
            searchLabel.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor),
            
            searchBtn.trailingAnchor.constraint(equalTo: searchBar.trailingAnchor, constant: -20),
            searchBtn.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor),
            searchBtn.widthAnchor.constraint(equalToConstant: 20),
            searchBtn.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    //MARK: - Actions
    
    @objc func tappedConversationRegister(){
        self.delegate?.typeScreenMessage(type: .conversation)
        self.conversationButton.tintColor = .systemPink
        self.contactButton.tintColor = .black
    }
    
    @objc func tappedContactButton(){
        self.delegate?.typeScreenMessage(type: .contact)
        self.contactButton.tintColor = .systemPink
        self.conversationButton.tintColor = .black
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
