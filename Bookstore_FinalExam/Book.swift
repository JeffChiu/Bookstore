//
//  Book.swift
//  Bookstore_FinalExam
//
//  Created by Chiu Chih-Che on 2016/10/7.
//  Copyright © 2016年 Jeff. All rights reserved.
//

import Foundation

class Book {
    var id: String = ""
    var name: String = ""
    var photo: String = ""
    var address: String = ""
    var tel: String = ""
    var url: String = ""
    var info: String = ""
    var createdTime: String = ""
    
    static var bookArray: [Book] = []
    
    init () {}
    
    init (id: String, name: String, photo: String, address: String, tel: String, url: String, info: String, createdTime: String) {
        self.id = id 
        self.name = name
        self.photo = photo
        self.address = address
        self.tel = tel
        self.url = url
        self.info = info
        self.createdTime = createdTime
    }
    
    init (name: String, photo: String, address: String, tel: String, url: String, info: String, createdTime: String) {
        self.name = name
        self.photo = photo
        self.address = address
        self.tel = tel
        self.url = url
        self.info = info
        self.createdTime = createdTime
    }
    
    //For Firebase Insert Data
    func convertObjectToDictionary() -> [String : String] {
        return  [
            "Name" : name,
            "Photo" : photo,
            "Address" : address,
            "Tel" : tel,
            "Url" : url,
            "Created_Time" : createdTime,
            "Info" : info
        ]
    }
}