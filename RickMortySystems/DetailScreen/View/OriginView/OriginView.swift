//
//  OriginView.swift
//  RickMortySystems
//
//  Created by Артём Тюрморезов on 18.08.2023.
//

import SwiftUI

struct OriginView: View {
    let name: String
    let type: String
    var body: some View {
        HStack {
            Image(systemName: "globe.europe.africa")
                .font(.system(size: 30))
                .foregroundColor(Color.white)
                .frame(width: 64, height: 64)
                .background(Color.init(uiColor: .blackBackgroundImage))
                .cornerRadius(10)
                .padding(.all, 5)
                
            
            VStack(alignment: .leading) {
                Text(name)
                    .font(.system(size: 17))
                    .foregroundColor(Color.white)
              
                Text(type)
                    .font(.system(size: 13))
                    .foregroundColor(Color.green)
            }
            Spacer()
        }
        .padding([.leading, .trailing])
        .background(Color.init(uiColor: .cellColor))
        .cornerRadius(10)
    }
}

struct OriginView_Previews: PreviewProvider {
    static var previews: some View {
        OriginView(name: "Earth", type: "Planet")
    }
}
