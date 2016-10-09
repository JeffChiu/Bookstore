//
//  BookAddTableViewControlle.swift
//  Bookstore_FinalExam
//
//  Created by Chiu Chih-Che on 2016/10/9.
//  Copyright © 2016年 Jeff. All rights reserved.
//

import UIKit
import FirebaseDatabase

class BookAddTableViewController: UITableViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var photoUrl: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var tel: UITextField!
    @IBOutlet weak var url: UITextField!
    @IBOutlet weak var info: UITextView!
    
    var rootRef: FIRDatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rootRef = FIRDatabase.database().reference()
        
        info.layer.borderWidth = 0.5
        info.layer.borderColor = UIColor.grayColor().CGColor
        
        //dismiss the Keyboard by tapping anywhere on the screen without using touchesBegan
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    func hideKeyboard() {
        view.endEditing(true)
    }
    
    //Done 新增書籍
    @IBAction func addBookFinish(sender: AnyObject) {
        let book = Book(name: "a", photo: "http://123.com", address: "桃園中壢", tel: "0918979743", url: "http://123.com.tw", info: "好書好書", createdTime: currentTime())
        //新增DB資料
        insertFirebaseData(book)
        
        //陣列新增資料
        Book.bookArray.append(book)
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //Cancel 新增取消
    @IBAction func cancelButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func currentTime() -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.stringFromDate(NSDate())
    }
    
    func insertFirebaseData(obj: Book) {
        let bookRef = rootRef!.child("Books")
        let newBookRef = bookRef.childByAutoId()
        print(newBookRef.key)
        newBookRef.setValue(obj.convertObjectToDictionary())
    }

}


//name.delegate = self
//photoUrl.delegate = self
//address.delegate = self
//tel.delegate = self
//url.delegate = self
//extension BookAddTableViewController: UITextFieldDelegate {
//    func textFieldDidEndEditing(textField: UITextField) {
//        for textField in self.view.subviews where textField is UITextField {
//            textField.resignFirstResponder()
//        }
//    }
//    func textFieldShouldReturn(textField: UITextField) -> Bool {
//        for textField in self.view.subviews where textField is UITextField {
//            textField.resignFirstResponder()
//        }
//        return true
//    }
//}
