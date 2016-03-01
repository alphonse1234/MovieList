//
//  titlelogo.swift
//  MyMovieList
//
//  Created by 장창순 on 2016. 2. 20..
//  Copyright © 2016년 All rights reserved.
//

import UIKit

extension UIViewController {
    
    func setLogo() {
        let logo = UIImage(named: "logo.png")
        
        let imageView = UIImageView(image:logo)
        imageView.layer.bounds = CGRect(x: 0, y: 0, width: 145, height: 25)
        imageView.contentMode = .ScaleAspectFit
        
        self.navigationItem.titleView = imageView
    }
}