//
//  CustomImageView.swift
//  Message
//
//  Created by Caio on 16/02/21.
//

import UIKit

class CustomImageView: UIView {

    let imageView:UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "imagem-perfil")
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        img.layer.cornerRadius = 26
        return img
    }()
    
    let indicatorView:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .green
        v.layer.borderColor = UIColor.white.cgColor
        v.layer.borderWidth = 2.5
        v.layer.cornerRadius = 7.5
        v.isHidden = true
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(self.imageView)
        self.imageView.pin(to: self)
        addSubview(self.indicatorView)
        self.setUpConstraints()
    }
    
    
   public func setupCustomImageView(messageList:Conversa){
    self.imageView.image = UIImage(named:"imagem-perfil")
        self.indicatorView.isHidden = true
    }
    
  private func setUpConstraints(){
        NSLayoutConstraint.activate([
            indicatorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 5),
            indicatorView.topAnchor.constraint(equalTo: topAnchor, constant: 2),
            indicatorView.widthAnchor.constraint(equalToConstant: 15),
            indicatorView.heightAnchor.constraint(equalToConstant: 15),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
