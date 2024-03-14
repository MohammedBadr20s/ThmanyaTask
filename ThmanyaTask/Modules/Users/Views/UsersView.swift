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
                    Text("Users")
                        .font(FontFactory.swiftUIFont(.sansArabic, .bold, 32))
                    switch viewModel.loadingState {
                    case .loading:
                        ProgressView()
                              .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                              .scaleEffect(2.0, anchor: .center) // Makes the spinner larger
                              .frame(width: reader.size.width, height: 150)
                    case .populated:
                        UsersList(viewModel: viewModel)

                    case .error(let error):
                        VStack(content: {
                            Text("Error: \(error.localizedDescription)")
                            Button {
                                Task(priority: .utility) {
                                    await viewModel.getUsers()
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
        .padding(.horizontal, 2)
        .clipped()
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .task(priority: .utility) {
            await viewModel.getUsers()
        }

        
    }
}

#Preview {
    UsersView(viewModel: UsersViewModel())
}

struct UsersList: View {
    @ObservedObject var viewModel: UsersViewModel

    var body: some View {
        ForEach(viewModel.users, id: \.self) { item in
            VStack(alignment: .leading, spacing: 10, content: {
                Text(item.name ?? "")
                Divider()
            })
            .contentShape(Rectangle())
            .onTapGesture {
                viewModel.navigationDelegate?.navigateToUserAlbums(user: item)
            }
        }
    }
}
