//
//  SchoolDetailViewModel.swift
//  ios-mvvm-template
//
//  Created by Thuong Nguyen on 7/3/22.
//

import Foundation

class SchoolDetailViewModel {
    let schoolDetailTitles = ["NAME","SUMMARY", "TEST TAKERS NO","SAT AVERAGE READING SCORE", "SAT AVERAGE MATH SCORE", "SAT AVERAGE WRITING SCORE"]
    
    private var school: School?
    
    var schoolDetail: SchoolDetail?
    
    private let schoolAPIService: SchoolAPIServiceProtocol
    
    init(service: SchoolAPIServiceProtocol = SchoolAPIService(), school: School?) {
        self.schoolAPIService = service
        self.school = school
    }
    
    func fetchSchoolDetail(completion: @escaping (_ success: Bool, _ error: Error?) -> Void) -> Void {
        guard let school = school else {
            return completion(false,apiError(errorId: 501, description: "Server not found", errorKind: .serverError))
        }
        
        schoolAPIService.fetchSchoolDetails(schoolId: school.dbn) { success, schoolDetail, error in
            if let error = error {
                completion(false, error)
            }
            
            if (schoolDetail != nil) {
                self.schoolDetail = schoolDetail
                completion(success, nil)
            } else {
                completion(success, apiError(errorId: 502, description: "No Data Found", errorKind: .noDataFound))
            }
        }
    }
    
    func getSchoolSummary() -> String {
        guard let school = school else { return "Not Available"}
        return school.summary
    }
}
