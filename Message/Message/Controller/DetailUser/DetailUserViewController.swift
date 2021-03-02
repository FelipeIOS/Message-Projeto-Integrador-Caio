//
//  DetailUserViewController.swift
//  Message
//
//  Created by Caio on 28/02/21.
//

import UIKit

class DetailUserViewController: UIViewController {

    var detailScreen:DetailUserScreen?
    
    override func loadView() {
        self.detailScreen = DetailUserScreen()
        self.view = self.detailScreen
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.detailScreen?.delegate(delegate: self)
        self.navigationController?.setNavigationBarHidden(true, animated: false)

    }
    

  

}


extension DetailUserViewController: DetailUserScreenProtocol{
    
    
    func actionSairConta() {
        print("sair da conta")
    }
    
    func actionEditPhoto(image: UIImage?) {
        print("actionEditPhoto")
    }
    
    func actionBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
