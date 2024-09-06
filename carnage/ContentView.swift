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
        
        let button = carnageButton(image: "gym.bag.fill", action: {
            withAnimation(.easeInOut(duration: 0.4)) {
                showMenu = !showMenu
            }
        })
        
        if showMenu {
            ZStack {
                // Text("\(Image(systemName: "info.circle")) menu options will appear here... ").bold()
                HStack {
                    carnageButton(image: "book.closed.fill", action: {
                        withAnimation(.easeInOut(duration: 0.4)) {
                            print("this will be tested.")
                        }
                    })
                    
                    carnageButton(image: "gym.bag.fill", action: {
                        withAnimation(.easeInOut(duration: 0.4)) {
                            showMenu = !showMenu
                        }
                    })
                    
                    carnageButton(image: "person.fill", action: {
                        withAnimation(.easeInOut(duration: 0.4)) {
                            showMenu = !showMenu
                        }
                    })

                }.padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5))
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
