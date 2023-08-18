//
//  InfoView.swift
//  RickMortySystems
//
//  Created by Артём Тюрморезов on 18.08.2023.
//

import SwiftUI

struct InfoView: View {
    
    let species: String
    let type: String
    let gender: String
    var body: some View {
        VStack {
            HStack {
                Text("Species")
                    .font(.system(size: 16))
                    .foregroundColor(Color.init(uiColor: .grayText))
                    .padding(.top, 15)
                Spacer()
                Text(species)
                    .foregroundColor(Color.white)
                    .padding(.top, 15)
            }
            HStack {
                Text("Type")
                    .font(.system(size: 16))
                    .foregroundColor(Color.init(uiColor: .grayText))
                    .padding([.bottom, .top], 5)
                Spacer()
                Text(type)
                    .foregroundColor(Color.white)
                    .padding([.bottom, .top], 5)
            }
            HStack {
                Text("Gender")
                    .font(.system(size: 16))
                    .foregroundColor(Color.init(uiColor: .grayText))
                    .padding(.bottom, 15)
                Spacer()
                Text(gender)
                    .foregroundColor(Color.white)
                    .padding(.bottom, 15)
            }
        }
        .padding([.leading, .trailing])
        .background(Color.init(uiColor: .cellColor))
        .cornerRadius(10)
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView(species: "Human", type: "None", gender: "Male")
    }
}
