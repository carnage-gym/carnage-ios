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
            
            Divider()
            Text("\(Image(systemName: "info.circle")) workouts will appear here... ").bold()

            Spacer()
            Divider()
        })
        
        let button = carnageButton(image: "gym.bag.fill", action: {
            withAnimation(.easeInOut(duration: 0.3)) {
                showMenu = !showMenu
            }
        })
        
        if showMenu {
            ZStack {
                HStack {
                    carnageButton(image: "book.closed.fill", action: {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            print("this will be tested.")
                        }
                    })
                    
                    carnageButton(image: "gym.bag.fill", action: {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            showMenu = !showMenu
                        }
                    })
                    
                    carnageButton(image: "person.fill", action: {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            showMenu = !showMenu
                        }
                    })

                }.padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5))
                content.opacity(0.4).blur(radius: 4.0)
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
