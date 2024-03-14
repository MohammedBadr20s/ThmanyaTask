//
//  AlbumsViewModel.swift
//  ThmanyaTask
//
//  Created by Mohammedbadr on 3/13/24.
//

import Combine


class AlbumsViewModel: ViewModable, ObservableObject, NavigationProtocol {
    var navigationDelegate: AlbumsNavigationDelegate?
    var backDelegate: BackDelegate?
    var cancellables = Set<AnyCancellable>()
    var user: UsersResponse?
    @Published var albums: [AlbumsResponse] = []
    @Published var loadingState: LoadingState = .loading
    
    // This is done only for SwiftUI Preview to work
    init() {
        self.navigationDelegate = nil
        self.backDelegate = nil
        self.cancellables = Set<AnyCancellable>()
        self.user = nil
    }
    
    init(
        user: UsersResponse,
        navigationDelegate: AlbumsNavigationDelegate,
        backDelegate: BackDelegate,
        cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
    ) {
        self.user = user
        self.navigationDelegate = navigationDelegate
        self.backDelegate = backDelegate
        self.cancellables = cancellables
    }
    
    
    @MainActor func getAlbums() async {
        loadingState = .loading
        do {
            let albums = try await AlbumsService.getAlbums(userId: user?.id ?? 0).Request(model: [AlbumsResponse].self)
            self.albums = albums
            loadingState = .populated
        } catch let error {
            debugPrint("Error Log should be here with error: \(error)")
            loadingState = .error(error)
        }
    }
}
