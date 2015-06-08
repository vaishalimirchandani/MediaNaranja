//
//  RacesTableViewController.swift
//  Pokedex
//
//  Created by Santiago Pavón on 1/12/14.
//  Copyright (c) 2014 UPM. All rights reserved.
//

import UIKit

class RacesTableViewController: UITableViewController {

    lazy var pokedexModel = PokedexModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            self.clearsSelectionOnViewWillAppear = false
            self.preferredContentSize = CGSize(width: 320.0, height: 600.0)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return pokedexModel.types.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let type = pokedexModel.types[section]
        return type.races.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Race Cell", forIndexPath: indexPath) as! UITableViewCell
        
        let type = pokedexModel.types[indexPath.section]
        let race = type.races[indexPath.row]
        
        cell.imageView?.image = UIImage(named: race.icon)
        cell.textLabel?.text = race.name
        cell.detailTextLabel?.text = race.code
        
        return cell
    }

    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return pokedexModel.types[section].name
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "Show Web Info" {
            
            // El destino del segue es el Navigation Controller.
            // El primer VC apuntado por el Navigation Controller el WebVC.
            let wvc = (segue.destinationViewController as! UINavigationController).topViewController as! WebViewController
            
            // sender es la celda de la tabla que disparo el segue.
            if let ip = tableView.indexPathForCell(sender! as! UITableViewCell) {
                
                let type = pokedexModel.types[ip.section]
                
                wvc.race = type.races[ip.row]
                
                wvc.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                wvc.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

}
