//
//  UsersViewModel.swift
//  ThmanyaTask
//
//  Created by Mohammedbadr on 3/13/24.
//

import Combine


class UsersViewModel: ViewModable, ObservableObject, NavigationProtocol {
    var navigationDelegate: HomeNavigationDelegate?
    var backDelegate: BackDelegate?
    var cancellables = Set<AnyCancellable>()
    
    @Published var albums: [String] = []
    
    
    init() {
        self.navigationDelegate = nil
        self.backDelegate = nil
        self.cancellables = Set<AnyCancellable>()
//        assertionFailure("This is used only to enable previews and shouldn't be used in normal cases")
    }
    init(
        navigationDelegate: HomeNavigationDelegate,
        backDelegate: BackDelegate,
        cancellables: Set<AnyCancellable> = Set<AnyCancellable>()) {
        self.navigationDelegate = navigationDelegate
        self.backDelegate = backDelegate
        self.cancellables = cancellables
    }
    
    
    func getUsers() async {
        do {
            let users = try await UsersService.getUsers.Request(model: BaseModel<[String]>.self)
            albums = users.data ?? []
        } catch let error {
            debugPrint(error)
        }
    }
}
