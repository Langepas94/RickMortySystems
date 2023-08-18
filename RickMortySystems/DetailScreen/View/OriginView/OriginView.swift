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
    var isLoading = false
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 8) {
            Text("Origin")
                .font(.system(size: 17, weight: .bold))
                .foregroundColor(Color.white)
            
            ZStack(alignment: .leading) {
                Color.init(uiColor: .cellColor)
                
                HStack(spacing: 8) {
                    ZStack {
                        Rectangle()
                            .foregroundColor(Color.init(uiColor: .blackBackgroundImage))
                            .frame(width: 64, height: 64)
                            .cornerRadius(10)
                        
                        Image(systemName: "globe.europe.africa")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(Color.white)
                            .frame(width: 24, height: 24)
                    }
                    
                    .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 0))
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text(name)
                            .font(.system(size: 17, weight: .bold))
                            .foregroundColor(Color.white)
                            .padding(.top, 16)
                        
                        Text(type)
                            .font(.system(size: 13))
                            .foregroundColor(Color.green)
                            .padding(.bottom, 16)
                    }
                }
                
                if !isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .edgesIgnoringSafeArea(.all)
                }
            }
            .cornerRadius(10)
            
            
        }
    }
}

