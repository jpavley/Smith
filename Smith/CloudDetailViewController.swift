//
//  CloudDetailViewController.swift
//  Smith
//
//  Created by John Pavley on 2/22/19.
//  Copyright © 2019 John Pavley. All rights reserved.
//

import UIKit

class CloudDetailViewController: UITableViewController {
    
    var model: Cloud!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var abbreviationLabel: UILabel!
    @IBOutlet weak var altitudeLabel: UILabel!
    @IBOutlet weak var precipitationLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        updateView()
    }
    
    func textFor(altitudeRange: [CloudAltitude]) -> String {
        var result = ""
        
        for altitude in altitudeRange {
            switch altitude {
            case .low:
                result += "Low "
            case .mid:
                result += "Mid "
            case .high:
                result += "High "
            case .count:
                result += "Count "
            }
        }
        
        return result
    }
    
    func updateView() {
        nameLabel.text = model.name
        abbreviationLabel.text = model.abbreviation
        descriptionTextView.text = model.description
        altitudeLabel.text = textFor(altitudeRange: model.altitudeRange)
        precipitationLabel.text = model.precipitationFlag ? "True" : "False"
    }
}
