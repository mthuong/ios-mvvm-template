//
//  APIService.swift
//  ios-mvvm-template
//
//  Created by Thuong Nguyen on 7/3/22.
//

import Foundation

protocol SchoolAPIServiceProtocol {
    func fetchSchools(completion: @escaping (_ success: Bool,_ schools: [School], _ error: Error?) -> Void)
    func fetchSchoolDetails(schoolId: String, completion: @escaping (_ success: Bool, _ schoolDetail: SchoolDetail?, _ error: Error?) -> Void) -> Void
}
