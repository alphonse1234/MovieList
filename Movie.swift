//
//  Movie.swift
//  MyMovieList
//
//  Created by 장창순 on 2016. 2. 18..
//  Copyright © 2016년 All rights reserved.
//

import Foundation
import CoreData
import UIKit


class Movie: NSManagedObject {

    func setMovieImage(img: UIImage) {
        let data = UIImagePNGRepresentation(img)
        self.image = data
    }
    
    func getMovieImg() -> UIImage {
        let img = UIImage(data: self.image!)!
        return img
    }


}
