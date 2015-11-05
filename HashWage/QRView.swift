//
//  ViewController.swift
//  HashWage
//
//  Created by Nathan Mueller on 11/4/15.
//  Copyright © 2015 HashWage. All rights reserved.
//

import UIKit



class QRView: UIViewController {
    
    var imageUrl :UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        imageUrl = UIImageView(frame:CGRectMake(0, 0, 400, 700))
        imageUrl.image = UIImage(named:"qr code")
        
        self.view.addSubview(imageUrl)
        self.view.sendSubviewToBack(imageUrl)
        
        
        if let checkedUrl = NSURL(string: "https://chart.googleapis.com/chart?chs=100x100&cht=qr&chl=1A5iCBMXPJF7esUssyaaeLpTocoyW2EK6n") {
            imageUrl.contentMode = .ScaleAspectFit
            downloadImage(checkedUrl)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that canbe recreated.
        
    }
    
    func downloadImage(url: NSURL){
        print("Started downloading \"\(url.URLByDeletingPathExtension!.lastPathComponent!)\".")
        getDataFromUrl(url) { (data, response, error)  in
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                guard let data = data where error == nil else { return }
                print("Finished downloading \"\(url.URLByDeletingPathExtension!.lastPathComponent!)\".")
                self.imageUrl.image = UIImage(data: data)
            }
        }
    }
    
    
    func getDataFromUrl(url:NSURL, completion: ((data: NSData?, response: NSURLResponse?, error: NSError? ) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            completion(data: data, response: response, error: error)
            }.resume()
    }
    
}

