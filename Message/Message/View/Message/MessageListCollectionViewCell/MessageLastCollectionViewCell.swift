//
//  MessageLastCollectionViewCell.swift
//  Message
//
//  Created by Caio on 23/02/21.
//

import UIKit

class MessageLastCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(customImageView)
        addSubview(userName)
        self.setUpConstraints()
        self.setUserNameAttributedText()
    }
    
    static let identifier:String = "MessageLastCollectionViewCell"
    
   
    
    let customImageView:CustomImageView = {
        let v = CustomImageView()
        var image:UIImage?
        image = UIImage(systemName: "person.badge.plus")
        image?.withTintColor(.black, renderingMode: .alwaysTemplate)
        v.imageView.image = image
        v.imageView.clipsToBounds = false
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let userName:UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.numberOfLines = 2
        return l
    }()

    func setUpConstraints(){
        NSLayoutConstraint.activate([
            customImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            customImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            customImageView.widthAnchor.constraint(equalToConstant: 55),
            customImageView.heightAnchor.constraint(equalToConstant: 55),
            
            userName.leadingAnchor.constraint(equalTo: customImageView.trailingAnchor, constant: 15),
            userName.centerYAnchor.constraint(equalTo: centerYAnchor),
            userName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUserNameAttributedText(){
        let attributedText = NSMutableAttributedString(string:"Adicionar novo Contato" , attributes:[NSAttributedString.Key.font: UIFont(name:CustomFont.poppinsMedium, size: 16) ?? UIFont(),NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        
        self.userName.attributedText = attributedText
    }
}
