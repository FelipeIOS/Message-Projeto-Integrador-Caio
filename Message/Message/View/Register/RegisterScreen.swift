//
//  RegisterScreen.swift
//  Message
//
//  Created by Caio on 21/02/21.
//

import UIKit

protocol ActionButtonsRegisterScreenProtocol:class{
    func actionRegisterUser()
    func actionPopRegister()
}

class RegisterScreen: UIView {
    
    var heightImageUser:CGFloat = 150
    weak var delegate:ActionButtonsRegisterScreenProtocol?
    
    func delegate(delegate:ActionButtonsRegisterScreenProtocol){
        self.delegate = delegate
    }
    
   lazy var backBtn:UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "back"), for: .normal)
    btn.addTarget(self, action: #selector(self.tappedPopButton), for: .touchUpInside)
        return btn
    }()
    
    lazy var imageAddUser:UIImageView = {
     let image = UIImageView()
     image.image = UIImage(named: "usuario")
        image.contentMode = .scaleAspectFit
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
    
    lazy var nameTextField:UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = .white
        tf.layer.borderWidth = 1.5
        tf.layer.cornerRadius = 7.5
        tf.layer.borderColor = UIColor.lightGray.cgColor
        tf.keyboardType = .emailAddress
        tf.placeholder = "Nome"
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
    
    lazy var registerUserButton:UIButton = {
      let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Cadastrar", for: .normal)
        button.titleLabel?.font = UIFont(name: CustomFont.poppinsBold, size: 18)
        button.setTitleColor(.lightGray, for: .normal)
        button.clipsToBounds = true
        button.isEnabled = false
        button.layer.cornerRadius = 7.5
        button.backgroundColor = UIColor(red: 3/255, green: 58/255, blue: 51/255, alpha: 1.0)
        button.addTarget(self, action: #selector(self.tappedRegisterUserButton), for: .touchUpInside)
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 24/255, green: 117/255, blue: 104/255, alpha: 1.0)
        self.addSubview(self.backBtn)
        self.addSubview(self.imageAddUser)
        self.addSubview(self.nameTextField)
        self.addSubview(self.emailTextField)
        self.addSubview(self.passwordTextField)
        self.addSubview(self.registerUserButton)
        self.setUpConstraints()
        self.configTextFields()
    }
    
    func configTextFields(){
        self.passwordTextField.delegate = self
        self.emailTextField.delegate = self
        self.nameTextField.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func tappedRegisterUserButton(){
        self.delegate?.actionRegisterUser()
    }
    
    @objc func tappedPopButton(){
        self.delegate?.actionPopRegister()
    }
    

   private func setUpConstraints(){
        NSLayoutConstraint.activate([
            
            self.imageAddUser.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: CGFloat(20)),
            self.imageAddUser.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.imageAddUser.widthAnchor.constraint(equalToConstant: self.heightImageUser),
            self.imageAddUser.heightAnchor.constraint(equalToConstant: self.heightImageUser),
            
            self.backBtn.topAnchor.constraint(equalTo: self.imageAddUser.topAnchor),
            self.backBtn.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: CGFloat(20)),
            self.backBtn.heightAnchor.constraint(equalToConstant: 40),
            self.backBtn.widthAnchor.constraint(equalToConstant: 40),
            
            self.nameTextField.topAnchor.constraint(equalTo: self.imageAddUser.bottomAnchor, constant: CGFloat(15)),
            self.nameTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: CGFloat(20)),
            self.nameTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: CGFloat(-20)),
            self.nameTextField.heightAnchor.constraint(equalToConstant: CGFloat(45)),
            
            self.emailTextField.topAnchor.constraint(equalTo: self.nameTextField.bottomAnchor, constant: CGFloat(10)),
            self.emailTextField.leadingAnchor.constraint(equalTo: self.nameTextField.leadingAnchor),
            self.emailTextField.trailingAnchor.constraint(equalTo: self.nameTextField.trailingAnchor),
            self.emailTextField.heightAnchor.constraint(equalTo: self.nameTextField.heightAnchor),
            
            self.passwordTextField.topAnchor.constraint(equalTo: self.emailTextField.bottomAnchor, constant: CGFloat(10)),
            self.passwordTextField.leadingAnchor.constraint(equalTo: self.nameTextField.leadingAnchor),
            self.passwordTextField.trailingAnchor.constraint(equalTo: self.nameTextField.trailingAnchor),
            self.passwordTextField.heightAnchor.constraint(equalTo: self.nameTextField.heightAnchor),
            
            self.registerUserButton.topAnchor.constraint(equalTo: self.passwordTextField.bottomAnchor, constant: CGFloat(10)),
            self.registerUserButton.leadingAnchor.constraint(equalTo: self.nameTextField.leadingAnchor),
            self.registerUserButton.trailingAnchor.constraint(equalTo: self.nameTextField.trailingAnchor),
            self.registerUserButton.heightAnchor.constraint(equalTo: self.nameTextField.heightAnchor)
        ])
    }
    
    func validadeTextFields() -> Bool{
        if self.emailTextField.text != "" && self.nameTextField.text != "" && self.passwordTextField.text != ""{
            return true
        }else{
            return false
        }
    }
}


extension RegisterScreen:UITextFieldDelegate{
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if self.validadeTextFields(){
            self.registerUserButton.setTitleColor(.white, for: .normal)
            self.registerUserButton.isEnabled = true
        }else{
            self.registerUserButton.setTitleColor(.lightGray, for: .normal)
            self.registerUserButton.isEnabled = false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    
}
