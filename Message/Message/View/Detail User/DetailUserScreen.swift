//
//  DetailUserScreen.swift
//  Message
//
//  Created by Caio on 28/02/21.
//

import UIKit

class DetailUserScreen: UIView {

    var heightWidthImageUser:CGFloat = 160
 
    
    lazy var imageUser:UIImageView = {
     let image = UIImageView()
     image.image = UIImage(named: "imagem-perfil")
     image.clipsToBounds = true
     image.contentMode = .scaleAspectFit
     image.layer.cornerRadius = self.heightWidthImageUser/2
     image.translatesAutoresizingMaskIntoConstraints = false
      return image
    }()
    
    lazy var emailTextField:UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = .white
        tf.layer.borderWidth = 1.5
        tf.layer.cornerRadius = 7.5
        tf.layer.borderColor = UIColor.lightGray.cgColor
        tf.keyboardType = .emailAddress
        tf.placeholder = "Email"
        tf.font = UIFont(name: CustomFont.poppinsBold, size: 14)
        tf.textColor = .darkGray
        return tf
    }()
    
    lazy var passwordTextField:UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = .white
        tf.clipsToBounds = true
        tf.layer.borderWidth = 1.5
        tf.layer.cornerRadius = 7.5
        tf.layer.borderColor = UIColor.lightGray.cgColor
        tf.placeholder = "Senha"
//        tf.isSecureTextEntry = true
        tf.font = UIFont(name: CustomFont.poppinsBold, size: 14)
        tf.textColor = .darkGray
        return tf
    }()
    
    lazy var loginButton:UIButton = {
      let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Logar", for: .normal)
        button.titleLabel?.font = UIFont(name: CustomFont.poppinsBold, size: 18)
        button.setTitleColor(.lightGray, for: .normal)
        button.clipsToBounds = true
        button.isEnabled = false
        button.layer.cornerRadius = 7.5
        button.backgroundColor = UIColor(red: 3/255, green: 58/255, blue: 51/255, alpha: 1.0)
//        button.addTarget(self, action: #selector(self.tappedLoginButton), for: .touchUpInside)
        return button
    }()
    
    lazy var registerUserButton:UIButton = {
      let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Não tem conta? Cadastre-se", for: .normal)
        button.titleLabel?.font = UIFont(name: CustomFont.poppinsBold, size: 16)
        button.setTitleColor(.white, for: .normal)
//        button.addTarget(self, action: #selector(self.tappedScreenRegister), for: .touchUpInside)
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 24/255, green: 117/255, blue: 104/255, alpha: 1.0)
        self.addSubview(self.imageUser)
//        self.addSubview(self.emailTextField)
//        self.addSubview(self.passwordTextField)
//        self.addSubview(self.loginButton)
//        self.addSubview(self.registerUserButton)
        self.setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   private func setUpConstraints(){
        NSLayoutConstraint.activate([
            self.imageUser.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: CGFloat(20)),
            self.imageUser.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: CGFloat(20)),
            self.imageUser.heightAnchor.constraint(equalToConstant: self.heightWidthImageUser),
            self.imageUser.widthAnchor.constraint(equalToConstant: self.heightWidthImageUser),
//
//            self.emailTextField.topAnchor.constraint(equalTo: self.imageUser.bottomAnchor, constant: CGFloat(15)),
//            self.emailTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: CGFloat(20)),
//            self.emailTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: CGFloat(-20)),
//            self.emailTextField.heightAnchor.constraint(equalToConstant: CGFloat(45))
                        
//            self.passwordTextField.topAnchor.constraint(equalTo: self.emailTextField.bottomAnchor, constant: CGFloat(10)),
//            self.passwordTextField.leadingAnchor.constraint(equalTo: self.emailTextField.leadingAnchor),
//            self.passwordTextField.trailingAnchor.constraint(equalTo: self.emailTextField.trailingAnchor),
//            self.passwordTextField.heightAnchor.constraint(equalTo: self.emailTextField.heightAnchor),
//
//            self.loginButton.topAnchor.constraint(equalTo: self.passwordTextField.bottomAnchor, constant: CGFloat(10)),
//            self.loginButton.leadingAnchor.constraint(equalTo: self.emailTextField.leadingAnchor),
//            self.loginButton.trailingAnchor.constraint(equalTo: self.emailTextField.trailingAnchor),
//            self.loginButton.heightAnchor.constraint(equalTo: self.emailTextField.heightAnchor),
//
//            self.registerUserButton.topAnchor.constraint(equalTo: self.loginButton.bottomAnchor, constant: CGFloat(10)),
//            self.registerUserButton.leadingAnchor.constraint(equalTo: self.emailTextField.leadingAnchor),
//            self.registerUserButton.trailingAnchor.constraint(equalTo: self.emailTextField.trailingAnchor),
//            self.registerUserButton.heightAnchor.constraint(equalTo: self.emailTextField.heightAnchor)
        ])
    }
    
}


