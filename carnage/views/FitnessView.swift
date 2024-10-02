//  workoutsView.swift
//  carnage
//
//  Created by Diogo Domingos on 15/09/2024.
//

import SwiftUI

/// will contain routines and maybe some other things in the future.
struct FitnessView: View {
    @State var routines: [Routine] = []
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Routines").bold().font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            
            ForEach(routines) { routine in
                RoutineComponent(name: routine.name, description: routine.description, id: 0)
            }
            
            Spacer()
            
        }.padding(.all, 16).onAppear() {
            Task {
                let routines = try! await API.getRoutines()
                
                DispatchQueue.main.async {
                    self.routines = routines
                }
            }
        }
    }
}

#Preview {
    FitnessView()
}
