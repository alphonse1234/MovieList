//
//  AddMovieVC.swift
//  Favorite Movie
//
//  Created by 장창순 on 2016. 2. 18..
//  Copyright © 2016년 All rights reserved.
//

import UIKit
import CoreData

class AddMovieVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var movieTitle: UITextField!
    @IBOutlet var movieGenre: UITextField!
    @IBOutlet var movieURL: UITextField!
    @IBOutlet var movieImg: UIImageView!
    @IBOutlet var addMovieBtn: UIButton!
    @IBOutlet var addImageBtn: UIButton!
    
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        movieImg.layer.cornerRadius = movieImg.frame.size.width / 2
        movieImg.clipsToBounds = true

    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        movieImg.image = image
        addImageBtn.hidden = true
        
    }
    
    @IBAction func addImage(sender: AnyObject!) {
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func addMovieBtnPressed(sender: AnyObject!) {
        if let title = movieTitle.text where title != "" {
            let app = UIApplication.sharedApplication().delegate as! AppDelegate
            let context = app.managedObjectContext
            let entity = NSEntityDescription.entityForName("Movie", inManagedObjectContext: context)!
            let movie = Movie(entity: entity, insertIntoManagedObjectContext: context)
            movie.title = title
            movie.genre = movieGenre.text
            movie.url = movieURL.text
            movie.setMovieImage(movieImg.image!)
            
            context.insertObject(movie)
            
            do{
                try context.save()
            } catch {
                print("Could not save movie")
            }
            
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    

}
