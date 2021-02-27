//
//  RegisterViewController.swift
//  Message
//
//  Created by Caio on 21/02/21.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class RegisterViewController: UIViewController {

    var registerScreen:RegisterScreen?
    var imagePicker:UIImagePickerController = UIImagePickerController()
    var firestore:Firestore?
    var alert:Alert?
    
    override func loadView() {
        self.registerScreen = RegisterScreen()
        self.view = registerScreen
    }
    
    private func configAlert(){
        self.alert = Alert(controller: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.firestore = Firestore.firestore()
        self.configRegisterScreen()
        self.configImagePicker()
    }
    
    func configImagePicker(){
        self.imagePicker.delegate = self
    }
    
    func configRegisterScreen(){
        self.registerScreen?.delegate(delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
}

extension RegisterViewController:ActionButtonsRegisterScreenProtocol{
    
    func actionPopRegister() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func actionAlterarImagem() {
        self.imagePicker.sourceType = .photoLibrary
        self.present(self.imagePicker, animated: true, completion: nil)
    }
    
    func actionRegisterUser() {
        print(#function)
        let email:String = self.registerScreen?.emailTextField.text ?? ""
        let password:String = self.registerScreen?.passwordTextField.text ?? ""
        let nome:String = self.registerScreen?.nameTextField.text ?? ""
        
        let autenticacao = Auth.auth()
        autenticacao.createUser(withEmail: email, password: password) { (dadosResultado, erro) in
            
            if erro == nil{
                print("Success==============")
            //Salvar dados no firebase
                if let idUsuario = dadosResultado?.user.uid{
                    self.firestore?.collection("usuarios").document(idUsuario).setData([
                        "nome": nome,
                        "email": email,
                        "id": idUsuario
                    ])
                }
            }else{
                let erroR = erro as NSError?
                let erroTexto:Int = erroR?.code ?? 0
    
                    var mensagemErro = ""
                    
                    switch erroTexto {
                        
                    case 17008 :
                        
                        mensagemErro = "E-mail invalido, Digite um E-mail válido!!"
                        
                        break
                        
                    case 17026 :
                        
                        mensagemErro = "Senha precisa ter no mínimo 6 caracteres, com letras e numeros!!"
                        
                        break
                        
                    case 17007 :
                        
                        mensagemErro = "Esse e-mail já está sendo usado por outra pessoa, digite outro e-mail!!"
                        
                        break
                        
                    default:
                        
                        mensagemErro = "Dados digitados estão invalidos"
                    }
                        
                     print(mensagemErro)
                self.alert?.getAlerta(mensagem: mensagemErro)
                }
        }
        
    }
    
}

extension RegisterViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let imagemRecuparada = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        self.registerScreen?.setImageUser(image: imagemRecuparada ?? UIImage())
        picker.dismiss(animated: true, completion: nil)
    }
    
}

