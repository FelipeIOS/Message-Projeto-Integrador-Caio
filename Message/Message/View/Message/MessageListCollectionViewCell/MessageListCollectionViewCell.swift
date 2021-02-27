//
//  MessageListTableViewCell.swift
//  Message
//
//  Created by Caio on 16/02/21.
//

import UIKit

class MessageListCollectionViewCell: UICollectionViewCell {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(customImageView)
        addSubview(userName)
        addSubview(dateLabel)
        addSubview(pendingMessageView)
        pendingMessageView.addSubview(pendingLabel)
        setUpConstraints()
    }
    
    static let identifier:String = "MessageListCollectionViewCell"
    
    var data:MessageList?{
        didSet {
            self.manageData()
        }
    }
    
    let customImageView:CustomImageView = {
        let v = CustomImageView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let userName:UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.numberOfLines = 2
        return l
    }()
    
    let dateLabel:UILabel = {
        let l = UILabel()
        l.text = "10/03/2020"
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont(name: CustomFont.poppinsMedium, size: 13)
        l.textColor = .lightGray
        return l
    }()
    
    let pendingMessageView:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = CustomColor.appPink
        v.layer.cornerRadius = 8
        return v
    }()
    
    let pendingLabel:UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "4"
        l.font = UIFont(name: CustomFont.poppinsBold, size: 14)
        l.textColor = .white
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
            userName.trailingAnchor.constraint(equalTo: pendingMessageView.leadingAnchor, constant: -10),
            
            pendingMessageView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -30),
            pendingMessageView.heightAnchor.constraint(equalToConstant: 20),
            pendingMessageView.widthAnchor.constraint(equalToConstant:26),
            pendingMessageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30),
            
            pendingLabel.centerYAnchor.constraint(equalTo: pendingMessageView.centerYAnchor),
            pendingLabel.centerXAnchor.constraint(equalTo: pendingMessageView.centerXAnchor),
            
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            dateLabel.bottomAnchor.constraint(equalTo: pendingMessageView.topAnchor, constant: -5)
        ])
    }
    
    func setupView(username:String,imageUser:String){
        self.setUserName(userName: username)
    }
    
    func manageData(){
        guard let data = self.data else {return}
        customImageView.setupCustomImageView(messageList: data)
        self.setUserNameAttributedText()
        self.dateLabel.text = data.date
        if data.pending ?? false{
            self.pendingMessageView.isHidden = false
            self.pendingLabel.text = data.pendingCount
        } else {
            self.pendingMessageView.isHidden = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUserNameAttributedText(){
        guard let data = self.data else {return}
        let attributedText = NSMutableAttributedString(string:"\(data.userName ?? "")" , attributes:[NSAttributedString.Key.font: UIFont(name:CustomFont.poppinsMedium, size: 16) ?? UIFont(),NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        
        attributedText.append(NSAttributedString(string: "\n\(data.lastMessage ?? "")" , attributes:[NSAttributedString.Key.font: UIFont(name:CustomFont.poppinsMedium, size: 14) ?? UIFont(), NSAttributedString.Key.foregroundColor: UIColor.lightGray]))
        
        self.userName.attributedText = attributedText
    }
    
    func setUserName(userName:String){
        let attributedText = NSMutableAttributedString(string:userName, attributes:[NSAttributedString.Key.font: UIFont(name:CustomFont.poppinsMedium, size: 16) ?? UIFont(),NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        
        self.userName.attributedText = attributedText
    }
}


