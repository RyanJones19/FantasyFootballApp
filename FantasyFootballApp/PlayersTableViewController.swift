//
//  PlayersTableViewController.swift
//  FantasyFootballApp
//
//  Created by Ryan Jones on 11/2/16.
//  Copyright © 2016 OSU. All rights reserved.
//

import UIKit

let isLocalHostTesting = false
let localHostURL = "http://localhost:8080/_ah/api/"

class PlayersTableViewController: UITableViewController {

    let playerCellIdentifier = "PlayerCell"
    
    let names = ["Ryan","Tyler","Megan"]
    
    var players = [GTLRPlayers_MainAPIPlayer]()
    
    var service : GTLRPlayersService{
        if _service != nil{
            return _service!
        }
        _service = GTLRPlayersService()
    
        //SETUP
        
        if isLocalHostTesting{
            _service?.rootURLString = localHostURL
            _service?.fetcherService.allowLocalhostRequest = true
        }
        _service?.isRetryEnabled = true
        return _service!
        
    }
    
    var _service : GTLRPlayersService?
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(PlayersTableViewController.showAddPlayerDialog))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(PlayersTableViewController.goBackToHomePage))
        
        _queryForPlayers()
        
        //players.append(Player(name: "Ryan Jones", position: "QB"))
        
        //players.append(Player(name: "Mel Chesnutis", position: "RB"))
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        //_queryForPlayers()
    }
    
    func goBackToHomePage(){
        
        self.performSegue(withIdentifier: "unwindToHomePageViewController", sender: self)
    }
    
    func showAddPlayerDialog() {
        let alertController = UIAlertController(title: "Add a player to player list", message: "", preferredStyle: UIAlertControllerStyle.alert)

        alertController.addTextField { (textField) -> Void in
            textField.placeholder = "Player Name"
        }
        
        
        alertController.addTextField { (textField) -> Void in
            textField.placeholder = "Player Position"
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel){
            (action) -> Void in
            print("Pressed Cancel")
        }
        
        let addPlayerAction = UIAlertAction(title: "Add Player", style: UIAlertActionStyle.default){
            (action) -> Void in
            let nameTextField = alertController.textFields![0] as UITextField
            let positionTextField = alertController.textFields![1] as UITextField
            print("Name = \(nameTextField.text!)")
            print("Position = \(positionTextField.text!)")
            
            let player = GTLRPlayers_MainAPIPlayer()
            player.name = nameTextField.text!
            player.position = positionTextField.text!
            
            //Send player to backend
            self._insertPlayers(player)
            
            self.players.insert(player, at: 0)
            
            if self.players.count == 1{
                self.tableView.reloadData()
            }else {
                let newIndexPath = IndexPath(row: 0, section: 0)
                self.tableView.insertRows(at: [newIndexPath], with: .automatic)
            }

        }

        
        alertController.addAction(cancelAction)
        alertController.addAction(addPlayerAction)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return players.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: playerCellIdentifier, for: indexPath) as UITableViewCell

        let player = players[indexPath.row]
        
        
        cell.textLabel?.text = player.name
        cell.detailTextLabel?.text = player.position
        
        return cell
    }
    
    // MARK: Private helper methods
    
    func _queryForPlayers(){
        let query : GTLRPlayersQuery_PlayerList = GTLRPlayersQuery_PlayerList.query()
        //query.order = "-last_touch_date_time"
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        service.executeQuery(query) { (ticket, response, error) -> Void in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            if error != nil{
                self._showErrorDialog(error! as NSError)
                return
            } else {
                let playerList = response as! GTLRPlayers_MainAPIPlayerList
                
                if let newPlayers = playerList.players! as? [GTLRPlayers_MainAPIPlayer]{
                    self.players = newPlayers
                }
                
            }
            self.tableView.reloadData()
        }
        
    }
    
    func _insertPlayers(_ newPlayer : GTLRPlayers_MainAPIPlayer){
        let query : GTLRPlayersQuery_PlayerInsert = GTLRPlayersQuery_PlayerInsert.query(withObject: newPlayer)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        service.executeQuery(query) { (ticket, response, error) -> Void in
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            if error != nil{
                self._showErrorDialog(error! as NSError)
                return
            }
            
            let returnedPlayer = response as! GTLRPlayers_MainAPIPlayer
            //TODO: need to use returnedPlayer to set the entityKey on the backend for Update and Delete
            
        }
    }
    
    
    func _showErrorDialog(_ error: NSError){
        let alertController = UIAlertController(title: "Endpoints Error", message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
        let defaultAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView:UITableView, didSelectRowAt indexPath: IndexPath){
        print("You just clicked on \(players[indexPath.row])")
    }
}
