//
//  Player.swift
//  FantasyFootballApp
//
//  Created by Ryan Jones on 11/2/16.
//  Copyright © 2016 OSU. All rights reserved.
//

import UIKit

class Player: NSObject {
    
    var name : String
    var position : String
    init(name : String, position : String){
        self.name = name
        self.position = position
    }
}
