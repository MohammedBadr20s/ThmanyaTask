//
//  AlbumDetailsView.swift
//  ThmanyaTask
//
//  Created by Mohammedbadr on 3/13/24.
//

import SwiftUI
import Kingfisher

struct AlbumDetailsView: View {
    @ObservedObject var viewModel: AlbumDetailsViewModel
    
    var body: some View {
        GeometryReader { reader in
            VStack(alignment: .leading, spacing: 10, content: {
                Text(viewModel.album.title ?? "")
                    .font(FontFactory.swiftUIFont(.sansArabic, .bold, 32))
                SearchBar()
                PhotosGridView(viewModel: viewModel, size: reader.size)
                
            })
            
        }
        .padding(.horizontal, 5)
        .clipped()
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .navigationBarBackButtonHidden()
        .task(priority: .utility) {
            await viewModel.getPhotos()
        }
    }
    
    private func SearchBar() -> some View {
        return HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            TextField("Search in images", text: $viewModel.searchQuery)
                .font(Font(FontFactory.getFont(.sansArabic, .regular, 16)))
                .foregroundColor(.black)
            Button {
                self.viewModel.searchQuery = ""
            } label: {
                Image("closeWhite")
                    .resizable()
                    .padding(.all, 5)
                    .frame(width: 20, height: 20, alignment: .center)
                    .foregroundColor(.white)
                    .background(Color(.darkGray))
                    .cornerRadius(15)
                    .opacity(viewModel.searchQuery.isEmpty ? 0 : 1)
            }
        }
        .padding(7)
        .background(Color(.lightGray.withAlphaComponent(0.25)))
        .cornerRadius(10)
        .frame(height: 40)
        .padding(.horizontal, 5)
    }
}

#Preview {
    AlbumDetailsView(viewModel: AlbumDetailsViewModel(album: AlbumsResponse(), navigationDelegate: nil, backDelegate: nil))
}

struct PhotosGridView: View {
    @ObservedObject var viewModel: AlbumDetailsViewModel
    var size: CGSize
    
    
    var body: some View {
        BackwardCompatibleScrollView {
            debugPrint("Action On Scroll")
        } content: {
            LazyVGrid(columns: Array(repeating: GridItem(.fixed(size.width / 3), spacing: 0), count: 3), spacing: 0) {
                ForEach(viewModel.searchQuery.isEmpty ? viewModel.photos : viewModel.filteredPhotos, id: \.self) { item in
                    VStack(alignment: .center, spacing: 0, content: {
                        if let url = URL(string: item.thumbnailURL ?? ""){
                            KFImage(url)
                        } else {
                            Text("Thumbnail URL Invalid: \(item.thumbnailURL ?? "")")
                        }
                        Divider()
                    })
                }
            }
            .clipShape(
                RoundedRectangle(cornerRadius: 5)
            )
            
            
        }
    }
}
