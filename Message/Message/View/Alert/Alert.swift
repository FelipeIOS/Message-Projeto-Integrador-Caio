//
//  Alert.swift
//  Message
//
//  Created by Caio on 21/02/21.
//

import Foundation
import UIKit

class Alert{
    var controller:UIViewController
    
    init(controller:UIViewController) {
        self.controller = controller
    }
    
    func getAlerta(titulo:String = "Atenção",mensagem:String,completion:(() -> Void)? = nil){
            let alerta = UIAlertController(title: titulo, message: mensagem, preferredStyle: .alert)
            let cancelar = UIAlertAction(title: "Ok", style: .cancel) { (acao) in
             completion?()
            }
            alerta.addAction(cancelar)
            self.controller.present(alerta, animated: true, completion: nil)
        }
    
    func addContact(completion:((_ value:String) -> Void)? = nil){
        var _textField:UITextField?
        let alert = UIAlertController(title: "Adicionar Usuario", message: "Digite uma email Valido", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Adicionar", style: .default) { (acao) in
            completion?(_textField?.text ?? "")
        }
        let cancel = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alert.addAction(cancel)
        alert.addAction(ok)
        alert.addTextField(configurationHandler: {(textField: UITextField) in
            _textField = textField
            textField.placeholder = "Email:"
        })
        self.controller.present(alert, animated: true, completion: nil)
    }
    
   
    
}

