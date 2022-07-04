//
//  SchoolDetail.swift
//  ios-mvvm-template
//
//  Created by Thuong Nguyen on 7/3/22.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let schoolDetail = try SchoolDetail(json)

import Foundation

// MARK: - SchoolDetail
struct SchoolDetail: Codable {
    let dbn, schoolName, numOfSatTestTakers, satCriticalReadingAvgScore: String?
    let satMathAvgScore, satWritingAvgScore: String?

    enum CodingKeys: String, CodingKey {
        case dbn
        case schoolName = "school_name"
        case numOfSatTestTakers = "num_of_sat_test_takers"
        case satCriticalReadingAvgScore = "sat_critical_reading_avg_score"
        case satMathAvgScore = "sat_math_avg_score"
        case satWritingAvgScore = "sat_writing_avg_score"
    }
}

// MARK: SchoolDetail convenience initializers and mutators

extension SchoolDetail {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(SchoolDetail.self, from: data)
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

    func with(
        dbn: String?? = nil,
        schoolName: String?? = nil,
        numOfSatTestTakers: String?? = nil,
        satCriticalReadingAvgScore: String?? = nil,
        satMathAvgScore: String?? = nil,
        satWritingAvgScore: String?? = nil
    ) -> SchoolDetail {
        return SchoolDetail(
            dbn: dbn ?? self.dbn,
            schoolName: schoolName ?? self.schoolName,
            numOfSatTestTakers: numOfSatTestTakers ?? self.numOfSatTestTakers,
            satCriticalReadingAvgScore: satCriticalReadingAvgScore ?? self.satCriticalReadingAvgScore,
            satMathAvgScore: satMathAvgScore ?? self.satMathAvgScore,
            satWritingAvgScore: satWritingAvgScore ?? self.satWritingAvgScore
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
