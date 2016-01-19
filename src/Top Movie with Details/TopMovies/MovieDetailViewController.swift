//
//  MovieDetailViewController.swift
//  TopMovies
//
//  Created by Genie Guo on 1/18/16.
//  Copyright © 2016 GA Student. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var titleString: String?
    var directorString: String?
    var descriptionString: String?
    var moviePosterURL: NSURL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  self.posterImageView.text = moviePosterURL
        self.titleLabel.text = titleString
        self.directorLabel.text = directorString
        self.descriptionLabel.text = descriptionString
        
        // Do any additional setup after loading the view.
    }
    

 
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
