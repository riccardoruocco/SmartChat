//
//  StoreSmartChat.swift
//  SmartChat
//
//  Created by riccardo ruocco on 30/03/22.
//

import Foundation

class StoreSmartChat:ObservableObject{
    @Published private var messages:Array<Message> = []
    var linkAppleProduct = "https://www.apple.com/it/?afid=p238%7CsqcuiGJjQ-dc_mtid_187079nc38483_pcrid_586594519181_pgrid_13999328567_&cid=aos-it-kwgo-brand--slid--bran-product-"
    
    var linkAppleTecSupport = "https://support.apple.com/it-it"
    
    var linkAppleShipSupport = "https://www.apple.com/it/shop/help/shipping_delivery"
    var advisor = Advisor()
    init(){
        
    }
    
    func getMessages()->Array<Message>{
        return self.messages
    }
    func addMessageFromUser(message:String){
        let newMessage = Message(id: UUID(), data: message, author: .user)
        self.messages.append(newMessage)
    }
    
    func addMessageFromBot(message:String){
        var label = advisor.getClassification(data: message)
        var linkToReturn = ""
        var messageToIntroduct = ""
        switch(label){
        case "ProductInfo":
            linkToReturn = linkAppleProduct
            messageToIntroduct = "Hi, for any information on our products we recommend you visit the official store page"
        case "TecHelp":
            linkToReturn = linkAppleTecSupport
            messageToIntroduct = "Hi, we are sorry that you encountered technical problems. Please visit the support page on our website and our technicians will help you immediately."
        default: linkToReturn = linkAppleShipSupport
            messageToIntroduct = "We regret any inconvenience with delivery. On the dedicated page of our website you will find a tool for tracking your package."
        }
        
        let firstMessage = Message(id: UUID(), data: messageToIntroduct, author: .bot)
        self.messages.append(firstMessage)
        let secondMessage = Message(id: UUID(), data: linkToReturn, author: .bot, link: true)
        self.messages.append(secondMessage)
        
    }
    
}
