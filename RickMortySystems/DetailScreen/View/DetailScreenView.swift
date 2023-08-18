//
//  DetailScreenView.swift
//  RickMortySystems
//
//  Created by Артём Тюрморезов on 17.08.2023.
//

import Foundation
import SwiftUI


class SwiftUIViewController: UIHostingController<DetailScreenView> {
    
    init(viewModel: DetailViewModel) {
        let rootView = DetailScreenView(viewModel: viewModel)
        super.init(rootView: rootView)
    }
    
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

struct DetailScreenView: View {
    
    @ObservedObject var viewModel: DetailViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                
                ProfileView(imageName: viewModel.model.image, name: viewModel.model.name, status: viewModel.model.status)
                    .padding(.all)
                
                
                InfoView(species: viewModel.model.species, type: viewModel.model.type, gender: viewModel.model.gender)
                    .padding(.all)
                
                // ORIGIN
                OriginView(name: viewModel.origin.name, type: viewModel.origin.type)
                    .padding(.all)
                
                // EPISODES
                
                LazyVStack(spacing: 20) {
                    ForEach(viewModel.episodes, id: \.episode) { episode in
                        
                        EpisodeCell(episodeName: episode.name, episodeDetails: "Episode: \(viewModel.episodeNumber(from: episode.episode)), Season: \(viewModel.seasonNumber(from: episode.episode))", episodeDate: episode.airDate)
                    }
                }
                .padding(.all)
                
                
            }.onAppear {
                viewModel.confogureData()
            }
        }
        .background(Color.init(uiColor: .bgColor))
    }
}
