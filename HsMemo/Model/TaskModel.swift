//
//  TaskItem.swift
//  HsMemo
//
//  Created by Максим Козлов on 20/10/2018.
//  Copyright © 2018 Максим Козлов. All rights reserved.
//

import Foundation

// Массив списка Tasks
// Set если передаются новые данные то сохраняем
// Get если просто просим список загрузить если есть данные иначе передать пустой
var taskData: [[String: Any]] {
    set{
        UserDefaults.standard.set(newValue, forKey: "TaskKey")
        UserDefaults.standard.synchronize()
    }
    
    get{
        if let array = UserDefaults.standard.array(forKey: "TaskKey") {
            return array as! [[String : Any]]
        } else {
            return []
        }
    }
}
// Метод добавления нового Task
func addTask(title: String, isComplited: Bool = false, deadDate: Date){
    taskData.append(["Title": title,"isComplited": isComplited, "DeadDate": deadDate])
}
// Метод меняет статус выполнен/не выполнен
func changeState(at item: Int) -> Bool{
    taskData[item]["isComplited"] = !(taskData[item]["isComplited"] as! Bool)
    return taskData[item]["isComplited"] as! Bool
}
// Метод удаления Task из списка
func removeItem(at index: Int){
    taskData.remove(at: index)
}
