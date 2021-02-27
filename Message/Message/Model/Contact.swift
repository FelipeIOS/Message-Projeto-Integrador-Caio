//
//  Contact.swift
//  Message
//
//  Created by Caio on 24/02/21.
//

// ContactElement.swift

import Foundation

class Contact {
    
    var id: String?
    var nome: String?
    var urlImage: String?
    
    init (dicionario:[String:Any]) {
        self.id = dicionario["id"] as? String
        self.nome = dicionario["nome"] as? String
        self.urlImage = dicionario["urlImagem"] as? String
    }
}
