//
//  carnageButton.swift
//  carnage
//
//  Created by Diogo Domingos on 06/09/2024.
//

import SwiftUI

struct carnageButton: View {
    @State var image: String
    let action: () -> Void
    @State var clicked = false
        
    var body: some View {
        Button {
            clicked = !clicked
            action()
        } label: {
            Image(systemName: image)
                .font(.system(size: 24))
                .foregroundStyle(clicked ? Color(red: 1, green: 90/255, blue: 90/255) : .white)
                .padding(EdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 15))
                .background(clicked ? Color(red: 1, green: 1, blue: 1) : Color(red: 1, green: 90/255, blue: 90/255))
                .clipShape(Circle())
        }.padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5))
    }
}

#Preview {
    carnageButton(image: "gym.bag.fill", action: { print("hello") })
}
