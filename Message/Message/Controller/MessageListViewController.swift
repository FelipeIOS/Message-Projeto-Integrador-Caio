//
//  ViewController.swift
//  Message
//
//  Created by Caio on 15/02/21.
//

import UIKit

class MessageListViewController: UIViewController {

    var homeScreen:HomeMessageScreen?
    override func loadView() {
        self.homeScreen = HomeMessageScreen()
        self.view = homeScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = CustomColor.appLight
    }
    
    private func configTableView(){
        self.homeScreen?.tableView.delegate = self
        self.homeScreen?.tableView.dataSource = self
    }
}

extension MessageListViewController:UITableViewDelegate,UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}

