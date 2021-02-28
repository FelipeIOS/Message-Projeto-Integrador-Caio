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


    }
    

  

}
