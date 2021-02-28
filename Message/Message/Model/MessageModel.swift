//  Message
//
//  Created by Caio on 15/02/21.
//

import Foundation

struct MessageList{
    let userName:String?
    let lastMessage:String?
    let userImage:String?
    let date:String?
    let pending:Bool?
    let pendingCount:String?
    let userState:Bool?
}

struct Messages{
    var messageType:String?
    var sentBy:String?
    var time:String?
    var image:String?
    var message:String?
    var isIncoming:Bool?
}

class Message {
    
    var texto: String?
    var idUsuario: String?
    var urlImagem: String?
    
    init (dicionario:[String:Any]) {
        self.texto = dicionario["texto"] as? String
        self.idUsuario = dicionario["idUsuario"] as? String
        self.urlImagem = dicionario["urlImagem"] as? String
    }
}

class Conversa {
    var nome: String?
    var ultimaMensagem: String?
    var urlFotoUsuario: String?
    var idDestinatario: String?
    
    init (dicionario:[String:Any]) {
        self.nome = dicionario["nomeUsuario"] as? String
        self.ultimaMensagem = dicionario["ultimaMensagem"] as? String
        self.urlFotoUsuario = dicionario["urlFotoUsuario"] as? String
        self.idDestinatario = dicionario["idDestinatario"] as? String
    }
}
