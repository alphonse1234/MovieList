//
//  MovieCell.swift
//  Favorite Movie
//
//  Created by 장창순 on 2016. 2. 18..
//  Copyright © 2016년 Swiftbook. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {
    
    @IBOutlet var movieTitle: UILabel!
    @IBOutlet var movieGenre: UILabel!
    @IBOutlet var movieImg: UIImageView!
    @IBOutlet var imdbImg: UIButton!
    private var _movie: Movie!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    
    }

    
    
//    override var frame: CGRect {
//        get {
//            return super.frame
//        } set(newFrame) {
//            var frame = newFrame
////            frame.origin.x += 4
////            frame.size.width -= 2 * 4
//            frame.origin.y += 4
//            frame.size.height -= 2 * 2
//            super.frame = frame
//        }
//    }

    func configureCell(movie: Movie) {
        movieTitle.text = movie.title
        movieGenre.text = movie.genre
        movieImg.image = movie.getMovieImg()
        _movie = movie
        
        if _movie.url == "" {
            imdbImg.hidden = true
        } else {
            imdbImg.hidden = false
        }

    }
    
    @IBAction func imdbTapped(sender: UIButton!) {
        NSNotificationCenter.defaultCenter().postNotificationName("imdbTapped", object: nil, userInfo: ["movie": _movie])
     
    }
    

}
