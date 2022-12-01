//
//  RealmManager.swift
//  ToDoList
//
//  Created by Kostiantyn Kaniuka on 22.11.2022.
//

import Foundation
import RealmSwift

final class RealmManager: ObservableObject {
    private(set) var localRealm: Realm?
    @Published private(set) var tasks: [Task] = []
    
    init() {
        openRealm()
        getTasks()
    }
    
    func openRealm() {
        do {
            let config = Realm.Configuration(schemaVersion: 18)
            Realm.Configuration.defaultConfiguration = config
            localRealm = try Realm()
        } catch {
            print("Error openig Realm: \(error)")
        }
    }
    
    func getTasks() {
        if let localRealm = localRealm {
            let allTasks = localRealm.objects(Task.self).sorted(byKeyPath: "completed")
            tasks = []
            allTasks.forEach{ task in
                tasks.append(task)
            }
        }
    }
    
    //MARK: - Add task  to database
    func addTask(title: String, deadlineDate: Date?, shortDescription: String?) {
        if let localRealm = localRealm {
            do {
                try localRealm.write {
                    let newTask = Task(value: ["title": title, "dateOfAdding": Date(), "completed": false, "deadlineDate" : deadlineDate as Any, "shortDescription": shortDescription as Any])
                    localRealm.add(newTask)
                    getTasks()
                    print("Added new task to Realm: \(newTask)")
                }
            } catch {
                print("Error adding task to Realm: \(error)")
            }
        }
    }
    
    //MARK: - Update task from ongoing to done
    func updateTask(id: ObjectId, completed: Bool, date: Date?) {
        if let localRealm = localRealm {
            do {
                let tasksToUpdate = localRealm.objects(Task.self).filter(NSPredicate(format: "_id == %@", id))
                guard !tasksToUpdate.isEmpty else { return }
                try localRealm.write {
                    tasksToUpdate[0].completed = completed
                    tasksToUpdate[0].doneAt = date
                    getTasks()
                    print("Updated task with id\(id)! Completed status: \(completed), Date of additing: \(String(describing: date))")
                }
            } catch {
                print("Error updating task \(id) to Realm: \(error)")
            }
        }
    }
    
    //MARK: - Edit description logic
    func applyChanges(id: ObjectId, taskName: String, shortDescription: String?) {
        if let localRealm = localRealm {
            do {
                let tasksToUpdate = localRealm.objects(Task.self).filter(NSPredicate(format: "_id == %@", id))
                guard !tasksToUpdate.isEmpty else { return }
                try localRealm.write {
                    tasksToUpdate[0].title = taskName
                    tasksToUpdate[0].shortDescription = shortDescription
                    getTasks()
                    print("Updated task with id\(id)! New title: \(taskName), Short description: \(String(describing: shortDescription))")
                }
            } catch {
                print("Error updating task \(id) to Realm: \(error)")
            }
        }
    }
    
    //MARK: - Change Deadline
    func newDeadline(id: ObjectId, deadline: Date?) {
        if let localRealm = localRealm {
            do {
                let tasksToUpdate = localRealm.objects(Task.self).filter(NSPredicate(format: "_id == %@", id))
                guard !tasksToUpdate.isEmpty else { return }
                try localRealm.write {
                    tasksToUpdate[0].deadlineDate = deadline
                    getTasks()
                    print("Updated task with id\(id)! New DeadLine: \(String(describing: deadline))")
                }
            } catch {
                print("Error updating task \(id) to Realm: \(error)")
            }
        }
    }
    
    //MARK: - Delete
    func deleteTask(id: ObjectId) {
        if let localRealm = localRealm {
            do {
                let tasksToDelete = localRealm.objects(Task.self).filter(NSPredicate(format: "_id == %@", id))
                guard !tasksToDelete.isEmpty else { return }
                
                try localRealm.write {
                    localRealm.delete(tasksToDelete)
                    getTasks()
                    print("Deleted task with id \(id)")
                }
            } catch {
                print("Error deleting task \(id) from Realm: \(error)")
            }
        }
    }
}
