//
//  ExpoAppError.swift
//  Expo1900
//
//  Created by Ryan-Son on 2021/04/07.
//

enum ExpoAppError: Error, Equatable {
  case invalidJSONFileName(String)
  case invalidJSONFormat(String)
  case foundNil(String)
  case numberFormattingFailed(Int)
  case unknownError(String)
}

extension ExpoAppError: CustomDebugStringConvertible {
  var debugDescription: String {
    switch self {
    case .invalidJSONFileName(let fileName):
      return "π μ‘΄μ¬νμ§ μλ JSON νμΌμ΄μμ. νμΌ μ΄λ¦μ λ€μ νμΈν΄μ£ΌμΈμ! νμΌ μ΄λ¦: \(fileName)"
    case .invalidJSONFormat(let fileName):
      return "π JSON νμμ΄ λ§μ§ μμμ. λ°μ΄ν°λ₯Ό λ€μ νμΈν΄μ£ΌμΈμ. νμΌ μ΄λ¦: \(fileName)"
    case .foundNil(let valueName):
      return "π΅ μ΄ κ°μ nilμ΄μμ! κ° μ΄λ¦: \(valueName)"
    case .numberFormattingFailed(let number):
      return "π μ«μ νμ λ³νμ μ€ν¨νμ΄μ! μ«μλ₯Ό λ€μ νμΈν΄μ£ΌμΈμ. μλ ₯ν μ«μ: \(number)"
    case .unknownError(let location):
      return "π μ μ μλ μλ¬κ° λ°μνμ΄μ! λ°μ μμΉ: \(location)"
    }
  }
}
