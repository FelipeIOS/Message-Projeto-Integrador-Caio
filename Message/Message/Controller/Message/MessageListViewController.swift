//
//  ViewController.swift
//  Message
//
//  Created by Caio on 15/02/21.
//

import UIKit
import Firebase
import FirebaseFirestore

class MessageListViewController: UIViewController {
        
    var auth: Auth?
    var db: Firestore?
    var idUsuarioLogado: String?
    var listaContatos: [Dictionary<String, Any>] = []
    var listContact:[Contact] = []
    var homeScreen:HomeMessageScreen?
    var screenContact:Bool?
    var contato:ContatoController?
    var emailUsuarioLogado:String?
    var alert:Alert?
    var listaConversas: [Conversa] = []
    var conversasListener: ListenerRegistration?
    
    
    override func loadView() {
        self.homeScreen = HomeMessageScreen()
        self.view = homeScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = CustomColor.appLight
        self.configHomeView()
        self.configCollectionView()
        self.configAdentifierFirebase()
        self.configContato()
        self.configAlert()
        self.addListenerRecuperarConversa()
    }
    
    private func configHomeView(){
        self.homeScreen?.navView.delegate(delegate: self)
        self.homeScreen?.delegate(delegate: self)
    }
    
    func addListenerRecuperarConversa(){
        
        if let idUsuarioLogado = auth?.currentUser?.uid{
            self.conversasListener = db?.collection("conversas").document(idUsuarioLogado).collection("ultimas_conversas").addSnapshotListener { (querSnapshot, erro) in
              
                if erro == nil{
                     
                    self.listaConversas.removeAll()
                    
                    if let snapshot = querSnapshot{
                        for document in snapshot.documents{
                            let dados = document.data()
                            self.listaConversas.append(Conversa(dicionario: dados))
                        }
                        self.homeScreen?.reloadCollection()
                    }
                }
            }
        }
    }
    
    private func configAlert(){
        self.alert = Alert(controller: self)
    }
    
    private func configContato(){
        self.contato = ContatoController()
        self.contato?.delegate(delegate: self)
    }
    
    private func configAdentifierFirebase(){
        self.auth = Auth.auth()
        self.db = Firestore.firestore()
        
        //Recuperar id usuario logado
        if let currentUser = auth?.currentUser{
            self.idUsuarioLogado = currentUser.uid
            self.emailUsuarioLogado = currentUser.email
        }
    }
    
    private func configCollectionView(){
        self.homeScreen?.delegateCollectionView(delegate: self, dataSource: self)
    }
    
    func getContatos(){
        self.listContact.removeAll()
        self.db?.collection("usuarios")
            .document( idUsuarioLogado ?? "" )
            .collection("contatos")
            .getDocuments { (snapshotResultado, erro) in
                if erro != nil{
                    print("error")
                }
                if let snapshot = snapshotResultado {
                    for document in snapshot.documents {
                        let dadosContato = document.data()
                        self.listContact.append(Contact(dicionario: dadosContato))
                    }
                    self.homeScreen?.reloadCollection()
                }
            }
      }
}

extension MessageListViewController:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if screenContact ?? false{
            return self.listContact.count + 1
        }else{
            return self.listaConversas.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if screenContact ?? false{
            if indexPath.row == self.listContact.count{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MessageLastCollectionViewCell.identifier, for: indexPath) as? MessageLastCollectionViewCell
                return cell ?? UICollectionViewCell()
            }else{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MessageListCollectionViewCell.identifier, for: indexPath) as? MessageListCollectionViewCell
                cell?.setupView(contact: self.listContact[indexPath.row])
                
                return cell ?? UICollectionViewCell()
            }
            
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MessageListCollectionViewCell.identifier, for: indexPath) as? MessageListCollectionViewCell
            cell?.data = self.listaConversas[indexPath.row]
            return cell ?? UICollectionViewCell()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
            let cell = collectionView.cellForItem(at: indexPath) as? MessageListCollectionViewCell
            cell?.contentView.backgroundColor = UIColor(white: 0, alpha: 0.1)
        }, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
            let cell = collectionView.cellForItem(at: indexPath) as? MessageListCollectionViewCell
            cell?.contentView.backgroundColor = .clear
        }, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if screenContact ?? false{
            if indexPath.row == self.listContact.count{
                self.alert?.addContact {value in
                    self.contato?.addContact(email: value, emailUsuarioLogado:self.emailUsuarioLogado ?? "", idUsuario: self.idUsuarioLogado ?? "")
                }
            }else{
                let VC:ChatViewController = ChatViewController()
                VC.contato = self.listContact[indexPath.row]
                self.navigationController?.pushViewController(VC, animated: true)
            }
        }else{
            let VC:ChatViewController = ChatViewController()
            let dados = self.listaConversas[indexPath.row]
            let contato:Contact = Contact(id: dados.idDestinatario ?? "", nome: dados.nome ?? "", urlImagem: dados.urlFotoUsuario ?? "")
            VC.contato = contato
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

extension MessageListViewController:MessageListNavigationViewProtocol{
    
    func typeScreenMessage(type: TypeConversationOrContact) {
        switch type {
        case .contact:
            
            self.screenContact = true
            self.getContatos()
            self.conversasListener?.remove()
            
        case .conversation:
            
            self.screenContact = false
            self.addListenerRecuperarConversa()
            self.homeScreen?.reloadCollection()
        }
    }
}

extension MessageListViewController:ContatoProtocol{
    
    func alertStateError(titulo: String, message: String) {
        self.alert?.getAlerta(titulo: titulo, mensagem: message, completion: nil)
    }
    
    func successContato() {
        self.alert?.getAlerta(titulo: "Ebaaaaa", mensagem: "Usuario cadastrado com sucesso :)") {
            self.getContatos()
        }
    }


}

extension MessageListViewController:HomeMessageScreenProtocol{
    
    func actionConfigUser() {
        let VC:DetailUserViewController = DetailUserViewController()
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
}
