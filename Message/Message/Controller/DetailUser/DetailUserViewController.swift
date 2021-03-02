//
//  DetailUserViewController.swift
//  Message
//
//  Created by Caio on 28/02/21.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseUI


class DetailUserViewController: UIViewController {
    
    var detailScreen:DetailUserScreen?
    var autenticacao = Auth.auth()
    var idUsuario:String?
    var imagePicker = UIImagePickerController()
    var idImagem = NSUUID().uuidString
    var firestore:Firestore?
    var alert:Alert?
    
    override func loadView() {
        self.detailScreen = DetailUserScreen()
        self.view = self.detailScreen
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.alert = Alert(controller: self)
        self.detailScreen?.delegate(delegate: self)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.configFireBase()
    }
    
    
    private func configFireBase(){
        self.imagePicker.delegate = self
        firestore = Firestore.firestore()
        
        
        //Recuperar o Id do usuario Logado
        if let id = self.autenticacao.currentUser?.uid{
            self.idUsuario = id
        }
        
        //Recuperar dados usuarios
        self.recuperarDadosUsuario()
    }
    
    func recuperarDadosUsuario(){
        
        let usuariosRef = self.firestore?.collection("usuarios").document(idUsuario ?? "")
        usuariosRef?.getDocument { (snapshot, erro) in
            if let dados = snapshot?.data(){
                let userValue:User = User(dicionario: dados)
                self.detailScreen?.configDetailScreen(user: userValue)
            }
        }
    }
    
    
    
}

extension DetailUserViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let imagemRecuperada = (info[UIImagePickerController.InfoKey.originalImage] as? UIImage)
        self.detailScreen?.addImageUser(image: imagemRecuperada)
        let autenticacao = Auth.auth()
        let armazenamento = Storage.storage().reference()
        let imagens = armazenamento.child("imagens")
        
        if let imagemUpload = imagemRecuperada?.jpegData(compressionQuality: 0.3){
            
            if let usuarioLogadoUID = autenticacao.currentUser?.uid{
                
                let imagemPerfilRef = imagens.child("perfil").child(usuarioLogadoUID + ".jpeg")
                
                imagemPerfilRef.putData(imagemUpload, metadata: nil) { (metaData, erro) in
                    
                    if erro == nil{
                        
                        imagemPerfilRef.downloadURL { (url, erro) in
                            if let urlImagem = url?.absoluteString{
                                
                                self.firestore?.collection("usuarios").document(self.idUsuario ?? "").updateData([
                                    "urlImagem": urlImagem
                                ])
                            }
                        }
                    }else{
                        self.alert?.getAlerta(titulo: "Erro", mensagem: "Erro ao fazer Upload da Imagem, tente novamente", completion: nil)
                    }
                }
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    
}


extension DetailUserViewController: DetailUserScreenProtocol{
    
    
    func actionSairConta() {
        do {
           try autenticacao.signOut()
            let VC = LoginViewController()
            self.navigationController?.pushViewController(VC, animated: true)
           } catch  {
            self.alert?.getAlerta(mensagem: "Erro ao tentar Deslogar, tente novamente!")
           }
    }
    
    func actionEditPhoto() {
        self.imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil )
    }
    
    func actionBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
