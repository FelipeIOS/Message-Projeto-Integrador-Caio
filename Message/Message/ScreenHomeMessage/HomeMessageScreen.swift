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
    
    lazy var collectionView:UICollectionView = {
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout.init())
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsVerticalScrollIndicator = false
        cv.register(MessageListCollectionViewCell.self, forCellWithReuseIdentifier:MessageListCollectionViewCell.identifier )
        cv.backgroundColor = .clear
        cv.setCollectionViewLayout(layout, animated: false)
        cv.delaysContentTouches = false
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(navView)
        self.addSubview(collectionView)
        self.setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func delegateCollectionView(controller:UIViewController){
        self.collectionView.delegate = controller as? UICollectionViewDelegate
        self.collectionView.dataSource = controller as? UICollectionViewDataSource
    }
    
   private func setUpConstraints(){
        NSLayoutConstraint.activate([
            
            navView.topAnchor.constraint(equalTo: self.topAnchor),
            navView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            navView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            navView.heightAnchor.constraint(equalToConstant: 140),
            
            collectionView.topAnchor.constraint(equalTo: navView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    
}
