//
//  Task.swift
//  ToDoList
//
//  Created by Kostiantyn Kaniuka on 22.11.2022.
//

import Foundation
import RealmSwift

class Task: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title = ""
    @Persisted var completed = false
}


