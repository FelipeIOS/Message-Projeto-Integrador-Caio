//
//  HomeMessageScreen.swift
//  Message
//
//  Created by Caio on 15/02/21.
//

import UIKit

protocol HomeMessageScreenProtocol:class {
    func actionConfigUser()
}

class HomeMessageScreen: UIView {

    var heightAndWidthButton:CGFloat = CGFloat(40)
    weak var delegate:HomeMessageScreenProtocol?
    
    public func delegate(delegate:HomeMessageScreenProtocol){
        self.delegate = delegate
    }
    
    let navView:MessageListNavigationView = {
        let v = MessageListNavigationView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var collectionView:UICollectionView = {
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout.init())
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsVerticalScrollIndicator = false
        cv.register(MessageListCollectionViewCell.self, forCellWithReuseIdentifier:MessageListCollectionViewCell.identifier )
        cv.register(MessageLastCollectionViewCell.self, forCellWithReuseIdentifier: MessageLastCollectionViewCell.identifier)
        cv.backgroundColor = .clear
        cv.setCollectionViewLayout(layout, animated: false)
        cv.delaysContentTouches = false
        return cv
    }()
    
    lazy var ajustesButton:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
//        var image = UIImage(named: "ajustes")
//        image?.withTintColor(.black, renderingMode: .alwaysTemplate)
//        button.setImage(image, for: .normal)
        button.backgroundColor = .lightGray
        button.clipsToBounds = true
        button.layer.cornerRadius = self.heightAndWidthButton/2
        button.addTarget(self, action: #selector(self.tappedConfigUser), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.navView)
        
        self.addSubview(self.collectionView)
        self.addSubview(self.ajustesButton)
        self.setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func tappedConfigUser(){
        self.delegate?.actionConfigUser()
    }
    
    public func delegateCollectionView(delegate:UICollectionViewDelegate,dataSource:UICollectionViewDataSource){
        self.collectionView.delegate = delegate
        self.collectionView.dataSource = dataSource
    }
    
    public func reloadCollection(){
        self.collectionView.reloadData()
    }
    
   private func setUpConstraints(){
        NSLayoutConstraint.activate([
            
            self.navView.topAnchor.constraint(equalTo: self.topAnchor),
            self.navView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.navView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.navView.heightAnchor.constraint(equalToConstant: 140),
            
            self.collectionView.topAnchor.constraint(equalTo: navView.bottomAnchor),
            self.collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.ajustesButton.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: CGFloat(-20)),
            self.ajustesButton.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: CGFloat(-25)),
            self.ajustesButton.heightAnchor.constraint(equalToConstant: self.heightAndWidthButton),
            self.ajustesButton.widthAnchor.constraint(equalToConstant: self.heightAndWidthButton)
        ])
    }
}
