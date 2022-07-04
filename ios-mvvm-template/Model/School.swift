//
//  School.swift
//  ios-mvvm-template
//
//  Created by Thuong Nguyen on 7/3/22.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let school = try School(json)

import Foundation

// MARK: - School
struct School: Codable {
    let dbn: String
    let schoolName: String
    let website: String
    let location: String
    let totalStudents: String
    let summary: String
    let phoneNumber: String
    
    enum CodingKeys: String, CodingKey {
        case dbn
        case schoolName = "school_name"
        case website
        case location
        case totalStudents = "total_students"
        case summary = "overview_paragraph"
        case phoneNumber = "phone_number"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        dbn = try values.decode(String.self, forKey: .dbn)
        schoolName = try values.decode(String.self, forKey: .schoolName)
        website = try values.decode(String.self, forKey: .website)
        location = try values.decode(String.self, forKey: .location)
        totalStudents = try values.decode(String.self, forKey: .totalStudents)
        summary = try values.decode(String.self, forKey: .summary)
        phoneNumber = try values.decode(String.self, forKey: .phoneNumber)
    }
}

// MARK: School convenience initializers and mutators

extension School {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(School.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
//    func with(
//        dbn: String?? = nil,
//        schoolName: String?? = nil,
//        website: String?? = nil,
//        location: String?? = nil,
//        totalStudents: String?? = nil,
//        summary: String?? = nil,
//        phoneNumber: String?? = nil
//    ) -> School {
//        return School(
//            dbn: dbn ?? self.dbn,
//            schoolName: schoolName ?? self.schoolName,
//            website: website ?? self.website,
//            location: location ?? self.location,
//            totalStudents: totalStudents ?? self.totalStudents,
//            summary: summary ?? self.summary
//            phoneNumber: phoneNumber ?? self.phoneNumber,
//        )
//    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}
