//
//  IncomingTextMessageTableViewCell.swift
//  Message
//
//  Created by Caio on 20/02/21.
//

import UIKit

class IncomingTextMessageTableViewCell: UITableViewCell {

    
    static let identifier:String = "IncomingTextMessageTableViewCell"
    
    var data:Message?{
        didSet{
            self.manageData()
        }
    }
    
    let bubbleview:UIView = {
        let bv = UIView()
        bv.translatesAutoresizingMaskIntoConstraints = false
        bv.backgroundColor = UIColor(white: 0, alpha: 0.06)
        bv.layer.cornerRadius = 20
        bv.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMinYCorner , .layerMaxXMinYCorner]
        return bv
    }()
    
    let messageTextLabel:UILabel = {
        let l = UILabel()
        l.text = "The"
        l.numberOfLines = 0
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = .darkGray
        l.font = UIFont(name: CustomFont.poppinsMedium, size: 14)
        return l
    }()
    
    let messageDetail:UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(bubbleview)
        self.bubbleview.addSubview(messageTextLabel)
        self.addSubview(messageDetail)
        self.setUpConstraints()
        self.isSelected = false
    }
    
    func setUpConstraints(){
        NSLayoutConstraint.activate([
            self.bubbleview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            self.bubbleview.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            self.bubbleview.bottomAnchor.constraint(equalTo: messageDetail.topAnchor, constant: -5),
            self.bubbleview.widthAnchor.constraint(lessThanOrEqualToConstant: 250),
            
            self.messageTextLabel.leadingAnchor.constraint(equalTo: bubbleview.leadingAnchor, constant: 15),
            self.messageTextLabel.topAnchor.constraint(equalTo: bubbleview.topAnchor, constant: 15),
            self.messageTextLabel.bottomAnchor.constraint(equalTo: bubbleview.bottomAnchor, constant: -15),
            self.messageTextLabel.trailingAnchor.constraint(equalTo: bubbleview.trailingAnchor, constant: -15),
            
            self.messageDetail.topAnchor.constraint(equalTo: bubbleview.bottomAnchor, constant: 5),
            self.messageDetail.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            self.messageDetail.heightAnchor.constraint(equalToConstant: 14),
            self.messageDetail.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
    }
    
//    func setMessageDetailAttributedText(){
//        guard let data = data else {return}
//        let attributedText = NSMutableAttributedString(string:"\(data.sentBy ?? "")" , attributes:[NSAttributedString.Key.font: UIFont(name:CustomFont.poppinsMedium, size: 12) ?? UIFont(),NSAttributedString.Key.foregroundColor: UIColor.darkGray])
//
//        attributedText.append(NSAttributedString(string: "  \(data.time ?? "")" , attributes:[NSAttributedString.Key.font: UIFont(name:CustomFont.poppinsMedium, size: 12) ?? UIFont(), NSAttributedString.Key.foregroundColor: UIColor.lightGray]))
//
//        self.messageDetail.attributedText = attributedText
//    }
    
    func manageData(){
        guard let data = data else {return}
        self.messageTextLabel.text = data.texto ?? ""
//        self.setMessageDetailAttributedText()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
