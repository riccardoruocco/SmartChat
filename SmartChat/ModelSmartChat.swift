//
//  ModelSmartChat.swift
//  SmartChat
//
//  Created by riccardo ruocco on 30/03/22.
//

import Foundation
struct Message:Identifiable{
    var id:UUID
    var data:String
    var author:Author
    var link:Bool = false
}
enum Author{
    case user
    case bot
}
