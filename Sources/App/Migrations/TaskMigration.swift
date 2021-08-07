//
//  MigrateTask.swift
//  
//
//  Created by Ryan-Son on 2021/08/07.
//

import Fluent

struct TaskMigration: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        _ = database.enum(Task.Key.state.description)
            .case(Task.State.todo.rawValue)
            .case(Task.State.doing.rawValue)
            .case(Task.State.done.rawValue)
            .create()
        return database.enum(Task.Key.state.description).read().flatMap { state in
            database.schema(Task.schema)
                .field(Task.Key.id, .uuid, .identifier(auto: false))
                .field(Task.Key.title, .string, .required)
                .field(Task.Key.body, .string)
                .field(Task.Key.due_date, .datetime, .required)
                .field(Task.Key.state, state, .required)
                .field(Task.Key.created_at, .datetime, .required)
                .field(Task.Key.updated_at, .datetime, .required)
                .field(Task.Key.deleted_at, .datetime)
                .create()
        }
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(Task.schema).delete()
    }
}
