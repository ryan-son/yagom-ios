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
        tasks.get(use: read(request:))

        let task = routes.grouped(RouteGroup.task)
        task.post(use: create(request:))
    }

    func read(request: Request) throws -> EventLoopFuture<[Task]> {
        return Task.query(on: request.db).all()
    }

    func create(request: Request) throws -> EventLoopFuture<Task> {
        guard request.headers.contentType == .json else {
            throw PMServerError.unsupportedContentType
        }

        let posted = try request.content.decode(PostTask.self)
        let willCreate = Task(from: posted)

        return willCreate.create(on: request.db).map { willCreate }
    }
}
