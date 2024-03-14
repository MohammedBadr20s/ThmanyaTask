//
//  UsersViewModel.swift
//  ThmanyaTask
//
//  Created by Mohammedbadr on 3/13/24.
//

import Combine


class UsersViewModel: ViewModable, ObservableObject, NavigationProtocol {
    var navigationDelegate: UsersNavigationDelegate?
    var backDelegate: BackDelegate?
    var cancellables = Set<AnyCancellable>()
    
    @MainActor @Published var users: [UsersResponse] = []
    @Published var loadingState: LoadingState = .loading
    
    // This is done only for SwiftUI Preview to work
    init() {
        self.navigationDelegate = nil
        self.backDelegate = nil
        self.cancellables = Set<AnyCancellable>()
    }
    
    init(
        navigationDelegate: UsersNavigationDelegate,
        backDelegate: BackDelegate,
        cancellables: Set<AnyCancellable> = Set<AnyCancellable>()) {
        self.navigationDelegate = navigationDelegate
        self.backDelegate = backDelegate
        self.cancellables = cancellables
    }
    
    
    @MainActor func getUsers() async {
        loadingState = .loading
        do {
            let users = try await UsersService.getUsers.Request(model: [UsersResponse].self)
            self.users = users
            loadingState = .populated
        } catch let error {
            debugPrint("Error Log should be here with error: \(error)")
            loadingState = .error(error)
        }
    }
}
