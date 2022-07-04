//
//  SchoolListCoordicator.swift
//  ios-mvvm-template
//
//  Created by Thuong Nguyen on 7/4/22.
//

import Foundation
import UIKit

class SchoolListCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    
    private let navigationController: UINavigationController
    
    init(navController: UINavigationController) {
        self.navigationController = navController
    }
    
    func start() {
        let vm = SchoolViewModel(schoolApiService: SchoolAPIService(), coordinator: self)
        let vc = SchoolListViewController(viewModel: vm)
        navigationController.setViewControllers([vc], animated: true)
    }
}

extension SchoolListCoordinator {
    func showSchoolDetail(_ school: School?) -> Void {
        let coordinator = SchoolDetailCoordinator(presenter: navigationController, school: school)
        
        childCoordinators.append(coordinator)
        
        coordinator.start()
    }
}
