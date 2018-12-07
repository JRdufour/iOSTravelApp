//
//  AgendaDetailViewController.swift
//  TravelApp
//
//  Created by jonathan Dufour on 2018-12-01.
//  Copyright © 2018 ca.stclairconnect.JonathanDufour. All rights reserved.
//

import UIKit
import CoreData

class AgendaDetailViewController: ViewControllerSwipeDismissable {

    var agendaItem: AgendaItem?
    var dest: Destination!
    var moc: NSManagedObjectContext!
    
    @IBOutlet var nameTextField: UITextField!
    
    @IBOutlet var notesTextField: UITextView!
    @IBOutlet var notes: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notes.layer.cornerRadius = 5.0
        if let item = agendaItem{
            nameTextField.text = item.title
            notesTextField.text = agendaItem?.notes
        }

        // Do any additional setup after loading the view.
    }
    

    @IBAction func UpdateAgendaItem(_ sender: Any) {
        var save = false
        if agendaItem == nil{
            print("SUCCESS")
            agendaItem = AgendaItem(context: moc)
        }
        if let name = nameTextField.text, !name.isEmpty{
            agendaItem?.title = name
            save = true
        }
        if let notes = notesTextField.text, !notes.isEmpty{
            agendaItem?.notes = notes
        }
        agendaItem?.destination = dest
        if save{
            do{
                try moc.save()
            }catch {
                
        }
        }
        self.dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

