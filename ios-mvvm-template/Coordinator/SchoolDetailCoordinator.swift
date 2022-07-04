//
//  SchoolDetailCoordinator.swift
//  ios-mvvm-template
//
//  Created by Thuong Nguyen on 7/4/22.
//

import Foundation
import UIKit

class SchoolDetailCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    
    private let presenter: UINavigationController
    private var schoolDetailViewController: SchoolDetailViewController?
    private let school: School?
    
    init(presenter: UINavigationController, school: School?) {
        self.presenter = presenter
        self.school = school
    }
    
    func start() {
        let vc = SchoolDetailViewController(viewModel: SchoolDetailViewModel(school: school))
        
        presenter.pushViewController(vc, animated: true)
        self.schoolDetailViewController = vc
    }
}
