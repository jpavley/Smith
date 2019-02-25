//
//  ViewController.swift
//  Smith
//
//  Created by John Pavley on 2/15/19.
//  Copyright © 2019 John Pavley. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    let model = Cloud.sampleData()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        navigationController?.navigationBar.prefersLargeTitles = true

    }
}

extension ViewController {
    
    // MARK:- Helpers
    
    fileprivate func sectionData(for section: Int) -> [Cloud]? {
        if let altitude = CloudAltitude(rawValue: section) {
            return model.filter {$0.altitudeRange.contains(altitude)}
        } else {
            return nil
        }
    }
    
    fileprivate func rowData(for indexPath: IndexPath) -> Cloud? {
        if let cloudData = sectionData(for: indexPath.section) {
            return cloudData[indexPath.row]
        } else {
            return nil
        }
    }
    
    // MARK:- Table View Data Source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        // We will have a section for each altitude (low, medium, and high)
        // Some clouds will appear more than once if they appear at multiple altitudes!
        
        return CloudAltitude.count.rawValue
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let cloudData = sectionData(for: section)
        return cloudData?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell1", for: indexPath)
        
        if let cloud = rowData(for: indexPath) {
            cell.textLabel!.text = cloud.name
        }
        
        return cell
    }
    
    // MARK:- Section Headers
    
    func findAltitudeFor(section: Int) -> (String, String) {
        switch section {
        case 0:
            return ("Low Clouds","6,500 feet")
        case 1:
            return ("Medium Clouds","23,000 feet")
        case 2:
            return ("High Clouds", "40,000 feet")
        default:
            return ("","")
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2")
        cell?.textLabel!.text = findAltitudeFor(section: section).0
        cell?.detailTextLabel!.text = findAltitudeFor(section: section).1

        return cell

    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    // MARK:- Navigation
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowDetail", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            let controller = segue.destination as! CloudDetailViewController
            let indexPath = sender as! IndexPath
            controller.model = rowData(for: indexPath)
        }
    }
}

