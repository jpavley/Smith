//
//  CloudModel.swift
//  Smith
//
//  Created by John Pavley on 2/19/19.
//  Copyright © 2019 John Pavley. All rights reserved.
//

import Foundation

enum CloudAltitude: Int {
    case low = 0, mid, high, count
}

class Cloud {
    var name = ""
    var abbreviation = ""
    var altitudeRange = [CloudAltitude]()
    var precipitationFlag = false
    var description = ""
    
    static func sampleData() -> [Cloud] {
        var clouds = [Cloud]()
        
        let cloud1 = cloudMaker(name: "Cumulonibmbus",
                               abbreviation: "Cb",
                               altitudeRange: [.low, .mid, .high],
                               precipitationFlog: true,
                               description: "Vertical sack of fluffy cotton balls with a dark bottom.")
        clouds.append(cloud1)
        
        let cloud2 = cloudMaker(name: "Cumulus",
                                abbreviation: "Cu",
                                altitudeRange: [.low],
                                precipitationFlog: false,
                                description: "Basket of fluffy cotton balls.")
        clouds.append(cloud2)
        
        let cloud3 = cloudMaker(name: "Stratocumulus",
                                abbreviation: "Sc",
                                altitudeRange: [.low],
                                precipitationFlog: false,
                                description: "Mountain range of fluffy cotton balls.")
        clouds.append(cloud3)
        
        let cloud4 = cloudMaker(name: "Stratus",
                                abbreviation: "St",
                                altitudeRange: [.low],
                                precipitationFlog: false,
                                description: "Tattered smears of thin cotton gauze.")
        clouds.append(cloud4)
        
        let cloud5 = cloudMaker(name: "Nimbostratus",
                                abbreviation: "Ns",
                                altitudeRange: [.low, .mid],
                                precipitationFlog: true,
                                description: "Dark and stormy wall of thunder.")
        clouds.append(cloud5)
        
        let cloud6 = cloudMaker(name: "Altocumulus",
                                abbreviation: "Ac",
                                altitudeRange: [.mid],
                                precipitationFlog: false,
                                description: "Dumplings of white fluffy cotton.")
        clouds.append(cloud6)
        
        let cloud7 = cloudMaker(name: "Altostratus",
                                abbreviation: "As",
                                altitudeRange: [.mid],
                                precipitationFlog: false,
                                description: "Long smear of thick cotton gauze.")
        clouds.append(cloud7)
        
        let cloud8 = cloudMaker(name: "Cirrocumulus",
                                abbreviation: "Cc",
                                altitudeRange: [.high],
                                precipitationFlog: false,
                                description: "Little dots of white fluffy cotton.")
        clouds.append(cloud8)
        
        let cloud9 = cloudMaker(name: "Cirrostratus",
                                abbreviation: "Cs",
                                altitudeRange: [.high],
                                precipitationFlog: false,
                                description: "Long ribbons of thin cotton gauze.")
        clouds.append(cloud9)

        let cloud0 = cloudMaker(name: "Cirrus",
                                abbreviation: "Ci",
                                altitudeRange: [.high],
                                precipitationFlog: false,
                                description: "Ripped shreads thin cotton gauze.")
        clouds.append(cloud0)
        
        return clouds
    }
    
    static func cloudMaker(name: String,
                           abbreviation: String,
                           altitudeRange: [CloudAltitude],
                           precipitationFlog: Bool,
                           description: String) -> Cloud {
        
        let cloud = Cloud()
        cloud.name = name
        cloud.abbreviation = abbreviation
        cloud.altitudeRange = altitudeRange
        cloud.precipitationFlag = precipitationFlog
        cloud.description = description
        return cloud
    }
}
