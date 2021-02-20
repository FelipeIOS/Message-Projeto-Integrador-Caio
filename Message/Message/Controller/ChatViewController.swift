//
//  ChatViewController.swift
//  Message
//
//  Created by Caio on 20/02/21.
//

import UIKit
import AVFoundation

class ChatViewController: UIViewController {
    
    var player: AVAudioPlayer?
    var messageData:[Messages] = [
        Messages(messageType: "text", sentBy: "Jack Dorsey", time: "10/08/2020", image: nil , message: "This is an idea of writing data" , isIncoming: true),
        Messages(messageType: "text", sentBy: "", time: "10/08/2020", image: nil , message: "This is an idea of writing data" , isIncoming: false),
        Messages(messageType: "text", sentBy: "Jack Dorsey", time: "10/08/2020", image: nil , message: "Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum" , isIncoming: true),
        Messages(messageType: "text", sentBy: "Jack Dorsey", time: "10/08/2020", image: nil , message: "Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum" , isIncoming: true),
        Messages(messageType: "text", sentBy: "Jack Dorsey", time: "10/08/2020", image: nil , message: "Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum" , isIncoming: true),
        Messages(messageType: "text", sentBy: "Jack Dorsey", time: "10/08/2020", image: nil , message: "Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum" , isIncoming: true),
    ]
    
    var bottomConstraint: NSLayoutConstraint?
    
    lazy var navView:ChatNavigationView = {
        let v = ChatNavigationView()
        v.controller = self
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let messageInputView:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .white
        return v
    }()
    
    let messageBar:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = CustomColor.appLight
        v.layer.cornerRadius = 20
        return v
    }()
    
    let sendBtn:UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = CustomColor.appPink
        btn.layer.cornerRadius = 22.5
        btn.layer.shadowColor = CustomColor.appPink.cgColor
        btn.layer.shadowRadius = 10
        btn.layer.shadowOffset = CGSize(width: 0, height: 5)
        btn.layer.shadowOpacity = 0.3
        btn.addTarget(self, action: #selector(sendBtnPressed), for: .touchUpInside)
        btn.setImage(UIImage(named: "send"), for: .normal)
        return btn
    }()
    
    lazy var inputMessageField:UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "to write"
        tf.font = UIFont(name: CustomFont.poppinsBold, size: 14)
        tf.textColor = .darkGray
        tf.delegate = self
        return tf
    }()
    
    lazy var tableView:UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(IncomingTextMessageTableViewCell.self, forCellReuseIdentifier: IncomingTextMessageTableViewCell.identifier)
//        tv.register(OutgoingTextMessageTableViewCell.self, forCellReuseIdentifier: "OutgoingTextMessageTableViewCell")
        tv.delegate = self
        tv.dataSource = self
        tv.backgroundColor = .clear
        tv.transform = CGAffineTransform(scaleX: 1, y: -1)
        tv.separatorStyle = .none
        tv.tableFooterView = UIView()
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(navView)
        view.addSubview(messageInputView)
        messageInputView.addSubview(messageBar)
        messageBar.addSubview(sendBtn)
        messageBar.addSubview(inputMessageField)
        setUpConstraints()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification) , name: UIResponder.keyboardWillShowNotification , object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification) , name: UIResponder.keyboardWillHideNotification , object: nil)
        
        //AddeventListner
        inputMessageField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
        //bottomconstraints
        bottomConstraint = NSLayoutConstraint(item: messageInputView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        view.addConstraint(bottomConstraint!)
        
        self.sendBtn.isEnabled = false
        self.sendBtn.layer.opacity = 0.4
        self.sendBtn.transform = .init(scaleX: 0.8, y: 0.8)
        self.inputMessageField.becomeFirstResponder()
    }
    
    func setUpConstraints(){
        NSLayoutConstraint.activate([
            navView.topAnchor.constraint(equalTo: view.topAnchor),
            navView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navView.heightAnchor.constraint(equalToConstant: 140),
            
            tableView.topAnchor.constraint(equalTo: navView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: messageInputView.topAnchor),
            
            messageInputView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            messageInputView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            messageInputView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            messageInputView.heightAnchor.constraint(equalToConstant: 80),
            
            messageBar.leadingAnchor.constraint(equalTo: messageInputView.leadingAnchor, constant: 20),
            messageBar.trailingAnchor.constraint(equalTo: messageInputView.trailingAnchor, constant: -20),
            messageBar.heightAnchor.constraint(equalToConstant: 55),
            messageBar.centerYAnchor.constraint(equalTo: messageInputView.centerYAnchor),
            
            sendBtn.trailingAnchor.constraint(equalTo: messageBar.trailingAnchor, constant: -15),
            sendBtn.widthAnchor.constraint(equalToConstant: 55),
            sendBtn.heightAnchor.constraint(equalToConstant: 55),
            sendBtn.bottomAnchor.constraint(equalTo: messageBar.bottomAnchor, constant: -10),
            
            inputMessageField.leadingAnchor.constraint(equalTo: messageBar.leadingAnchor , constant: 20),
            inputMessageField.trailingAnchor.constraint(equalTo: sendBtn.leadingAnchor, constant: -5),
            inputMessageField.heightAnchor.constraint(equalToConstant: 45),
            inputMessageField.centerYAnchor.constraint(equalTo: messageBar.centerYAnchor)
        ])
    }
    
    @objc func backBtnPressed(){
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func sendBtnPressed(){
        sendBtn.touchAnimation(s: sendBtn)
        self.playSound()
        let message = Messages(messageType: "text", sentBy: "", time: "20/08/2020", image: nil, message: self.inputMessageField.text, isIncoming: false)
        self.messageData.insert(message, at: 0)
        self.tableView.beginUpdates()
        let index = IndexPath(row: 0, section: 0)
        self.tableView.insertRows(at: [index], with: .right)
        self.tableView.endUpdates()
        self.inputMessageField.text = ""
        self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        self.sendBtn.isEnabled = false
        self.sendBtn.layer.opacity = 0.4
        self.sendBtn.transform = .init(scaleX: 0.8, y: 0.8)
    }
    
}

extension ChatViewController:UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if messageData[indexPath.row].messageType == "text"{
            if messageData[indexPath.row].isIncoming == true {
                let cell = tableView.dequeueReusableCell(withIdentifier: "IncomingTextMessageTableViewCell", for: indexPath) as! IncomingTextMessageTableViewCell
                cell.transform = CGAffineTransform(scaleX: 1, y: -1)
                cell.data = messageData[indexPath.row]
                cell.selectionStyle = .none
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "OutgoingTextMessageTableViewCell", for: indexPath) as! OutgoingTextMessageTableViewCell
                cell.transform = CGAffineTransform(scaleX: 1, y: -1)
                cell.data = messageData[indexPath.row]
                cell.selectionStyle = .none
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if messageData[indexPath.row].messageType == "text"{
            let desc = messageData[indexPath.row].message
            let font = UIFont(name: CustomFont.poppinsSemiBold, size: 14) ?? UIFont()
            let estimatedH = desc?.heightWithConstrainedWidth(width: 220, font: font)
            return CGFloat(65 + estimatedH!)
        }
        return CGFloat()
    }
    
    @objc func handleKeyboardNotification(notification: NSNotification){

        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height

            let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification

            bottomConstraint?.constant = isKeyboardShowing ? -keyboardHeight : 0

            self.tableView.center.y = isKeyboardShowing ? self.tableView.center.y-keyboardHeight : self.tableView.center.y+keyboardHeight

            UIView.animate(withDuration:0.1, delay: 0 , options: .curveEaseOut , animations: {
                self.view.layoutIfNeeded()
            } , completion: {(completed) in

                if isKeyboardShowing{
                }
            })
        }
    }
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "send", withExtension: "wav") else { return }
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue)
            guard let player = player else { return }
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
}

extension ChatViewController:UITextFieldDelegate{
    
    //MARK:- Animating on textview edit
    @objc func textFieldDidChange(_ textField: UITextField) {
        if self.inputMessageField.text == ""{
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.sendBtn.isEnabled = false
                self.sendBtn.layer.opacity = 0.4
                self.sendBtn.transform = .init(scaleX: 0.8, y: 0.8)
            }, completion: { _ in
            })
        }
        else {
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.sendBtn.isEnabled = true
                self.sendBtn.layer.opacity = 1
                self.sendBtn.transform = .identity
            }, completion: { _ in
            })
        }
    }
    
}
