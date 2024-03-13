//
//  UsersView.swift
//  ThmanyaTask
//
//  Created by Mohammedbadr on 3/13/24.
//

import SwiftUI

struct UsersView: View {
    @ObservedObject var viewModel: UsersViewModel

    var body: some View {
        GeometryReader(content: { reader in
            BackwardCompatibleScrollView {
                debugPrint("Action On Scroll")
            } content: {
                VStack(alignment: .leading, spacing: 10, content: {
                    Text("Profile")
                        .font(FontFactory.swiftUIFont(.sansArabic, .bold, 32))
                    Text("Leanne Graham")
                    Text("Leanne GrahamLeanne GrahamLeanne GrahamLeanne GrahamLeanne GrahamLeanne Graham")
                    Text("My Albums")
                    ForEach(viewModel.albums, id: \.self) { item in
                        VStack(alignment: .leading, spacing: 10, content: {
                            Text(item)
                            Divider()
                        })
                        .onTapGesture {
                            viewModel.navigationDelegate?.navigateToAlbumDetails(id: item)
                        }
                    }
                   

                   
                })
                .padding(.horizontal, 5)
                .frame(width: reader.size.width, alignment: .leading)
//                .background(.blue)
                .clipShape(
                    RoundedRectangle(cornerRadius: 5)
                )

            }
            .frame(alignment: .center)
        })
        .padding(.horizontal, 2)
        .clipped()
        .ignoresSafeArea(.keyboard, edges: .bottom)

        
    }
}

#Preview {
    UsersView(viewModel: UsersViewModel())
}
