//
//  AddTaskController.swift
//  HsMemo
//
//  Created by Максим Козлов on 20/10/2018.
//  Copyright © 2018 Максим Козлов. All rights reserved.
//

import UIKit

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
    
    // Обработка действий при нажатии кнопки SaveTask
    @IBAction func SaveTask(_ sender: UIButton) {
        // Вызов функции добавление Task и последующее занесени в таблицу и сохранение
        addTask(title: TitleTaskField.text!, deadDate: DeadlineTaskDate.date)
        // Выход из View TaskList к списку Tasks
        let _ = self.navigationController?.popToRootViewController(animated: true) // return to list view
    }


}
