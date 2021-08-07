import Fluent
import Vapor

final class Task: Model, Content {

    enum Key {
        static let schema = "task"

        static let title: FieldKey = "title"
        static let body: FieldKey = "body"
        static let due_date: FieldKey = "due_date"
        static let state: FieldKey = "state"
        static let created_at: FieldKey = "created_at"
        static let updated_at: FieldKey = "updated_at"
        static let deleted_at: FieldKey = "deleted_at"
    }

    enum State: String, Codable {
        case todo, doing, done
    }

    static let schema = Task.Key.schema

    @ID(key: .id)
    var id: UUID?

    @Field(key: Task.Key.title)
    var title: String

    @Field(key: Task.Key.body)
    var body: String?

    @Field(key: Task.Key.due_date)
    var due_date: Int

    @Field(key: Task.Key.state)
    var state: State

    @Timestamp(key: Task.Key.created_at, on: .create, format: .unix)
    var created_at: Date?

    @Timestamp(key: Task.Key.updated_at, on: .update, format: .unix)
    var updated_at: Date?

    @Timestamp(key: Task.Key.deleted_at, on: .delete, format: .unix)
    var deleted_at: Date?

    init() { }

    init(id: UUID, title: String, body: String? = nil, due_date: Int, state: State) {
        self.id = id
        self.title = title
        self.body = body
        self.due_date = due_date
        self.state = state
    }
}
