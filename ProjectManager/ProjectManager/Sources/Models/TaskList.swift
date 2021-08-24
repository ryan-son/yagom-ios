//
//  TaskList.swift
//  ProjectManager
//
//  Created by duckbok, Ryan-Son on 2021/07/21.
//

import Foundation
import CoreData

struct TaskList: Codable {

    private var todos: [Task]
    private var doings: [Task]
    private var dones: [Task]

    init(todos: [Task] = [], doings: [Task] = [], dones: [Task] = []) {
        self.todos = todos
        self.doings = doings
        self.dones = dones
    }

    subscript(state: Task.State) -> [Task] {
        get {
            switch state {
            case .todo:
                return self.todos
            case .doing:
                return self.doings
            case .done:
                return self.dones
            }
        }

        set {
            switch state {
            case .todo:
                todos = newValue
            case .doing:
                doings = newValue
            case .done:
                dones = newValue
            }
        }
    }

    var count: Int {
        return todos.count + doings.count + dones.count
    }
}

extension TaskList {

    init(context: NSManagedObjectContext, responseTasks: [ResponseTask]) {

        let responseTodos = responseTasks.filter { $0.state == .todo }
        let responseDoings = responseTasks.filter { $0.state == .doing }
        let responseDones = responseTasks.filter { $0.state == .done }

        let todos = responseTodos.map { Task(context: context, responseTask: $0) }
        let doings = responseDoings.map { Task(context: context, responseTask: $0) }
        let dones = responseDones.map { Task(context: context, responseTask: $0) }

        self.init(todos: todos, doings: doings, dones: dones)
    }
}
