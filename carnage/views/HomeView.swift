//
//  homeView.swift
//  carnage
//
//  Created by Diogo Domingos on 18/09/2024.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack(content: {
            Text("Carnage")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).bold()
            
            Divider()
            Text("\(Image(systemName: "info.circle")) workouts will appear here... ").bold()

            Spacer()
        })    }
}

#Preview {
    HomeView()
}
