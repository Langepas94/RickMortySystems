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
        Text(viewModel.model.name)
            .font(.largeTitle)
            .padding()
    }
    

}
