//
//  EditCell.swift
//  MyMovieList
//
//  Created by 장창순 on 2016. 2. 20..
//  Copyright © 2016년 Swiftbook. All rights reserved.
//

import UIKit
import CoreData

class EditCell: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var movieTitle: UITextField!
    @IBOutlet var movieGenre: UITextField!
    @IBOutlet var movieURL: UITextField!
    @IBOutlet var movieImg: UIImageView!
    @IBOutlet var addMovieBtn: UIButton!
    @IBOutlet var addImageBtn: UIButton!
    
    var movie: Movie!
    
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLogo()
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        movieImg.layer.cornerRadius = movieImg.frame.size.width / 2
        movieImg.clipsToBounds = true
        
        movieTitle.text = movie.title
        movieGenre.text = movie.genre
        movieURL.text = movie.url
        movieImg.image = UIImage(data: movie.image!)
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        movieImg.image = image
        addImageBtn.hidden = true
        
    }
    
    @IBAction func editImage(sender: AnyObject!) {
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    

    @IBAction func EditBtnPressed(sender: AnyObject!) {
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = app.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Movie")
        
        do {
            try context.executeFetchRequest(fetchRequest)
            movie.title = movieTitle.text
            movie.genre = movieGenre.text
            movie.url = movieURL.text
            movie.setMovieImage(movieImg.image!)
            
            do{
                try context.save()
            } catch {
                print("Could not edit movie")
            }
            
        } catch let err as NSError {
            print(err.debugDescription)
        }

            self.navigationController?.popViewControllerAnimated(true)
    }
}
