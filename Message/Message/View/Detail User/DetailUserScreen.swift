//
//  DetailUserScreen.swift
//  Message
//
//  Created by Caio on 28/02/21.
//

import UIKit

protocol DetailUserScreenProtocol:class {
    func actionEditPhoto()
    func actionBackButton()
    func actionSairConta()
}

class DetailUserScreen: UIView {
    
    var heightWidthImageUser:CGFloat = 160
    weak var delegate:DetailUserScreenProtocol?
    
    func delegate(delegate:DetailUserScreenProtocol){
        self.delegate = delegate
    }
    
    lazy var imageUser:UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = self.heightWidthImageUser/2
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var nameLabel:UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textColor = .white
        lb.font = UIFont(name: CustomFont.poppinsBold, size: 16)
        return lb
    }()
    
    lazy var emailLabel:UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textColor = .white
        lb.font = UIFont(name: CustomFont.poppinsBold, size: 16)
        return lb
    }()
    
    lazy var addImageUser:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Editar Foto", for: .normal)
        button.titleLabel?.font = UIFont(name: CustomFont.poppinsBold, size: 16)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(self.tappedEditPhoto), for: .touchUpInside)
        return button
    }()
    
    lazy var sairAppButton:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sair do App", for: .normal)
        button.backgroundColor = .red
        button.clipsToBounds = true
        button.layer.cornerRadius = 6
        button.titleLabel?.font = UIFont(name: CustomFont.poppinsBold, size: 16)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(self.tappedSairConta), for: .touchUpInside)
        return button
    }()
    
    lazy var backBtn:UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "back"), for: .normal)
        btn.addTarget(self, action: #selector(self.tappedBackButton), for: .touchUpInside)
        return btn
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 24/255, green: 117/255, blue: 104/255, alpha: 1.0)
        self.addSubview(self.imageUser)
        self.addSubview(self.nameLabel)
        self.addSubview(self.emailLabel)
        self.addSubview(self.addImageUser)
        self.addSubview(self.backBtn)
        self.addSubview(self.sairAppButton)
        self.setUpConstraints()
        
    }
    
    @objc private func tappedEditPhoto(){
        self.delegate?.actionEditPhoto()
    }
    
    @objc private func tappedBackButton(){
        self.delegate?.actionBackButton()
    }
    
    @objc private func tappedSairConta(){
        self.delegate?.actionSairConta()
    }
    
    public func configDetailScreen(user:User){
        self.nameLabel.text = user.nome ?? ""
        self.emailLabel.text = user.email ?? ""
        
        if user.urlFotoUsuario == nil || user.urlFotoUsuario == "" {
            self.imageUser.image = UIImage(named: "imagem-perfil")
        }else{
            self.imageUser.sd_setImage(with: URL(string:user.urlFotoUsuario ?? ""), completed: nil)
        }
    }
    
    
    
    
    public func addImageUser(image:UIImage?){
        self.imageUser.image = image ?? UIImage(named: "imagem-perfil")
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpConstraints(){
        NSLayoutConstraint.activate([
            
            self.backBtn.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: CGFloat(10)),
            self.backBtn.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: CGFloat(20)),
            self.backBtn.heightAnchor.constraint(equalToConstant: 40),
            self.backBtn.widthAnchor.constraint(equalToConstant: 40),
            
            self.imageUser.topAnchor.constraint(equalTo: self.backBtn.bottomAnchor, constant: CGFloat(8)),
            self.imageUser.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: CGFloat(20)),
            self.imageUser.heightAnchor.constraint(equalToConstant: self.heightWidthImageUser),
            self.imageUser.widthAnchor.constraint(equalToConstant: self.heightWidthImageUser),
            
            self.nameLabel.topAnchor.constraint(equalTo: self.imageUser.topAnchor, constant: CGFloat(25)),
            self.nameLabel.leadingAnchor.constraint(equalTo: self.imageUser.trailingAnchor,constant: CGFloat(10)),
            self.nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: CGFloat(-20)),
            self.nameLabel.heightAnchor.constraint(equalToConstant: CGFloat(20)),
            
            self.emailLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: CGFloat(5)),
            self.emailLabel.leadingAnchor.constraint(equalTo: self.nameLabel.leadingAnchor),
            self.emailLabel.trailingAnchor.constraint(equalTo: self.nameLabel.trailingAnchor),
            self.emailLabel.heightAnchor.constraint(equalTo: self.nameLabel.heightAnchor),
            
            self.addImageUser.topAnchor.constraint(equalTo: self.imageUser.bottomAnchor, constant: CGFloat(10)),
            self.addImageUser.centerXAnchor.constraint(equalTo: self.imageUser.centerXAnchor),
            
            self.sairAppButton.topAnchor.constraint(equalTo: self.emailLabel.bottomAnchor, constant: CGFloat(210)),
            self.sairAppButton.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
}


