//
//  routineComponent.swift
//  carnage
//
//  Created by Diogo Domingos on 27/09/2024.
//

import SwiftUI

struct RoutineComponent: View {
    let name: String
    let description: String
    let id: Int // later used to start workouts through a routine blueprint.
    
    var body: some View {
        VStack {
            HStack {
                Text(name).font(.title2).bold()
                Spacer()
                Button {
                } label: {
                    Label("", systemImage: "minus.circle")
                }.tint(.carnageRed)
                
            }
            Spacer()
            Button {
                print("New workout button has been pressed....")
            } label: {
                Text("Start workout").bold().tint(.white)
                    .frame(maxWidth: .infinity)
           
            }.padding(.all, 8).background(in: RoundedRectangle(cornerRadius: 15)).backgroundStyle(.carnageRed)
            
        }.padding(.all, 16)
            .frame(height: 120)
            .background(Color(red: 253/255, green: 253/255, blue: 253/255))
            .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

#Preview {
    RoutineComponent(name: "Upper A", description: "Back, Biceps", id: 1)
}
