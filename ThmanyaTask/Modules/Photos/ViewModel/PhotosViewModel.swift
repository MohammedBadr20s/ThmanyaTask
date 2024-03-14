//
//  PhotosViewModel.swift
//  ThmanyaTask
//
//  Created by Mohammedbadr on 3/13/24.
//

import Combine

class PhotosViewModel: ViewModable, NavigationProtocol, ObservableObject {
    var cancellables = Set<AnyCancellable>()
    var backDelegate: BackDelegate?
    var navigationDelegate: PhotosNavigationDelegate?
    var album: AlbumsResponse
    @Published var photos: [PhotoResponse] = []
    @Published var filteredPhotos: [PhotoResponse] = []
    @Published var searchQuery: String = ""
    @Published var loadingState: LoadingState = .loading
    
    init(
        album: AlbumsResponse,
        navigationDelegate: PhotosNavigationDelegate?,
        backDelegate: BackDelegate?,
        cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
    ) {
        self.album = album
        self.cancellables = cancellables
        self.backDelegate = backDelegate
        self.navigationDelegate = navigationDelegate
        
        $searchQuery.sink { [weak self] query in
            guard let self else { return }
            self.filteredPhotos = self.photos.filter({($0.title ?? "").lowercased().contains(query.lowercased())})
        }.store(in: &self.cancellables)
    }
    
    
    
    @MainActor func getPhotos() async {
        loadingState = .loading
        do {
            let photos = try await PhotosService.getPhotos(albumId: album.id ?? 0).Request(model: [PhotoResponse].self)
            self.photos = photos
            loadingState = .populated
        } catch let error {
            debugPrint("Error Log should be here with error: \(error)")
            loadingState = .error(error)
        }
    }
    
}
