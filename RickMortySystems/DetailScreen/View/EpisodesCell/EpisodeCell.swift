//
//  EpisodeCell.swift
//  RickMortySystems
//
//  Created by Артём Тюрморезов on 18.08.2023.
//

import SwiftUI

struct EpisodeCell: View {
    
    let episodeName: String
    let episodeDetails: String
    let episodeDate: String
    var body: some View {
        VStack {
            HStack {
                Text(episodeName)
                    .font(.system(size: 17))
                    .foregroundColor(Color.white)
                    .padding([.bottom, .top], 5)
                Spacer()
            }
            
            HStack {
                Text(episodeDetails)
                    .font(.system(size: 13))
                    .foregroundColor(Color.green)
                    .padding([.bottom, .top], 5)
                Spacer()
                Text(episodeDate)
                    .font(.system(size: 13))
                    .foregroundColor(Color.init(uiColor: .grayText))
                    .padding([.bottom, .top], 5)
            }
        }
        .padding([.leading, .trailing])
        .background(Color.init(uiColor: .cellColor))
        .cornerRadius(10)
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
}

struct EpisodeCell_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeCell(episodeName: "Pilot", episodeDetails: "Episode: 1, Season: 1", episodeDate: "December 2, 2013")
    }
}
