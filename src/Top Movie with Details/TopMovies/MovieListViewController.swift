//
//  MovieListViewController.swift
//  TopMovies
//
//  Created by Genie Guo on 1/18/16.
//  Copyright © 2016 GA Student. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var movieListTableView: UITableView!
    
    var movies: [NSDictionary]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.movieListTableView.delegate = self
        self.movieListTableView.dataSource = self
        
        self.title = "🔝🎞"
        
        let itunesURL = NSURL(string: "https://itunes.apple.com/us/rss/topmovies/limit=100/json")!
        NSURLSession.sharedSession().dataTaskWithRequest(NSURLRequest(URL: itunesURL)) { (data, response, error) in
            dispatch_async(dispatch_get_main_queue()) {
                let json = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
                let moviesArray = json.valueForKeyPath("feed.entry") as? [NSDictionary]
                self.movies = moviesArray
               print("Yay! The Movies Downloaded! 🎉")
                self.movieListTableView.reloadData() //reload data after download movie info
                
                
            }
            }.resume()
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        let movieCell = cell as! MovieTableViewCell
        
        let titleString = self.titleStringForMovieAtIndex(indexPath.row)
        let directorString = self.directorStringForMovieAtIndex(indexPath.row)
        let summaryString = self.summaryStringForMovieAtIndex(indexPath.row)
        
        movieCell.titleLabel.text = titleString  /*? if this variable is nil, skip this line*/
        movieCell.directorLabel.text = directorString
        movieCell.descriptionLabel.text = summaryString
        
        let posterImageURL = self.posterImageURLForMovieAtIndex(indexPath.row)
        movieCell.posterImageView?.setImageWithURL(posterImageURL)
        print ("willDisplayCell \(indexPath.row)")
        
        
    
    }


    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print ("numberOfRowsInSection")
        return self.movies?.count ?? 0 // ?? : if this is Nill, set the value to "0" . Default to 0
    }
  
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MovieCell", forIndexPath: indexPath)
        if let movieCell = cell as? MovieTableViewCell {
            movieCell.posterImageView.image = nil
        }
        print ("cellForRowAtIndexPath \(indexPath.row)")
        
        return cell
    
    }
    
    func titleStringForMovieAtIndex(index: Int) -> String? {
        let movie = self.movies?[index]
        let title = movie?.valueForKeyPath("im:name.label") as? String
        return title
    }
    
    func directorStringForMovieAtIndex(index: Int) -> String? {
        let movie = self.movies?[index]
        let director = movie?.valueForKeyPath("im:artist.label") as? String
        return director
    }
    
    func summaryStringForMovieAtIndex(index: Int) -> String? {
        let movie = self.movies?[index]
        let summary = movie?.valueForKeyPath("summary.label") as? String
        return summary
    }
    
    func posterImageURLForMovieAtIndex(index: Int) -> NSURL {
        let movie = self.movies?[index]
        let posterImageURLArray = movie?.valueForKeyPath("im:image.label") as? [String]
        let posterImageURLString = posterImageURLArray?.last
        let posterImageURL = NSURL(string: posterImageURLString!)!
        return posterImageURL
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
  
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        let path = self.movieListTableView.indexPathForSelectedRow!
        let destinationViewController = segue.destinationViewController as! MovieDetailViewController
       
        
        destinationViewController.titleString = self.titleStringForMovieAtIndex(path.row)
        destinationViewController.directorString = self.directorStringForMovieAtIndex(path.row)
        destinationViewController.descriptionString = self.summaryStringForMovieAtIndex(path.row)
        destinationViewController.moviePosterURL = self.posterImageURLForMovieAtIndex(path.row)

        
        // Pass the selected object to the new view controller.
    }


}
