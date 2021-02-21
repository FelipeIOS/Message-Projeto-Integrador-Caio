//  Message
//
//  Created by Caio on 15/02/21.
//

import Foundation

struct MessageList{
    let userName:String?
    let lastMessage:String?
    let userImage:String?
    let date:String?
    let pending:Bool?
    let pendingCount:String?
    let userState:Bool?
}

struct Messages{
    var messageType:String?
    var sentBy:String?
    var time:String?
    var image:String?
    var message:String?
    var isIncoming:Bool?
}
