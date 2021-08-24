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
        
        return "🏦 \(owner.waitingNumber)번 \(owner.grade.name)고객 \(type.name)업무 시작."
    }
    
    func endTask() throws -> String {
        guard let owner: Clientable = owner else {
            throw BankManagerError.ownerNotAssigned
        }
        
        return "✅ \(owner.waitingNumber)번 \(owner.grade.name)고객 \(type.name)업무 완료!"
    }
    
    func rejectLoanExecution() throws -> String {
        guard let owner: Clientable = owner else {
            throw BankManagerError.ownerNotAssigned
        }
        
        return "❌ \(owner.waitingNumber)번 \(owner.grade.name)고객의 대출이 거절되었습니다."
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
                return "예금"
            case .loan:
                return "대출"
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
