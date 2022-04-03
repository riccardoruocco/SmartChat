//
//  ContentView.swift
//  SmartChat
//
//  Created by riccardo ruocco on 30/03/22.
//

import SwiftUI

struct ContentView: View {
    @State var message:String = ""
    @State var messageForBot = ""
    @State var isTextFieldActive = true
    @EnvironmentObject var storeSmartChat:StoreSmartChat
    
    var messageList:Array<Message>{
        storeSmartChat.getMessages()
    }
    var body: some View {
        VStack{
            ScrollView(.vertical){
                LazyVGrid(columns:[GridItem()]){
                    ForEach(messageList){ aMessage in
                        MessageView(message: aMessage)
                    }
                }
            }
            Spacer()
            HStack(){
                TextField("write here your message",
                          text: $message)
                    .padding()
                    .textFieldStyle(.roundedBorder)
                    .disabled(isTextFieldActive == false)
                
                Button(action: {
                    storeSmartChat.addMessageFromUser(message: message)
                    messageForBot = message
                    self.message = ""
                    self.isTextFieldActive = false
                    let time = DispatchTime.now() + DispatchTimeInterval.seconds(1)
                    
                    DispatchQueue.main.asyncAfter(deadline: time) {
                        storeSmartChat.addMessageFromBot(message:messageForBot)
                        self.isTextFieldActive = true
                    }
                    
                    
                }, label: {
                    Image(systemName: "paperplane.fill")
                        .padding()
                        .clipShape(Circle())
                        .overlay(Circle().stroke())
                    
                        
                })
                .padding()
                
            }
            .border(.gray, width: 1)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let storeSmartChat = StoreSmartChat()
        ContentView()
            .environmentObject(storeSmartChat)
    }
}

struct MessageView: View{
    var message:Message
        
    var body: some View{
        if(message.author == .bot){
            if(message.link == false){
                HStack(){
                    Text(message.data)
                        .padding()
                        .background{
                            RoundedRectangle(cornerRadius: 15, style: .continuous)
                                .foregroundColor(.blue)
                        }
                    Spacer()
                }
                .padding()
            }
            else if(message.link == true){
                HStack(){
                    Link("Click Here", destination: URL(string: message.data)!)
                        .font(.body)
                        .foregroundColor(.black)
                        .padding()
                        .background{
                            RoundedRectangle(cornerRadius: 15, style: .continuous)
                                .foregroundColor(.blue)
                        }
                    Spacer()
                }
                .padding()
            }
            

        }
        else{
            HStack(){
                Spacer()
                Text(message.data)
                    .padding()
                    .background{
                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .foregroundColor(.green)
                    }
            }
            .padding()

        }
    }
}
