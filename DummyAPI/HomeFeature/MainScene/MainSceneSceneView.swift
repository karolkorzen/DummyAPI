//
//  MainSceneSceneView.swift
//  DummyAPI
//
//  Created by Karol Korzeń on 12/02/2023.
//

import Foundation
import SwiftUI

struct MainSceneSceneView<Interactor: MainSceneInteractor>: SceneView {
    @StateObject var interactor: Interactor
    
    private let gridLayout = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            searchTextField
            
            switch (interactor.isLoading, interactor.isEmpty) {
            case (true, _):
                loadingView
            case (false, false):
                itemsView
            case (false, true):
                emptyView
            }
        }
        .padding(.horizontal)
        .background(
            Color.appBackground.ignoresSafeArea()
        )
        .navigationTitle(L10n.dummyAPI)
    }
    
    private var loadingView: some View {
        VStack {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .appTint))
                .scaleEffect(2)
        }
        .frame(maxHeight: .infinity)
    }
    
    private var itemsView: some View {
        ScrollView(showsIndicators: true) {
            LazyVGrid(columns: gridLayout, spacing: 16) {
                ForEach(values: interactor.productViewModels) { productViewModel in
                    
                    productPreviewView(productViewModel)
                }
            }
            .padding(.vertical)
        }
    }
    
    private var emptyView: some View {
        VStack {
            Text(L10n.noneProductsHaveBeenFound)
                .foregroundColor(.appPrimaryText)
                .font(.appHeadline)
        }
    }
    
    private var searchTextField: some View {
        TextField(
            L10n.search,
            text: .init(get: { interactor.searchQuery }, set: { interactor.searchQueryChanged($0) })
        )
        .font(.appBody)
        .foregroundColor(.appPrimaryText)
        .textFieldStyle(.roundedBorder)
    }
    
    @ViewBuilder
    private func productPreviewView(_ viewModel: ProductItemViewModel) -> some View {
        VStack(alignment: .center) {
            Text(viewModel.title)
                .multilineTextAlignment(.leading)
                .font(.appSubheadlineSemibold)
                .foregroundColor(.appPrimaryText)
            
            Spacer()
            
            AsyncImage(
                url: viewModel.thumbnail,
                content: { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                        .frame(height: 150)
                        .cornerRadius(10)
                },
                placeholder: {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .black))
                        .scaleEffect(1)
                        .frame(maxWidth: .infinity)
                        .frame(height: 150)
                        .background(Color.white)
                        .cornerRadius(10)
                }
            )
            
            VStack {
                Text(viewModel.brand)
                    .multilineTextAlignment(.leading)
                    .font(.appBody)
                    .foregroundColor(.appPrimaryText)
                    .lineLimit(1)
                
                Text(viewModel.price)
                    .multilineTextAlignment(.trailing)
                    .font(.appBodySemibold)
                    .foregroundColor(.appPrimaryText)
                    .lineLimit(1)
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity)
        .background(Color.appTint)
        .cornerRadius(10)
    }
}
