//
//  ChatViewController.swift
//  Message
//
//  Created by Caio on 20/02/21.
//

import UIKit
import AVFoundation
import Firebase
import FirebaseFirestore

class ChatViewController: UIViewController {
    
    var imagePicker = UIImagePickerController()
    var idImagem = NSUUID().uuidString
    var listaMensagens:[Message] = []
    var idUsuarioLogado: String?
    var contato: Contact?
    var mensagensListener: ListenerRegistration?
    var storage: Storage?
    var auth: Auth?
    var db: Firestore?
    var nomeContato:String?
    var urlFotoContato: String?
    
    var nomeUsuarioLogado:String?
    var urlFotoUsuarioLogado: String?
    
    var chatView:ChatView?
    
    override func loadView() {
        self.chatView = ChatView()
        self.view = chatView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configChatView()
        self.configDataFireBase()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.addListenerRecuperarMensagens()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.mensagensListener?.remove()
    }
    
    private func configDataFireBase(){
        self.storage = Storage.storage()
        self.auth = Auth.auth()
        self.db = Firestore.firestore()
        
        //Recuperar id usuario logado
        if let id = self.auth?.currentUser?.uid {
            self.idUsuarioLogado = id
            self.recuperarDadosUsuarioLogado()
        }
        
        //Configura título da tela
        if let nome = contato?.nome{
            self.nomeContato = nome
        }
        
        if let url = contato?.urlImage {
            self.urlFotoContato = url
        }
    }
    
    
    private func recuperarDadosUsuarioLogado(){
        let usuarios = self.db?.collection("usuarios").document(self.idUsuarioLogado ?? "")
        usuarios?.getDocument { (documentSnapshot, erro) in
            
            if erro == nil{
                let dados:Contact = Contact(dicionario: documentSnapshot?.data() ?? [:])
                self.urlFotoUsuarioLogado = dados.urlImage ?? ""
                self.nomeUsuarioLogado = dados.nome ?? ""
            }
        }
    }
    
    private func configChatView(){
        self.chatView?.configNavView(controller: self)
        self.chatView?.configTableView(delegate: self, dataSource: self)
        self.chatView?.delegate(delegate: self)
    }
    
    @objc func backBtnPressed(){
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func salvarMensagem(idRemetente: String, idDestinatario: String, mensagem: Dictionary<String, Any>) {
        
        db?.collection("mensagens")
            .document( idRemetente )
            .collection( idDestinatario )
            .addDocument(data: mensagem)
        
        //limpar caixa de texto
        chatView?.inputMessageTextField.text = ""
        
    }
    
    func salvarConversa(idRemetente:String, idDestinatario:String, conversa:Dictionary<String,Any>){
        db?.collection("conversas").document(idRemetente).collection("ultimas_conversas").document(idDestinatario).setData(conversa)
        
    }
    
    func addListenerRecuperarMensagens() {
        
        if let idDestinatario = self.contato?.id {
            mensagensListener = db?.collection("mensagens")
                .document( idUsuarioLogado ?? "" )
                .collection( idDestinatario )
                .order(by: "data", descending: true)
                .addSnapshotListener { (querySnapshot, erro) in
                    
                    //limpa lista
                    self.listaMensagens.removeAll()
                    
                    //Recupera dados
                    if let snapshot = querySnapshot {
                        for document in snapshot.documents {
                            let dados = document.data()
                            self.listaMensagens.append(Message(dicionario: dados))
                        }
                        self.chatView?.reloadTableView()
                    }
                }
        }
        
    }
    
    
}

extension ChatViewController:UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listaMensagens.count
      
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let indice = indexPath.row
        let dados = self.listaMensagens[indice]
//        let texto = dados.texto ?? ""
        let idUsuario = dados.idUsuario ?? ""
//        let urlImagem = dados.urlImagem ?? ""
        
        
        if self.idUsuarioLogado != idUsuario {
            //LADO ESQUERDO
            let cell = tableView.dequeueReusableCell(withIdentifier: IncomingTextMessageTableViewCell.identifier, for: indexPath) as? IncomingTextMessageTableViewCell
            cell?.transform = CGAffineTransform(scaleX: 1, y: -1)
            cell?.data = listaMensagens[indexPath.row]
            cell?.selectionStyle = .none
            return cell ?? UITableViewCell()
        }else{
            //LADO DIREITO
            let cell = tableView.dequeueReusableCell(withIdentifier: OutgoingTextMessageTableViewCell.identifier, for: indexPath) as? OutgoingTextMessageTableViewCell
            cell?.transform = CGAffineTransform(scaleX: 1, y: -1)
            cell?.data = listaMensagens[indexPath.row]
            cell?.selectionStyle = .none
            return cell ?? UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let desc:String = self.listaMensagens[indexPath.row].texto ?? ""
        let font = UIFont(name: CustomFont.poppinsSemiBold, size: 14) ?? UIFont()
        let estimatedH = desc.heightWithConstrainedWidth(width: 220, font: font)
        return CGFloat(65 + (estimatedH))
    }
    
    
}


extension ChatViewController:ChatViewProtocol{
    
    func actionPushMessage() {
        
        let message:String = self.chatView?.inputMessageTextField.text ?? ""
        
        if let idUsuarioDestinatario = contato?.id {
            
            let mensagem: Dictionary<String, Any> = [
                "idUsuario" : idUsuarioLogado ?? "",
                "texto" : message,
                "data" : FieldValue.serverTimestamp()
            ]
            
            //mensagem para remetente
            self.salvarMensagem(idRemetente: idUsuarioLogado ?? "", idDestinatario: idUsuarioDestinatario, mensagem: mensagem)
            
            
            //salvar mensagem para destinatario
            self.salvarMensagem(idRemetente: idUsuarioDestinatario, idDestinatario: idUsuarioLogado ?? "", mensagem: mensagem)
            
            var conversa: Dictionary<String,Any> = [
                "ultimaMensagem" : message
            ]
            
            
            //salvar conversa para remetente(dados de quem recebe)
            conversa["idRemetente"] = idUsuarioLogado ?? ""
            conversa["idDestinatario"] = idUsuarioDestinatario
            conversa["nomeUsuario"] = self.nomeContato ?? ""
            conversa["urlFotoUsuario"] = self.urlFotoContato ?? ""
            self.salvarConversa(idRemetente: idUsuarioLogado ?? "", idDestinatario: idUsuarioDestinatario, conversa: conversa)
            
            //salvar conversa para destinatario(dados de quem envia)
            conversa["idRemetente"] = idUsuarioDestinatario
            conversa["idDestinatario"] = idUsuarioLogado ?? ""
            conversa["nomeUsuario"] = self.nomeUsuarioLogado ?? ""
            conversa["urlFotoUsuario"] = self.urlFotoUsuarioLogado
            self.salvarConversa(idRemetente: idUsuarioDestinatario, idDestinatario: idUsuarioLogado ?? "", conversa: conversa)
        }
    }
}


