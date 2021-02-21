//
//  RegisterViewController.swift
//  Message
//
//  Created by Caio on 21/02/21.
//

import UIKit

class RegisterViewController: UIViewController {

    var registerScreen:RegisterScreen?
    var imagePicker:UIImagePickerController = UIImagePickerController()
    
    override func loadView() {
        self.registerScreen = RegisterScreen()
        self.view = registerScreen
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configRegisterScreen()
        self.configImagePicker()
    }
    
    func configImagePicker(){
        self.imagePicker.delegate = self
    }
    
    func configRegisterScreen(){
        self.registerScreen?.delegate(delegate: self)
        self.registerScreen?.delegateTextFields(delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
}

extension RegisterViewController:ActionButtonsRegisterScreenProtocol{
    
    func actionAlterarImagem() {
        self.imagePicker.sourceType = .photoLibrary
        self.present(self.imagePicker, animated: true, completion: nil)
    }
    
    func actionRegisterUser() {
        print(#function)
    }
    
}

extension RegisterViewController: UITextFieldDelegate{
    
    
}

extension RegisterViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let imagemRecuparada = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        self.registerScreen?.setImageUser(image: imagemRecuparada ?? UIImage())
        picker.dismiss(animated: true, completion: nil)
    }
    
}

