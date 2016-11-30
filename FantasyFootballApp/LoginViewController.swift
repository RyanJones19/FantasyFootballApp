//
//  LoginViewController.swift
//  FantasyFootballApp
//
//  Created by Ryan Jones on 11/27/16.
//  Copyright © 2016 OSU. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background2.png")!)
        
        if(FBSDKAccessToken.current() == nil){
            
            print("Not Logged In...")

        }
        else{
            print("Logged In...")
            //self.performSegue(withIdentifier: "showNew", sender: self)
        }
        let loginButton = FBSDKLoginButton()
        loginButton.readPermissions = ["public_profile","email","user_friends"]
        loginButton.center = self.view.center
        
        loginButton.delegate = self
        self.view.addSubview(loginButton)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error == nil {
            print("Login Complete")
            print("Printing UserId...")
            //print(FBSDKAccessToken.current().userID)
            self.performSegue(withIdentifier: "showNew", sender: self)
        }
        else{
            //self.performSegue(withIdentifier: "showNew", sender: self)
            print("Printing error...")
            print(error.localizedDescription)
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
    }
    
    

}
