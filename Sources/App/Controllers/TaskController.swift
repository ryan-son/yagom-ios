//
//  TaskController.swift
//  
//
//  Created by Ryan-Son on 2021/08/07.
//

import Fluent
import Vapor

struct TaskController: RouteCollection {

    enum RouteGroup {
        static let tasks: PathComponent = "tasks"
        static let task: PathComponent = "task"
    }

    func boot(routes: RoutesBuilder) throws {
        let tasks = routes.grouped(RouteGroup.tasks)
        tasks.get(use: read)

        let task = routes.grouped(RouteGroup.task)
    }

    func read(request: Request) throws -> EventLoopFuture<[Task]> {
        return Task.query(on: request.db).all()
    }
}
