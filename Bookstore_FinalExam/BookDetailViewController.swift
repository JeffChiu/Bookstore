//
//  BookDetailViewController.swift
//  Bookstore_FinalExam
//
//  Created by Chiu Chih-Che on 2016/10/7.
//  Copyright © 2016年 Jeff. All rights reserved.
//

import UIKit
import SDWebImage

class BookDetailViewController: UIViewController {

    var book: Book?
    var isTapPhotoImageView: Bool = false
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    //@IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var telButton: UIButton!
    //@IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var infoTextView: UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoImageView.sd_setImageWithURL(NSURL(string: (book?.photo)!))
        nameLabel.text = book?.name
        //addressLabel.text = book?.address
        //telButton = book?.tel
        //urlLabel.text = book?.url
        infoTextView.text = book?.info
        // Do any additional setup after loading the view.
        
        //上課範例是用UIView，但UIImageView必須要將user interaction啟用
        photoImageView.userInteractionEnabled = true
        //以程式生成tap gesture，賦予imageView在tap後的動作
        let tapImage = UITapGestureRecognizer(target: self, action: #selector(BookDetailViewController.tapImage))
        photoImageView!.addGestureRecognizer(tapImage)
    }

    //動畫效果 - 放大縮小 + 移動位置
    func tapImage() {
        /*
        UIView.animateWithDuration(0.5) {
            self.isTapPhotoImageView = !self.isTapPhotoImageView
            if self.isTapPhotoImageView == true {
                self.photoImageView.transform =  CGAffineTransformMakeScale(1.5, 1.5)
            } else {
                self.photoImageView.transform =  CGAffineTransformMakeScale(1, 1)
            }
        }
        */
        
        UIView.animateKeyframesWithDuration(1, delay: 0, options: .CalculationModeLinear, animations: {
            UIView.addKeyframeWithRelativeStartTime(0, relativeDuration: 0.5, animations: {
                self.isTapPhotoImageView = !self.isTapPhotoImageView
                if self.isTapPhotoImageView == true {
                    self.photoImageView.transform =  CGAffineTransformMakeScale(1.5, 1.5) //放大
                    self.photoImageView.frame = CGRectOffset(self.photoImageView.frame, 0, 100) //垂直移動
                } else {
                    self.photoImageView.transform =  CGAffineTransformMakeScale(1, 1) //縮回原本比例
                    self.photoImageView.frame = CGRectOffset(self.photoImageView.frame, 0, -100)  //移回原來位置
                }
            })
        }, completion: nil)
    }
    
    @IBAction func callBookstore(sender: UIButton) {
        let _ = UIApplication.sharedApplication().openURL(NSURL(string: "tel://\(book!.tel)")!)
    }
    
    
    @IBAction func openWeb(sender: AnyObject) {
        let _ = UIApplication.sharedApplication().openURL(NSURL(string: "\(book!.url)")!)
    }
    
    @IBAction func showLocation(sender: AnyObject) {
        let vc =  storyboard!.instantiateViewControllerWithIdentifier("MapView") as! MapViewController
        vc.address = book?.address
        self.presentViewController(vc, animated: true, completion: nil)
        
    }
    
    

    

}
