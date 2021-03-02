//
//  ChatView.swift
//  Message
//
//  Created by Caio on 25/02/21.
//

import UIKit
import AVFoundation


protocol ChatViewProtocol:class{
    func actionPushMessage()
}

class ChatView: UIView {

    weak var delegate:ChatViewProtocol?
    
    public func delegate(delegate:ChatViewProtocol){
        self.delegate = delegate
    }

    var bottomConstraint: NSLayoutConstraint?
    var player: AVAudioPlayer?
    
    lazy var navView:ChatNavigationView = {
        let v = ChatNavigationView()
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
    
    lazy var inputMessageTextField:UITextField = {
        let tf = UITextField()
        tf.delegate = self
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "to write"
        tf.font = UIFont(name: CustomFont.poppinsBold, size: 14)
        tf.textColor = .darkGray
        return tf
    }()
    
    lazy var tableView:UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(IncomingTextMessageTableViewCell.self, forCellReuseIdentifier: IncomingTextMessageTableViewCell.identifier)
        tv.register(OutgoingTextMessageTableViewCell.self, forCellReuseIdentifier: OutgoingTextMessageTableViewCell.identifier)
        tv.backgroundColor = .clear
        tv.transform = CGAffineTransform(scaleX: 1, y: -1)
        tv.separatorStyle = .none
        tv.tableFooterView = UIView()
        return tv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.addSubview(tableView)
        self.addSubview(navView)
        self.addSubview(messageInputView)
        self.messageInputView.addSubview(messageBar)
        self.messageBar.addSubview(sendBtn)
        self.messageBar.addSubview(inputMessageTextField)
        self.setUpConstraints()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification) , name: UIResponder.keyboardWillShowNotification , object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification) , name: UIResponder.keyboardWillHideNotification , object: nil)
        
        //AddeventListner
        self.inputMessageTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
        
        self.bottomConstraint = NSLayoutConstraint(item: messageInputView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        self.addConstraint(bottomConstraint ?? NSLayoutConstraint())
        
        self.sendBtn.isEnabled = false
        self.sendBtn.layer.opacity = 0.4
        self.sendBtn.transform = .init(scaleX: 0.8, y: 0.8)
        self.inputMessageTextField.becomeFirstResponder()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpConstraints(){
        NSLayoutConstraint.activate([
            self.navView.topAnchor.constraint(equalTo: self.topAnchor),
            self.navView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.navView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.navView.heightAnchor.constraint(equalToConstant: 140),
            
            self.tableView.topAnchor.constraint(equalTo: self.navView.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.messageInputView.topAnchor),
            
            self.messageInputView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            self.messageInputView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.messageInputView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.messageInputView.heightAnchor.constraint(equalToConstant: 80),
            
            self.messageBar.leadingAnchor.constraint(equalTo: self.messageInputView.leadingAnchor, constant: 20),
            self.messageBar.trailingAnchor.constraint(equalTo: self.messageInputView.trailingAnchor, constant: -20),
            self.messageBar.heightAnchor.constraint(equalToConstant: 55),
            self.messageBar.centerYAnchor.constraint(equalTo: self.messageInputView.centerYAnchor),
            
            self.sendBtn.trailingAnchor.constraint(equalTo: self.messageBar.trailingAnchor, constant: -15),
            self.sendBtn.widthAnchor.constraint(equalToConstant: 55),
            self.sendBtn.heightAnchor.constraint(equalToConstant: 55),
            self.sendBtn.bottomAnchor.constraint(equalTo: self.messageBar.bottomAnchor, constant: -10),
            
            self.inputMessageTextField.leadingAnchor.constraint(equalTo: self.messageBar.leadingAnchor , constant: 20),
            self.inputMessageTextField.trailingAnchor.constraint(equalTo: self.sendBtn.leadingAnchor, constant: -5),
            self.inputMessageTextField.heightAnchor.constraint(equalToConstant: 45),
            self.inputMessageTextField.centerYAnchor.constraint(equalTo: self.messageBar.centerYAnchor)
        ])
    }
    
  
    @objc func sendBtnPressed(){
        self.sendBtn.touchAnimation(s: sendBtn)
        self.playSound()
        self.delegate?.actionPushMessage()
        self.startPushMessage()
    }
    
    public func startPushMessage(){
              self.inputMessageTextField.text = ""
              self.sendBtn.isEnabled = false
              self.sendBtn.layer.opacity = 0.4
              self.sendBtn.transform = .init(scaleX: 0.8, y: 0.8)
    }
    
    
    func configTableView(delegate:UITableViewDelegate,dataSource:UITableViewDataSource){
        self.tableView.delegate = delegate
        self.tableView.dataSource = dataSource
    }
    
    func reloadTableView(){
        self.tableView.reloadData()
    }
    
    func configNavView(controller:ChatViewController){
        self.navView.controller = controller
    }
    
    func addImageNavView(value:String?){
        self.navView.addImageNavigationView(value: value)
    }
    
    @objc func handleKeyboardNotification(notification: NSNotification){

        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height

            let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification

            self.bottomConstraint?.constant = isKeyboardShowing ? -keyboardHeight : 0

            self.tableView.center.y = isKeyboardShowing ? self.tableView.center.y-keyboardHeight : self.tableView.center.y+keyboardHeight

            UIView.animate(withDuration:0.1, delay: 0 , options: .curveEaseOut , animations: {
                self.layoutIfNeeded()
            } , completion: {(completed) in
                //Config!!!!!
            })
        }
    }
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "send", withExtension: "wav") else { return }
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            self.player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue)
            guard let player = self.player else { return }
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
}

extension ChatView:UITextFieldDelegate{
    
    //MARK:- Animating
    @objc func textFieldDidChange(_ textField: UITextField) {
        if self.inputMessageTextField.text == ""{
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
