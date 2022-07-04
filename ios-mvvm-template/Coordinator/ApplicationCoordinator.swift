//
//  ApplicationCoordinator.swift
//  ios-mvvm-template
//
//  Created by Thuong Nguyen on 7/4/22.
//

import Foundation
import UIKit

class ApplicationCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let navVC = UINavigationController()
        
        let schoolListCoordinator = SchoolListCoordinator(navController: navVC)
        
        schoolListCoordinator.start()
        
        window.rootViewController = navVC
        window.makeKeyAndVisible()
    }
}
