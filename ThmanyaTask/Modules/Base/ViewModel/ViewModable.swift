//
//  ViewModable.swift
//  ThmanyaTask
//
//  Created by Mohammedbadr on 3/13/24.
//

import Foundation
import Combine

enum LoadingState {
    case loading
    case populated
    case error(Error)
}

protocol ViewModable {
    var cancellables: Set<AnyCancellable> { get set }
}
