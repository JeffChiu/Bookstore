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
        
        //UI
        info.layer.borderWidth = 0.5
        info.layer.borderColor = UIColor.grayColor().CGColor
        tableView.headerViewForSection(1)
        
        rootRef = FIRDatabase.database().reference()
        
        //dismiss the Keyboard by tapping anywhere on the screen without using touchesBegan
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        
    }
    
    func hideKeyboard() {
        view.endEditing(true)
    }
    
    //範例
    @IBAction func addExample(sender: AnyObject) {
        name.text = "酒的科學：從發酵、蒸餾、熟陳至品酩的醉人之旅"
        photoUrl.text = "http://im2.book.com.tw/image/getImage?i=http://www.books.com.tw/img/001/073/02/0010730298.jpg&v=57ed094d&w=170&h=170"
        address.text = "台北市松山區光復北路11巷33號"
        tel.text = "0227611032"
        url.text = "http://www.books.com.tw/products/0010730298?loc=P_014_0_101"
        info.text = "不論你啜飲的是清酒、精釀啤酒、單一麥芽威士忌，或卡本內蘇維濃葡萄酒，當你真正了解杯中魔液的來龍去脈，飲酒將變得更饒富趣味！有泡沬的啤酒喝起來更香醇可口？為什麼香檳的氣泡比啤酒的更快消失？味覺敏感的人比較不愛喝兩杯？亞洲人喝酒為何特別容易臉紅？人們真能從酒中嘗出數十種風味？酒評師為何能夠說出精湛絕妙的神級酒評？台灣噶瑪蘭威士忌奪得世界冠軍的關鍵為何？"
    }
    
    //Done 新增書籍
    @IBAction func addBookFinish(sender: AnyObject) {
        let book = Book(name: name.text!, photo: photoUrl.text!, address: address.text!, tel: tel.text!, url: url.text!, info: info.text!, createdTime: currentTime())
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
