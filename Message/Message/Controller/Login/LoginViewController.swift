//
//  LoginViewController.swift
//  Message
//
//  Created by Caio on 21/02/21.
//

import UIKit
import Firebase


class LoginViewController: UIViewController {

    var loginScreen:LoginScreen?
    
    override func loadView() {
        self.loginScreen = LoginScreen()
        self.view = loginScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configLoginScreen()
        let autenticacao = Auth.auth()
          autenticacao.addStateDidChangeListener { (autenticacao, usuario) in
            if usuario != nil{
            let VC = MessageListViewController()
            let navVC = UINavigationController(rootViewController: VC)
            navVC.modalPresentationStyle = .fullScreen
            self.present(navVC, animated: true, completion: nil)
              }
          }
    }
    
    
    func configLoginScreen(){
        self.loginScreen?.delegate(delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
}

extension LoginViewController:ActionButtonsLoginScreenProtocol{
    func actionLogin() {
        print(#function)
        let autenticacao = Auth.auth()
        let email:String = self.loginScreen?.emailTextField.text ?? ""
        let password:String = self.loginScreen?.passwordTextField.text ?? ""
        
        autenticacao.signIn(withEmail: email, password: password) { (usuario, erro) in
            
            if erro == nil{
               print("Success Login!!!!!!")
            }else{
                Alert.init(controller: self).getAlerta(titulo: "Erro de Autenticação", mensagem: "Verifique email e senha e, tente novamente", completion: nil)
            }
        }
        
    }
    
    func actionRegister() {
        self.navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
    
}
