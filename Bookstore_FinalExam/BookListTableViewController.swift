//
//  BookListTableViewController.swift
//  Bookstore_FinalExam
//
//  Created by Chiu Chih-Che on 2016/10/7.
//  Copyright © 2016年 Jeff. All rights reserved.
//

import UIKit
import FirebaseDatabase
import SDWebImage

class BookListTableViewController: UITableViewController {

    //var booksArray: [Book] = []
    var refreshingControl: UIRefreshControl!
    var rootRef: FIRDatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        rootRef = FIRDatabase.database().reference()
        
        setRefreshFunction()
        
        fetchFirebaseData()
    }
    
    override func viewDidAppear(animated: Bool) {
        //fetchFirebaseData()
    }

    //Fetch data from firebase
    func fetchFirebaseData() {
        Book.bookArray.removeAll()
        let booksRef = rootRef!.child("Books")
        booksRef.queryOrderedByChild("Created_Time")
        booksRef.observeEventType(.ChildAdded, withBlock: {
            snapshot in
            let id = snapshot.key //取得id
            let name = snapshot.value?.objectForKey("Name") as! String
            let photo = snapshot.value?.objectForKey("Photo") as! String
            let address = snapshot.value?.objectForKey("Address") as! String
            let tel = snapshot.value?.objectForKey("Tel") as! String
            let url = snapshot.value?.objectForKey("Url") as! String
            let info = snapshot.value?.objectForKey("Info") as! String
            let createdTime = snapshot.value?.objectForKey("Created_Time") as! String
            Book.bookArray.append(Book(id: id,name: name, photo: photo, address: address, tel: tel, url: url, info: info, createdTime: createdTime))
            
            self.tableView.reloadData()
            self.refreshingControl.endRefreshing()
        })
    }
    
    //刪除DB資料
    func deleteFirebaseData(id: String) {
        let bookRef = self.rootRef!.child("Books")
        let delDataRef = bookRef.child(id)
        delDataRef.removeValue()
        
    }

    //Pull to refresh data
    func setRefreshFunction() {
        refreshingControl = UIRefreshControl()
        refreshingControl.attributedTitle = NSAttributedString(string: "Refresh Data")
        refreshingControl.addTarget(self, action: #selector(BookListTableViewController.fetchFirebaseData), forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshingControl)
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Book.bookArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let book = Book.bookArray[indexPath.row]
        return getBookCellWithTableView(tableView, indexPath: indexPath, book: book)
    }
    
    func getBookCellWithTableView(tableView: UITableView, indexPath: NSIndexPath, book: Book) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! BookTableViewCell
        cell.imageView?.sd_setImageWithURL(NSURL(string: book.photo))
        cell.nameLabel.text = book.name
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowBookDetailSegue" {
            let vc = segue.destinationViewController as! BookDetailViewController
            vc.book = Book.bookArray[((tableView.indexPathForSelectedRow as NSIndexPath?)?.row)!]
        }
    }
    
    //滑動刪除項目
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == .Delete) {
            
            //刪除DB上資料
            let id = Book.bookArray[indexPath.row].id
            deleteFirebaseData(id)
            
            //陣列刪除資料
            Book.bookArray.removeAtIndex(indexPath.row)
        }
        tableView.reloadData()
    }

    @IBAction func addBook(sender: AnyObject) {
        let vc =  storyboard!.instantiateViewControllerWithIdentifier("AddBook") as! BookAddTableViewController
        self.presentViewController(vc, animated: true, completion: nil)
    }
}
