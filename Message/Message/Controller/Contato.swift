//
//  Contato.swift
//  Message
//
//  Created by Caio on 25/02/21.
//

import Foundation
import UIKit
import FirebaseFirestore

protocol ContatoProtocol:class {
    func alertStateError(titulo:String,message:String)
    func successContato()
}



class Contato{
    
    weak var delegate:ContatoProtocol?
    
    func delegate(delegate:ContatoProtocol){
        self.delegate = delegate
    }
    
    func addContact(email:String,emailUsuarioLogado:String,idUsuario:String){
        
            if email == emailUsuarioLogado{
                self.delegate?.alertStateError(titulo: "Você está adicionando seu proprio email", message: "Adicione um email diferente")
                return
            }
        
        //verificar se existe o usuario no firebase
        let firestore = Firestore.firestore()
        firestore.collection("usuarios").whereField("email", isEqualTo: email).getDocuments { (snapshotResultado, erro) in
            
            //Conta total de retorno
            if let totalItens = snapshotResultado?.count{
                if totalItens == 0{
                    self.delegate?.alertStateError(titulo: "Usuario não cadastrado", message: "Verifique o e-mail e tente novamente.")
                   return
                }
                
            }
            //Salva contato
            if let snapshot = snapshotResultado{
                for document in snapshot.documents{
                    let dados = document.data()
                    self.salvarContato(dadosContato: dados, idUsuario: idUsuario)
                }
            }
        }
    }
    
    
    func salvarContato(dadosContato: Dictionary<String,Any>, idUsuario:String){
     if let idUsuarioContato = dadosContato["id"] {
        let firestore:Firestore = Firestore.firestore()
        firestore.collection("usuarios")
                   .document( idUsuario )
                   .collection("contatos")
                   .document( String(describing: idUsuarioContato) )
                       .setData(dadosContato) { (erro) in
                           if erro == nil {
                           self.delegate?.successContato()
                }
            }
        }
    }
    
    
}
