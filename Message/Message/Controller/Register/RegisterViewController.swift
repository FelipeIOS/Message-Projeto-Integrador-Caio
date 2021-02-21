//
//  RegisterViewController.swift
//  Message
//
//  Created by Caio on 21/02/21.
//

import UIKit

class RegisterViewController: UIViewController {

    var registerScreen:RegisterScreen?
    
    override func loadView() {
        self.registerScreen = RegisterScreen()
        self.view = registerScreen
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    


}
