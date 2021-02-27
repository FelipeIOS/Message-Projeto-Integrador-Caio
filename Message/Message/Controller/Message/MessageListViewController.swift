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
    
    let messageData:[MessageList] = [
        MessageList(userName: "Caio", lastMessage: "Teste Mensagem", userImage: "prof-img1", date: "10/08/2020", pending: true, pendingCount: "4", userState: true),
        MessageList(userName: "Vitor", lastMessage: "Teste Mensagem", userImage: "prof-img2", date: "13/08/2020", pending: false, pendingCount: "0", userState: false),
        MessageList(userName: "Alencar", lastMessage: "Teste Mensagem.", userImage: "prof-img3", date: "11/08/2020", pending: true, pendingCount: "7", userState: true),
        MessageList(userName: "Barbara", lastMessage: "Teste Mensagem", userImage: "prof-img4", date: "15/08/2020", pending: false, pendingCount: "0", userState: false),
        MessageList(userName: "Gabi", lastMessage: "Teste Mensagem", userImage: "prof-img5", date: "10/08/2020", pending: false, pendingCount: "0", userState: true),
        MessageList(userName: "Daniel", lastMessage: "Teste Mensagem", userImage: "prof-img6", date: "19/08/2020", pending: false, pendingCount: "0", userState: false),
        MessageList(userName: "Pedro", lastMessage: "Teste Mensagem", userImage: "prof-img7", date: "20/08/2020", pending: false, pendingCount: "0", userState: true)
    ]
    
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
    
    override func loadView() {
        self.homeScreen = HomeMessageScreen()
        self.view = homeScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = CustomColor.appLight
        self.homeScreen?.navView.delegate(delegate: self)
        self.configCollectionView()
        self.configAdentifierFirebase()
        self.configContato()
        self.configAlert()
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
            return self.messageData.count
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
            cell?.data = self.messageData[indexPath.row]
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
//            let VC:ChatViewController = ChatViewController()
//
//            self.navigationController?.pushViewController(VC, animated: true)
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
        case .conversation:
            self.screenContact = false
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
