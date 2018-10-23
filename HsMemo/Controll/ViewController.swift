//
//  ViewController.swift
//  HsMemo
//
//  Created by Максим Козлов on 19/10/2018.
//  Copyright © 2018 Максим Козлов. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

class ViewController: UITableViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // обнавление таблицы с данными при переходе на view
        tableView.reloadData()
    }
    
    // Работа с таблицей

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    // Создает колличество строк в списке таблицы из колличества строк в массиве
    public override func tableView(_ tableView1: UITableView, numberOfRowsInSection section: Int) -> Int{
        return taskData.count
    }
    
    // Выводит одну строку в таблице и вставляет в нее данные из одной строки массива
    public override func tableView(_ tableView1: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        // получаем текущий Task и присваиваем заголовок в ячейку таблицы
        let curTask = taskData[indexPath.row]
        cell.textLabel?.text = curTask["Title"] as? String
        
        // Настраиваем формат даты по выбраному языку
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale(identifier: "ru_RU")
        // Вывод даты
        cell.detailTextLabel?.text = dateFormatter.string(from: curTask["DeadDate"] as! Date)
        
        // Ссылки на изображения
        let checkTask = UIImage(named: "checkTask")
        let uncheckTask = UIImage(named: "uncheckTask")
        
        // Выберает из статуса выполнен/не выполнен
        if curTask["isComplited"] as! Bool == true{
            cell.imageView?.image = checkTask
        } else {
            //cell.accessoryType = .none
            cell.imageView?.image = uncheckTask
        }
        
        // проверка устаревшая ли дата и изменяем цвет даты на красный
        //** orderedDescending - устаревшая
        //** orderedSame - равна текущей
        //** orderedAscending - в будущем
        if Date().compare(curTask["DeadDate"] as! Date) == .orderedDescending {
            cell.detailTextLabel?.textColor = UIColor.red
        }
        
        return cell
    }
    
    // Определяет нажатие на строку в таблице
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Убирает выделение после нажатия плавно с анимацией
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Ссылки на изображения
        let checkTask = UIImage(named: "checkTask")
        let uncheckTask = UIImage(named: "uncheckTask")
        
        // При нажатии менять иконку выполнен/не выполнен
        if changeState(at: indexPath.row) {
            tableView.cellForRow(at: indexPath)?.imageView?.image = checkTask
        } else {
            tableView.cellForRow(at: indexPath)?.imageView?.image = uncheckTask
        }
        
    }
 
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    // Удаление Task с стилем потянуть с права на лево
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            removeItem(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert{
            
        }
    }
}
