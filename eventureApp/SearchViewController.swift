//
//  SearchViewController.swift
//  eventureApp
//
//  Created by Marco Roveto on 11/2/16.
//  Copyright © 2016 eventure-app. All rights reserved.
//

import UIKit
import FirebaseDatabase

class SearchViewController: UITableViewController {
    
    //THERE ARE IMPORTANT FUNCTIONS AT THE BOTTOM!
    
    @IBOutlet var eventsTableView: UITableView!
    
    //Creates the search bar object
    //Can fill "nil" in with a seperate viewcontroller if wanted.
    var searchController: UISearchController!
    
    
    //These arrays are were the firebase objects are stored for viewing/searching
    //var eventsArray = [NSDictionary?]()
    //var filteredEvents = [NSDictionary?]()
    
    var eventsArray = [Event]()
    var filteredEvents = [Event]()
    
    var ref = FIRDatabase.database().reference()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        searchController.searchBar.delegate = self
        searchController.searchBar.autoresizingMask = UIViewAutoresizing.flexibleWidth
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.sizeToFit()
        
        //This querys the firebase database for all events ordered by Title
        ref.child("Events").queryOrdered(byChild: "title").observe(.childAdded, with: {(snapshot) in
            
            //Inserts each firebase object into an array so we can access them locally
            //self.eventsArray.append(snapshot.value as? NSDictionary)
            let event = Event(eventKey: snapshot.key, snapshot: snapshot.value as! Dictionary<String, AnyObject>)
            self.eventsArray.append(event)
            self.tableView.reloadData()
            //insert the rows
            //self.eventsTableView.insertRows(at: [IndexPath(row:self.eventsArray.count-1, section:0)], with: UITableViewRowAnimation.automatic)
            
            
        }) { (error) in
            
            print(error.localizedDescription)
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    //This is the function that actually does the string comparison for the
    //user entered text and the events text.
    func filterContent(searchText: String) {
        
        self.filteredEvents = self.eventsArray.filter({ (event) -> Bool in
            return event.title_text.lowercased().contains(searchText.lowercased())
        })
        
        //        self.filteredEvents = self.eventsArray.filter{ (event) -> Bool in
        //            //let eventTitle = event["title"] as? String
        //            //return(event.eventTitle?.lowercased().contains(searchText.lowercased()))!
        //        }
        tableView.reloadData()
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
        } else {
            return self.eventsArray.count
            
        }
        
        //When user hasnt typed anything show all events. (May want to change this is future)
    }
    
    //Creates the table view and creates a row for each object in the events array
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! SearchCell
        let event: Event!
        if searchController.isActive && searchController.searchBar.text != "" {
            event = filteredEvents[indexPath.row]
            cell.configureCell(event: event)
            return cell
        } else {
            // not typing
            event = eventsArray[indexPath.row]
            cell.configureCell(event: event)
            return cell
        }
    }
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "eventSegue" {
            if tableView.indexPathForSelectedRow != nil {
                if searchController.isActive == true && searchController.searchBar.text != "" {
                    let cell = sender as! SearchCell
                    let indexPath = self.tableView.indexPath(for: cell)
                    var event: Event
                    let eventsProfileViewController = (segue.destination as! EventsProfileViewController)
                    event = filteredEvents[indexPath!.item]
                    eventsProfileViewController.eventId = event.event_id
                } else {
                    let cell = sender as! SearchCell
                    let indexPath = self.tableView.indexPath(for: cell)
                    var event: Event
                    let eventsProfileViewController = (segue.destination as! EventsProfileViewController)
                    event = eventsArray[indexPath!.item]
                    eventsProfileViewController.eventId = event.event_id
                }
            }
        }
    }
    
    
    //Just a simple cancel button so the user can get out of the search viewcontroller
    @IBAction func cancelSearch(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
}

extension SearchViewController: UISearchResultsUpdating {
    //Calls the function below (filterContent) to keep updating the table with
    //newly filtered content.
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        //let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContent(searchText: searchBar.text!)
        //updateSearchResults(for: searchController)
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            self.searchController.searchResultsController?.view.isHidden = false
        }
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchController.searchResultsController?.view.isHidden = false
    }
}

extension SearchViewController: UISearchControllerDelegate {
    func willPresentSearchController(_ searchController: UISearchController) {
        searchController.searchResultsController?.view.isHidden = false
        self.tableView.reloadData()
    }
    func didPresentSearchController(_ searchController: UISearchController) {
        searchController.searchResultsController?.view.isHidden = false
    }
}
