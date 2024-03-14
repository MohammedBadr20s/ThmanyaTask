//
//  AlbumsView.swift
//  ThmanyaTask
//
//  Created by Mohammedbadr on 3/13/24.
//

import SwiftUI

struct AlbumsView: View {
    @ObservedObject var viewModel: AlbumsViewModel

    var body: some View {
        GeometryReader(content: { reader in
            VStack(alignment: .leading, spacing: 10, content: {
        
                Text(viewModel.user?.name ?? "")
                    .font(FontFactory.swiftUIFont(.sansArabic, .semiBold, 25))
                
                Text(viewModel.user?.address?.fullAddress ?? "")
                    .font(FontFactory.swiftUIFont(.sansArabic, .regular, 16))

                Text("Albums")
                    .font(FontFactory.swiftUIFont(.sansArabic, .bold, 32))
                Divider()
                BackwardCompatibleScrollView {
                    debugPrint("Action On Scroll")
                } content: {
                    VStack(alignment: .leading, spacing: 10, content: {
                        
                        switch viewModel.loadingState {
                        case .loading:
                            ProgressView()
                                  .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                                  .scaleEffect(2.0, anchor: .center) // Makes the spinner larger
                                  .frame(width: reader.size.width, height: 150)
                        case .populated:
                            AlbumsList(viewModel: viewModel)

                        case .error(let error):
                            VStack(content: {
                                Text("Error: \(error.localizedDescription)")
                                Button {
                                    Task(priority: .utility) {
                                        await viewModel.getAlbums()
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
                    .padding(.horizontal, 5)
                    .frame(width: reader.size.width, alignment: .leading)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 5)
                    )

                }
                .frame(alignment: .center)
            })
            .padding(.leading, 5)
            
        })
        .padding(.horizontal, 2)
        .clipped()
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .navigationBarBackButtonHidden()
        .task(priority: .utility) {
            await viewModel.getAlbums()
        }

        
    }
}

#Preview {
    AlbumsView(viewModel: AlbumsViewModel())
}

struct AlbumsList: View {
    @ObservedObject var viewModel: AlbumsViewModel

    var body: some View {
        ForEach(viewModel.albums, id: \.self) { item in
            VStack(alignment: .leading, spacing: 10, content: {
                Text(item.title ?? "")
                Divider()
            })
            .contentShape(Rectangle())
            .onTapGesture {
                viewModel.navigationDelegate?.navigateToAlbumDetails(album: item)
            }
        }
    }
}
