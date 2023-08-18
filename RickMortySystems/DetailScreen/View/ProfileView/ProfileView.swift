//
//  ProfileView.swift
//  RickMortySystems
//
//  Created by Артём Тюрморезов on 18.08.2023.
//

import SwiftUI
import Kingfisher

struct ProfileView: View {
    
    let imageName: String
    let name: String
    let status: String
    var isLoading = false
    
    var body: some View {
        ZStack {
            VStack {
                KFImage(URL(string: imageName))
                    .resizable()
                    .cornerRadius(10)
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .frame(height: UIScreen.main.bounds.width / 2)
                    .padding(EdgeInsets(top: 10, leading: 50, bottom: 10, trailing: 50))
                
                Text(name)
                    .font(.system(size: 22))
                    .foregroundColor(Color.white)
                Text(status)
                    .font(.system(size: 16))
                    .foregroundColor(Color.green)
            }
            if !isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .edgesIgnoringSafeArea(.all)
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(imageName: "https://rickandmortyapi.com/api/character/avatar/2.jpeg", name: "Beth Smith", status: "Alive")
    }
}
