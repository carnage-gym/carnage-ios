//
//  ContentView.swift
//  carnage
//
//  Created by Diogo Domingos on 04/09/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    var body: some View {
        VStack(content: {
            Text("Carnage")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).bold()
            Spacer()
                        
            HStack(content: {
                Text("Test")
                Button {
                    print("Pressed!")
                } label: {
                    Image(systemName: "gym.bag.fill")
                        .font(.system(size: 22))
                        .foregroundStyle(.white)
                        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                        .background(Color(red: 1, green: 90/255, blue: 90/255))
                        .clipShape(Capsule())
                }.padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                
                Text("Test")
            })
        })
    }
}

#Preview {
    ContentView()
}
