//
//  CoordinatorProtocol.swift
//  ios-mvvm-template
//
//  Created by Thuong Nguyen on 7/4/22.
//

import Foundation

protocol Coordinator {
    var childCoordinators: [Coordinator] { get }
    
    func start()
}
