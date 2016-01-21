//
//  ScrollViewController.swift
//  TopMovies
//
//  Created by Genie Guo on 1/19/16.
//  Copyright © 2016 GA Student. All rights reserved.
//

import UIKit

class ScrollViewController: UIViewController, UIScrollViewDelegate {

    
    var spaceImage: UIImage?
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let spaceImageView = UIImageView(image: spaceImage)
        spaceImageView.frame = self.view.frame
        spaceImageView.contentMode = UIViewContentMode.ScaleToFill
        
        self.scrollView.addSubview(spaceImageView)
        self.scrollView.contentSize = self.view.frame.size
        self.scrollView.delegate = self
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView?{
        return scrollView.subviews.first
    } // return a view that will be scaled. if delegate returns nil, nothing happens
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
