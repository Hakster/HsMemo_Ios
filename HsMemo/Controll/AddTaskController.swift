//
//  AddTaskController.swift
//  HsMemo
//
//  Created by Максим Козлов on 20/10/2018.
//  Copyright © 2018 Максим Козлов. All rights reserved.
//
import UIKit
import UserNotifications

class AddTaskController: UIViewController {
    
    @IBOutlet weak var TitleTaskLabel: UILabel!
    @IBOutlet weak var TitleTaskField: UITextField!
    @IBOutlet weak var DeadlineTaskDate: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // Метод прячет клавиатуру при нажатии вне поля Field
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func saveTask(_ sender: UIBarButtonItem) {
        // Вызов функции добавление Task и последующее занесени в таблицу и сохранение
        addTask(title: TitleTaskField.text!, deadDate: DeadlineTaskDate.date)
        // добавление уведомления в центр
        // Но в начале на всякий случай удалим старое если есть (Так скажем обновим)
        removeNotifications(withIdentifiers: [TitleTaskField.text!])
        scheduleNotification(indetifiers: TitleTaskField.text!, title: TitleTaskField.text!, deadDate: DeadlineTaskDate.date) { (success) in
            if (success){
                print("GOOOD")
            }
        }
        // Выход из View TaskList к списку Tasks
        let _ = self.navigationController?.popToRootViewController(animated: true) // return to list view
    }
    
//    deinit {
//        removeNotifications(withIdentifiers: [TitleTaskField.text!])
//    }
    
}
