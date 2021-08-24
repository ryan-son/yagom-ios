//
//  PMError.swift
//  ProjectManager
//
//  Created by duckbok, Ryan-Son on 2021/07/20.
//

import Foundation

enum PMError: Error {

    case decodingFailed
    case foundInvalidUserInfoKeyWhileDecoding
    case invalidTypeIdentifier
    case cannotEncodeToJSON(String)
    case requestFailed(Error)
    case failureResponse(Int)
    case dataNotFound
}

extension PMError: CustomStringConvertible {
    var description: String {
        switch self {
        case .decodingFailed:
            return "디코딩 작업에 실패하였어요."
        case .foundInvalidUserInfoKeyWhileDecoding:
            return "디코딩 작업 중 유효하지 않은 UserInfoKey를 발견했어요. NSManagedObjectContext 타입인지 확인하세요."
        case .invalidTypeIdentifier:
            return "유효하지 않은 Type Identifier네요."
        case .cannotEncodeToJSON(let location):
            return "JSON으로의 인코딩 작업에 실패하였어요. Location: \(location)"
        case .requestFailed(let error):
            return "요청 실패! 인터넷이 연결되어 있는지 확인하세요. Error: \(error)"
        case .failureResponse(let statusCode):
            return "실패한 응답을 받았어요. \(statusCode)"
        case .dataNotFound:
            return "데이터가 없어요."
        }
    }
}
