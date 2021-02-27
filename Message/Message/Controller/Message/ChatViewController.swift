//
//  ChatViewController.swift
//  Message
//
//  Created by Caio on 20/02/21.
//

import UIKit
import AVFoundation

class ChatViewController: UIViewController {
   
//    var messageData:[Messages] = [
//        Messages(messageType: "text", sentBy: "Jack Dorsey", time: "10/08/2020", image: nil , message: "This is an idea of writing data" , isIncoming: true),
//        Messages(messageType: "text", sentBy: "", time: "10/08/2020", image: nil , message: "This is an idea of writing data" , isIncoming: false),
//        Messages(messageType: "text", sentBy: "Jack Dorsey", time: "10/08/2020", image: nil , message: "Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum" , isIncoming: true),
//        Messages(messageType: "text", sentBy: "Jack Dorsey", time: "10/08/2020", image: nil , message: "Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum" , isIncoming: true),
//        Messages(messageType: "text", sentBy: "Jack Dorsey", time: "10/08/2020", image: nil , message: "Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum" , isIncoming: true),
//        Messages(messageType: "text", sentBy: "Jack Dorsey", time: "10/08/2020", image: nil , message: "Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum" , isIncoming: true),
//    ]
    
    var chatView:ChatView?
       
    override func loadView() {
        self.chatView = ChatView()
        self.view = chatView
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @objc func backBtnPressed(){
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
}

