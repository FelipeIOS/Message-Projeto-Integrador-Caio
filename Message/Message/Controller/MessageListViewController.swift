//
//  ViewController.swift
//  Message
//
//  Created by Caio on 15/02/21.
//

import UIKit

class MessageListViewController: UIViewController {
    
    let messageData:[MessageList] = [
        MessageList(userName: "Caio", lastMessage: "Teste Mensagem", userImage: "prof-img1", date: "10/08/2020", pending: true, pendingCount: "4", userState: true),
        MessageList(userName: "Vitor", lastMessage: "Teste Mensagem", userImage: "prof-img2", date: "13/08/2020", pending: false, pendingCount: "0", userState: false),
        MessageList(userName: "Alencar", lastMessage: "Teste Mensagem.", userImage: "prof-img3", date: "11/08/2020", pending: true, pendingCount: "7", userState: true),
        MessageList(userName: "Barbara", lastMessage: "Teste Mensagem", userImage: "prof-img4", date: "15/08/2020", pending: false, pendingCount: "0", userState: false),
        MessageList(userName: "Gabi", lastMessage: "Teste Mensagem", userImage: "prof-img5", date: "10/08/2020", pending: false, pendingCount: "0", userState: true),
        MessageList(userName: "Daniel", lastMessage: "Teste Mensagem", userImage: "prof-img6", date: "19/08/2020", pending: false, pendingCount: "0", userState: false),
        MessageList(userName: "Pedro", lastMessage: "Teste Mensagem", userImage: "prof-img7", date: "20/08/2020", pending: false, pendingCount: "0", userState: true)
    ]
    
    
    
    var homeScreen:HomeMessageScreen?
    override func loadView() {
        self.homeScreen = HomeMessageScreen()
        self.view = homeScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = CustomColor.appLight
        self.configTableView()
    }
    
    private func configTableView(){
        self.homeScreen?.delegateCollectionView(controller: self)
    }
}

extension MessageListViewController:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messageData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MessageListCollectionViewCell.identifier, for: indexPath) as? MessageListCollectionViewCell
        cell?.data = messageData[indexPath.row]
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
            let cell = collectionView.cellForItem(at: indexPath) as? MessageListCollectionViewCell
            cell?.contentView.backgroundColor = UIColor(white: 0, alpha: 0.1)
        }, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
            let cell = collectionView.cellForItem(at: indexPath) as? MessageListCollectionViewCell
            cell?.contentView.backgroundColor = .clear
        }, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let VC = ChatViewController()
        navigationController?.pushViewController(VC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
