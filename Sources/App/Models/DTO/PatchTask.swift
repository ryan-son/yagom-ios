//
//  PatchTask.swift
//  
//
//  Created by Ryan-Son on 2021/08/07.
//

import Vapor

struct PatchTask: Content {

    let id: UUID
    let title: String?
    let body: String?
    let due_date: Int?
    let state: String?
}
