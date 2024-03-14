//
//  PhotosView.swift
//  ThmanyaTask
//
//  Created by Mohammedbadr on 3/13/24.
//

import SwiftUI
import Kingfisher

struct PhotosView: View {
    @ObservedObject var viewModel: PhotosViewModel
    
    var body: some View {
        GeometryReader { reader in
            VStack(alignment: .leading, spacing: 10, content: {
                Text(viewModel.album.title ?? "")
                    .font(FontFactory.swiftUIFont(.sansArabic, .bold, 32))
                SearchBar()
                switch viewModel.loadingState {
                case .loading:
                    ProgressView()
                          .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                          .scaleEffect(2.0, anchor: .center) // Makes the spinner larger
                          .frame(width: reader.size.width, height: 150)
                case .populated:
                    PhotosGridView(viewModel: viewModel, size: reader.size)
                case .error(let error):
                    VStack(content: {
                        Text("Error: \(error.localizedDescription)")
                        Button {
                            Task(priority: .utility) {
                                await viewModel.getPhotos()
                            }
                        } label: {
                            Text("Try again")
                                .padding(.all, 20)
                                .frame(width: reader.size.width, height: 50)
                                .padding(.all, 20)
                        }

                    })
                }
                
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
    PhotosView(viewModel: PhotosViewModel(album: AlbumsResponse(), navigationDelegate: nil, backDelegate: nil))
}

struct PhotosGridView: View {
    @ObservedObject var viewModel: PhotosViewModel
    var size: CGSize
    
    
    var body: some View {
        BackwardCompatibleScrollView {
            debugPrint("Action On Scroll")
        } content: {
            LazyVGrid(columns: Array(repeating: GridItem(.adaptive(minimum: size.width / 3, maximum: size.width / 3), spacing: 0), count: 3), spacing: 0) {
                ForEach(viewModel.searchQuery.isEmpty ? viewModel.photos : viewModel.filteredPhotos, id: \.self) { item in
                    VStack(alignment: .center, spacing: 0, content: {
                        if let url = URL(string: item.thumbnailURL ?? ""){
                            KFImage(url)
                                .placeholder{
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle(tint: Color.blue))
                                        .scaleEffect(2.0, anchor: .center) // Makes the spinner larger
                                        .frame(width: size.width, height: 150)
                                }
                                .aspectRatio(contentMode: .fit)
                                .frame(width: size.width / 3)
                                .clipped()
                                .onTapGesture {
                                    if let url = URL(string: item.url ?? "") {
                                        viewModel.navigationDelegate?.presentFullScreenPhoto(url: url)
                                    }
                                }
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
