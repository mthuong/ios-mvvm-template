//
//  SchoolViewModel.swift
//  ios-mvvm-template
//
//  Created by Thuong Nguyen on 7/3/22.
//

import Foundation

class SchoolViewModel {
    private let title = "NYC Schools"
    
    private let schoolApiService: SchoolAPIServiceProtocol
    
    var schools: [School] = [School]()
    
    private let coordinator: SchoolListCoordinator
    
    init(schoolApiService: SchoolAPIServiceProtocol = SchoolAPIService(), coordinator: SchoolListCoordinator) {
        self.schoolApiService = schoolApiService
        self.coordinator = coordinator
    }
    
    func fetchSchools(completion: @escaping(_ success: Bool, _ error: Error?) -> Void) -> Void {
        schoolApiService.fetchSchools { success, schools, error in
            guard error == nil else {
                completion(false, error)
                return
            }
            
            if success {
                self.schools = schools
                
                if !schools.isEmpty {
                    completion(success, nil)
                } else {
                    completion(success, apiError(errorId: 502, description: "Data Not Found", errorKind: .noDataFound))
                }
            }
        }
    }
    
    func setupCell(_ cell: SchoolCell, indexPath: IndexPath) -> Void {
        let school = self.schools[indexPath.row]
        cell.schoolNameLabel.text = school.schoolName
        cell.summaryLabel.text = school.summary
        cell.studentsLabel.attributedText = NSMutableAttributedString()
                .bold("Students enrolled: ")
                .normal("\(school.totalStudents)")
        cell.locationLabel.text = school.location
        cell.phoneLabel.text = school.phoneNumber
        cell.websiteLabel.attributedText = NSMutableAttributedString()
                .normal("\(school.website)")
    }
    
    func getSchoolAt(_ indexPath: IndexPath) -> School? {
        if schools.count > indexPath.row {
            return schools[indexPath.row]
        }
        return nil
    }
    
    func showSchoolDetails(_ indexPath: IndexPath) -> Void {
        // Show details
        let school = getSchoolAt(indexPath)
        coordinator.showSchoolDetail(school)
    }
}
