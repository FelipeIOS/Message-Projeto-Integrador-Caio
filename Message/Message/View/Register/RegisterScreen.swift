//
//  RegisterScreen.swift
//  Message
//
//  Created by Caio on 21/02/21.
//

import UIKit

class RegisterScreen: UIView {
    
    var heightImageUser:CGFloat = 200
    
    
    lazy var imageAddUser:UIImageView = {
     let image = UIImageView()
     image.image = UIImage(named: "prof-img2")
     image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
     image.layer.cornerRadius = self.heightImageUser / 2
     image.translatesAutoresizingMaskIntoConstraints = false
      return image
    }()
    
    lazy var addImageButton:UIButton = {
      let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Adicionar Foto", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(self.tappedAddPhotoButton), for: .touchUpInside)
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.addSubview(self.imageAddUser)
        self.addSubview(self.addImageButton)
        self.setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func tappedAddPhotoButton(){

    }
    

   private func setUpConstraints(){
        NSLayoutConstraint.activate([
            self.imageAddUser.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: CGFloat(20)),
            self.imageAddUser.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: CGFloat(110)),
            self.imageAddUser.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: CGFloat(-110)),
            self.imageAddUser.heightAnchor.constraint(equalToConstant: self.heightImageUser),
            
            self.addImageButton.topAnchor.constraint(equalTo: self.imageAddUser.bottomAnchor, constant: CGFloat(12)),
            self.addImageButton.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: CGFloat(20)),
            self.addImageButton.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: CGFloat(-20)),
            self.addImageButton.heightAnchor.constraint(equalToConstant: CGFloat(20)),
//            imageAddUser.topAnchor.constraint(equalTo: self.topAnchor),
//            imageAddUser.leadingAnchor.constraint(equalTo: self.leadingAnchor),
//            imageAddUser.trailingAnchor.constraint(equalTo: self.trailingAnchor),
//            imageAddUser.heightAnchor.constraint(equalToConstant: 140),
//
//            collectionView.topAnchor.constraint(equalTo: imageAddUser.bottomAnchor),
//            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
//            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
//            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    
}
