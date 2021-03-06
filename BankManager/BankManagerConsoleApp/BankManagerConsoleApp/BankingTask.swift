//
//  BankingTask.swift
//  BankManagerConsoleApp
//
//  Created by Yun, Ryan on 2021/05/05.
//

import Foundation

final class BankingTask: Operation {
    // MARK: - Properties
    var owner: Clientable?
    private let type: TaskType
    
    init(_ type: TaskType) {
        self.type = type
    }
    
    // MARK: - Override Method from the Operation Class
    override func main() {
        guard let owner: Clientable = owner else {
            return
        }
        
        do {
            let startTaskText: String = try startTask()
            let endTaskText: String = try endTask()
            
            print(startTaskText)
            try processTask(of: owner)
            print(endTaskText)
        } catch {
            print(error)
        }
    }
}

// MARK: - Private Methods
extension BankingTask {
    func startTask() throws -> String {
        guard let owner: Clientable = owner else {
            throw BankManagerError.ownerNotAssigned
        }
        
        return "π¦ \(owner.waitingNumber)λ² \(owner.grade.name)κ³ κ° \(type.name)μλ¬΄ μμ."
    }
    
    func endTask() throws -> String {
        guard let owner: Clientable = owner else {
            throw BankManagerError.ownerNotAssigned
        }
        
        return "β \(owner.waitingNumber)λ² \(owner.grade.name)κ³ κ° \(type.name)μλ¬΄ μλ£!"
    }
    
    func rejectLoanExecution() throws -> String {
        guard let owner: Clientable = owner else {
            throw BankManagerError.ownerNotAssigned
        }
        
        return "β \(owner.waitingNumber)λ² \(owner.grade.name)κ³ κ°μ λμΆμ΄ κ±°μ λμμ΅λλ€."
    }
    
    private func processDeposit() {
        Thread.sleep(forTimeInterval: TaskForLocalBank.deposit.processTime)
    }
    
    private func reviewDocuments() {
        Thread.sleep(forTimeInterval: TaskForLocalBank.loanDocumentsReview.processTime)
    }
    
    private func executeLoan() {
        Thread.sleep(forTimeInterval: TaskForLocalBank.loanExecution.processTime)
    }
    
    private func processTask(of owner: Clientable) throws {
        switch type {
        case .deposit:
            processDeposit()
        case .loan:
            reviewDocuments()
            let isApproved: Bool = BankHeadquarter.screenLoan(for: owner)
            
            if isApproved {
                executeLoan()
            } else {
                let rejectLoanExecutionText: String = try rejectLoanExecution()
                print(rejectLoanExecutionText)
            }
        }
    }
}

// MARK: - NameSpaces
extension BankingTask {
    enum TaskType: CaseIterable {
        case deposit
        case loan
        
        var name: String {
            switch self {
            case .deposit:
                return "μκΈ"
            case .loan:
                return "λμΆ"
            }
        }
        
        static var random: TaskType {
            guard let randomTask: TaskType = TaskType.allCases.randomElement() else {
                return .deposit
            }
            return randomTask
        }
    }
}
