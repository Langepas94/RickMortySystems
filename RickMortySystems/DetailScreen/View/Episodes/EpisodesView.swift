//
//  EpisodesView.swift
//  RickMortySystems
//
//  Created by Артём Тюрморезов on 18.08.2023.
//

import SwiftUI

struct EpisodesView: View {
    
   @StateObject var viewModel: DetailViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Episodes")
                .font(.system(size: 17, weight: .bold))
                .foregroundColor(Color.white)
            LazyVStack(spacing: 20) {
                ForEach(viewModel.episodes, id: \.episode) { episode in
                    EpisodeCell(episodeName: episode.name, episodeDetails: "Episode: \(viewModel.episodeNumber(from: episode.episode)), Season: \(viewModel.seasonNumber(from: episode.episode))", episodeDate: episode.airDate, isLoading: viewModel.isLoaded)
                }
            }
        }
    }
}
