//
//  carnageNavLink.swift
//  carnage
//
//  Created by Diogo Domingos on 15/09/2024.
//

import SwiftUI

struct carnageNavLink<T : View>: View {
    let image: String
    let dest: T
    
    var body: some View {
        NavigationLink(destination: dest, label: {
            Image(systemName: image)
                .font(.system(size: 26))
                .foregroundStyle(.white)
                .padding(EdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 15))
        }).background(Color(red: 1, green: 90/255, blue: 90/255))
            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
    }
}


