//
//  NewKnottTVC.swift
//  ForgetMeKnot
//
//  Created by Rubens Gondek on 11/17/15.
//  Copyright © 2015 Knot. All rights reserved.
//

import UIKit

class NewKnottTVC: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtUUID: UITextField!
    
    let kManager = KnottManager.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

    }
    
    @IBAction func saveBtn(sender: AnyObject) {
        save()
    }
    
    func save() {
        if (txtName.text != "" && txtUUID.text != "") {
            kManager.saveNewKnott(txtName.text!, uuid: txtUUID.text!, on: false, fav: false)
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
    // MARK: Text Field
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField.tag == 0 {
            txtUUID.becomeFirstResponder()
        }
        else {
            save()
        }
        return true
    }

}
