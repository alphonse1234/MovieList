//
//  ViewController.swift
//  Favorite Movie
//
//  Created by 장창순 on 2016. 2. 18..
//  Copyright © 2016년 All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {

    @IBOutlet var tableView: UITableView!
    var movies = [Movie]()
 
    override func viewDidLoad() {
        super.viewDidLoad()
            setLogo()
            tableView.delegate = self
            tableView.dataSource = self
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "openWebView:", name: "imdbTapped", object: nil)
        
       
    }

    override func viewWillAppear(animated: Bool) {
        fetchAndSetResults()
        tableView.reloadData()
    }

    func fetchAndSetResults() {
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = app.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Movie")
        
        do {
            let results = try context.executeFetchRequest(fetchRequest)
            self.movies = results as! [Movie]
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = app.managedObjectContext
        let item = movies[indexPath.row]
        
        let Edit = UITableViewRowAction(style: .Normal, title: "Edit") { action, index in
            var movie: Movie!
            movie = self.movies[indexPath.row]
            self.performSegueWithIdentifier("EditCell", sender: movie)
        }
        Edit.backgroundColor = UIColor.lightGrayColor()
        
        let Delete = UITableViewRowAction(style: .Normal, title: "Delete") { action, index in
           
            context.deleteObject(item)
            
            do {
                try context.save()
            } catch {
                print("Could not delete cell")
            }
            
            self.fetchAndSetResults()
            self.tableView.reloadData()
            

        }
        
        Delete.backgroundColor = UIColor.darkGrayColor()
        return [Delete, Edit]
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCellWithIdentifier("MovieCell") as? MovieCell {
            let movie = movies[indexPath.row]
            cell.configureCell(movie)
            return cell
        } else {
            return MovieCell()
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func openWebView(notif: NSNotification) {
        
        guard let info = notif.userInfo as? Dictionary <String, Movie>, let movie = info["movie"] else {
            print("No movie provided")
            return
        }
        performSegueWithIdentifier("IMDBVC", sender: movie)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "IMDBVC" {
            if let imdbVC = segue.destinationViewController as? IMDBVC {
                if let movie = sender as? Movie {
                    imdbVC.movie = movie
                }
            }
        } else if segue.identifier == "EditCell" {
            if let editCell = segue.destinationViewController as? EditCell {
                if let movie = sender as? Movie {
                    editCell.movie = movie
                }
            }
        }
    }
}

