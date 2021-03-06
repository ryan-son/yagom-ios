//
//  BankHeadquarter.swift
//  BankManagerConsoleApp
//
//  Created by Yun, Ryan on 2021/05/06.
//

import Foundation

struct BankHeadquarter {
    // MARK: - Properties
    private static let semaphore: DispatchSemaphore = DispatchSemaphore(
        value: Task.NumberToBeProcessedAtOnce
    )
    
    // MARK: - Name spaces
    private enum Task {
        case loanScreening
        
        var processTime: Double {
            switch self {
            case .loanScreening:
                return 0.5
            }
        }
        
        static let NumberToBeProcessedAtOnce: Int = 1
    }
    
    // MARK: - Private Methods
    static func startLoanScreening(of client: Clientable) -> String {
        return "π§Ύ \(client.waitingNumber)λ² \(client.grade.name)κ³ κ° λμΆμ¬μ¬ μμ."
    }
    
    static func endLoanScreening(of client: Clientable) -> String {
        return "π \(client.waitingNumber)λ² \(client.grade.name)κ³ κ° λμΆμ¬μ¬ μλ£!"
    }
    
    
    static func screenLoan(for client: Clientable) -> Bool {
        semaphore.wait()
        
        let startLoanScreeningText: String = startLoanScreening(of: client)
        let endLoanScreeningText: String = endLoanScreening(of: client)
        
        print(startLoanScreeningText)
        Thread.sleep(forTimeInterval: Task.loanScreening.processTime)
        print(endLoanScreeningText)
        
        semaphore.signal()
        
        return true
    }
}
