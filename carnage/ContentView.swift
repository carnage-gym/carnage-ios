//
//  ContentView.swift
//  carnage
//
//  Created by Diogo Domingos on 04/09/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State var showMenu = false
    var body: some View {
        let content = VStack(content: {
            Text("Carnage")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).bold()
            Spacer()
            Divider()
        })
        
        let button = Button {
            showMenu = !showMenu
        } label: {
            Image(systemName: "gym.bag.fill")
                .font(.system(size: 24))
                .foregroundStyle(.white)
                .padding(EdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 15))
                .background(showMenu ? Color(red: 1, green: 80/255, blue: 80/255) : Color(red: 1, green: 90/255, blue: 90/255))
                .clipShape(Circle())
        }
        
        if showMenu {
            ZStack {
                Text("\(Image(systemName: "info.circle")) menu options will appear here... ").bold()
                content.opacity(0.4)
            }
        } else {
            content
        }
        button
        
    }
}

#Preview {
    ContentView()
}
