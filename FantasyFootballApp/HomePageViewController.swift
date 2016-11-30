//
//  HomePageViewController.swift
//  FantasyFootballApp
//
//  Created by Ryan Jones on 11/1/16.
//  Copyright © 2016 OSU. All rights reserved.
//

import UIKit
import MobileCoreServices
import FBSDKCoreKit
import FBSDKLoginKit


class HomePageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, FBSDKLoginButtonDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let loginButton = FBSDKLoginButton()
        loginButton.readPermissions = ["public_profile","email","user_friends"]
        loginButton.center = self.view.center
        
        loginButton.delegate = self
        self.view.addSubview(loginButton)
    }
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {

    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
        self.performSegue(withIdentifier: "LogoutSegue", sender: self)
    }
    
    
    @IBAction func prepareForUnwind(_ segue: UIStoryboardSegue){
        //Button to unwind from tableView to HomePageViewController
    }

}


