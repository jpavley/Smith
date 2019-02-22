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
    
    // MARK:- Navigation
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowDetail", sender: nil)
    }
}

