//
//  SearchViewController.swift
//  eventureApp
//
//  Created by Marco Roveto on 11/2/16.
//  Copyright © 2016 eventure-app. All rights reserved.
//

import UIKit
import FirebaseDatabase

class SearchViewController: UITableViewController, UISearchResultsUpdating {
    
    //THERE ARE IMPORTANT FUNCTIONS AT THE BOTTOM!

    @IBOutlet var eventsTableView: UITableView!
    
     //Creates the search bar object
     //Can fill "nil" in with a seperate viewcontroller if wanted.
    let searchController = UISearchController(searchResultsController: nil)
   
    //These arrays are were the firebase objects are stored for viewing/searching
    var eventsArray = [NSDictionary?]()
    var filteredEvents = [NSDictionary?]()
    
    var ref = FIRDatabase.database().reference()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
        //This querys the firebase database for all events ordered by Title
        ref.child("Events").queryOrdered(byChild: "title").observe(.childAdded, with: {(snapshot) in
        
            //Inserts each firebase object into an array so we can access them locally
            self.eventsArray.append(snapshot.value as? NSDictionary)
            
            //insert the rows
            self.eventsTableView.insertRows(at: [IndexPath(row:self.eventsArray.count-1, section:0)], with: UITableViewRowAnimation.automatic)
            
            
        }) { (error) in
            
            print(error.localizedDescription)
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        //This allows the search bar to refresh the results instantly
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredEvents.count
        }
        
        //When user hasnt typed anything show all events. (May want to change this is future)
        return self.eventsArray.count
    }

    //Creates the table view and creates a row for each object in the events array
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let event: NSDictionary?

        if searchController.isActive && searchController.searchBar.text != "" {
            
            event = filteredEvents[indexPath.row]
        } else {
            
            event = eventsArray[indexPath.row]
        }
        cell.textLabel?.text = event?["title"] as? String
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //Just a simple cancel button so the user can get out of the search viewcontroller
    @IBAction func cancelSearch(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    //Calls the function below (filterContent) to keep updating the table with 
    //newly filtered content.
    func updateSearchResults(for searchController: UISearchController) {
        //update the search results
        filterContent(searchText: self.searchController.searchBar.text!)
    }
    
    //This is the function that actually does the string comparison for the 
    //user entered text and the events text.
    func filterContent(searchText: String) {
        self.filteredEvents = self.eventsArray.filter{ event in
            
            let eventTitle = event!["title"] as? String
            
            return(eventTitle?.lowercased().contains(searchText.lowercased()))!
        }
        
        tableView.reloadData()
    }
    
    

}
