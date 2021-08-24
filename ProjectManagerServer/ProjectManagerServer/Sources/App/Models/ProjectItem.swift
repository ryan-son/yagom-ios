//
//  ProjectItem.swift
//  
//
//  Created by Wody, Kane, Ryan-Son on 2021/07/02.
//

import Fluent
import Vapor

final class ProjectItem: Model, Content {
    static let schema = "projectItems"
    
    enum Progress: String, Codable {
        case todo, doing, done
    }
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "title")
    var title: String
    
    @Field(key: "content")
    var content: String
    
    @Field(key: "deadlineDate")
    var deadlineDate: Date
    
    @Enum(key: "progress")
    var progress: Progress
    
    @Field(key: "index")
    var index: Int
    
    init() { }
    
    init(id: UUID? = nil, title: String, content: String, deadlineDate: Date, progress: Progress, index: Int) {
        self.id = id
        self.title = title
        self.content = content
        self.deadlineDate = deadlineDate
        self.progress = progress
        self.index = index
    }
    
    init(_ postProjectItem: PostProjectItem) {
        self.id = postProjectItem.id
        self.title = postProjectItem.title
        self.content = postProjectItem.content
        self.deadlineDate = postProjectItem.deadlineDate
        self.progress = postProjectItem.progress
        self.index = postProjectItem.index
    }
}
