//
//  PlayersDetailViewController.swift
//  FantasyFootballApp
//
//  Created by Ryan Jones on 11/29/16.
//  Copyright © 2016 OSU. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class PlayersDetailViewController: UIViewController {
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var playerPosition: UILabel!
    
    
    var player = GTLRPlayers_MainAPIPlayer()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.edit, target: self, action: #selector(PlayersDetailViewController.showEditPlayerDialog))
        playerName.text = player.name
        playerPosition.text = player.position

    }

    func showEditPlayerDialog(){
        let alertController = UIAlertController(title: "Edit a Player", message: "", preferredStyle: UIAlertControllerStyle.alert)
        
        alertController.addTextField { (textField) -> Void in
            textField.placeholder = "Player Name"
            textField.text = self.player.name
        }
        
        
        alertController.addTextField { (textField) -> Void in
            textField.placeholder = "Player Position"
            textField.text = self.player.position
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel){
            (action) -> Void in
            print("Pressed Cancel")
        }
        
        let editPlayerAction = UIAlertAction(title: "Edit Player", style: UIAlertActionStyle.default){
            (action) -> Void in
            let nameTextField = alertController.textFields![0] as UITextField
            let positionTextField = alertController.textFields![1] as UITextField
            print("Name = \(nameTextField.text!)")
            print("Position = \(positionTextField.text!)")
            self.playerName.text = nameTextField.text
            self.playerPosition.text = positionTextField.text
        
            
            self.player.previousName = self.player.name
            self.player.name = nameTextField.text!
            self.player.position = positionTextField.text!
            self.player.userID = FBSDKAccessToken.current().userID
            
            self._updatePlayer()
            
        }
        
        
        alertController.addAction(cancelAction)
        alertController.addAction(editPlayerAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func _updatePlayer(){
        let query : GTLRPlayersQuery_PlayerUpdate = GTLRPlayersQuery_PlayerUpdate.query(withObject: player)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        service.executeQuery(query) { (ticket, response, error) -> Void in
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            if error != nil{
                let alertController = UIAlertController(title: "Endpoints Error", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                let defaultAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
                return
            }
            else{
                print("method successful")
            }
        }
    }
    
}
