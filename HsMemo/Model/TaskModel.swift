//
//  TaskItem.swift
//  HsMemo
//
//  Created by Максим Козлов on 20/10/2018.
//  Copyright © 2018 Максим Козлов. All rights reserved.
//
import Foundation
import UserNotifications

// Структура данных


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
    // если выполнено то удалить уведомление иначе на оборот
    if  (taskData[item]["isComplited"] as! Bool == true){
        removeNotifications(withIdentifiers: [taskData[item]["Title"] as! String])
    }else{
        scheduleNotification(indetifiers: taskData[item]["Title"] as! String,
                             title: taskData[item]["Title"] as! String,
                             deadDate: taskData[item]["DeadDate"] as! Date) { (success) in
            if (success){
                print("GOOOD")
            }
        }
    }
    
    return taskData[item]["isComplited"] as! Bool
}
// Метод удаления Task из списка
func removeItem(at index: Int){
    removeNotifications(withIdentifiers: [taskData[index]["Title"] as! String])
    taskData.remove(at: index)
}

// Функция создани уведомления
func scheduleNotification(indetifiers: String, title: String , deadDate date: Date, completion: (Bool) -> ()) {
    
    // Создание контента уведомления
    let content = UNMutableNotificationContent()
    content.title = "Напоминание!"
    content.body = title
    content.sound = UNNotificationSound.default
    
    // Устанавливаем вид календаря
    let calendar = Calendar(identifier: .gregorian)
    let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)
    let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
    let request = UNNotificationRequest(identifier: indetifiers, content: content, trigger: trigger)
    
    // Запрашиваем центер уведомлений
    let center = UNUserNotificationCenter.current()
    // И добавляем наже уведомление в центр
    center.add(request, withCompletionHandler: nil)
}

// Удаление уведомления
func removeNotifications(withIdentifiers indetifiers: [String]) {
    let center = UNUserNotificationCenter.current()
    center.removePendingNotificationRequests(withIdentifiers: indetifiers)
}
