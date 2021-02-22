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
    
}

