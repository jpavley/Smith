//
//  ViewController.swift
//  Smith
//
//  Created by John Pavley on 2/15/19.
//  Copyright © 2019 John Pavley. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    let model = [["cat","dog","cow"], ["village", "city", "town"], ["sun", "moon", "star"]]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
}

extension ViewController {
    
    // MARK:- Table View Data Source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return model.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell1", for: indexPath)
        cell.textLabel!.text = model[indexPath.section][indexPath.row]
        return cell
    }
}

