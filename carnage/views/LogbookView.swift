//
//  logbookView.swift
//  carnage
//
//  Created by Diogo Domingos on 15/09/2024.
//

import SwiftUI

struct LogbookView: View {
    var body: some View {
        VStack {
            Text("Logbook").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).bold()
            
            Text("\(Image(systemName: "info.circle")) logbook will appear here... ").bold()
            
            Spacer()
            Button {
                print("New workout button has been pressed....")
            } label: {
                Text("+ New Workout").bold().tint(.white)
            }.padding(.all, 8).background(in: Capsule()).backgroundStyle(.carnageRed)
            
        }.padding(.all, 16)
        
        
        
    }
}

#Preview {
    LogbookView()
}
