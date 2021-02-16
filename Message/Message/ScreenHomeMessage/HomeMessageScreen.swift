//
//  HomeMessageScreen.swift
//  Message
//
//  Created by Caio on 15/02/21.
//

import UIKit

class HomeMessageScreen: UIView {

    let navView:MessageListNavigationView = {
        let v = MessageListNavigationView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var tableView:UITableView = {
        let cv = UITableView()
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsVerticalScrollIndicator = false
//        cv.register(MessageListCollectionViewCell.self, forCellWithReuseIdentifier: "MessageListCollectionViewCell")
        cv.backgroundColor = .clear
//        cv.delegate = self
//        cv.dataSource = self
        cv.delaysContentTouches = false
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(navView)
        self.addSubview(tableView)
        self.setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpConstraints(){
        NSLayoutConstraint.activate([
            
            navView.topAnchor.constraint(equalTo: self.topAnchor),
            navView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            navView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            navView.heightAnchor.constraint(equalToConstant: 140),
            
            tableView.topAnchor.constraint(equalTo: navView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    
}
