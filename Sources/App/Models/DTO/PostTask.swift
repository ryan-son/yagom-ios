//
//  PostTask.swift
//  
//
//  Created by Ryan-Son on 2021/08/07.
//

import Vapor

struct PostTask: Content {

    let id: UUID
    let title: String
    let body: String?
    let due_date: Int
    let state: String
}
