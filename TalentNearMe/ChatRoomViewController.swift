//
//  ChatRoomViewController.swift
//  TalentNearMe
//
//  Created by M.A.D. Crew. on 21/10/2016.
//  Copyright © 2016 M.A.D. Crew. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import Foundation
import FirebaseStorage
import FirebaseRemoteConfig

class ChatRoomViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var clientTable: UITableView!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var chatName: UINavigationItem!
    
    //Initialization for Firebase database
    var ref: FIRDatabaseReference!
    var messages: [FIRDataSnapshot]! = []
    var msglength: NSNumber = 100
    fileprivate var _refHandle: FIRDatabaseHandle!
    var storageRef: FIRStorageReference!
    var remoteConfig: FIRRemoteConfig!
    
    
    var uid: String = ""
    var uidToDisplay = ""
    var name: String?
    var myName: String?
    
    var tabBarName: String?

  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //設立tab bar item's title
        self.uidToDisplay = Manager.messageText
        let ref = FIRDatabase.database().reference(withPath: "ID/\(self.uidToDisplay)/Profile/Real-Name")
        ref.observe(.value, with: { (snapshot) in
            if let NameTab = (snapshot.value){
                self.tabBarName = (NameTab as! String)
                print("TabBarName is \(self.tabBarName)")
                self.chatName.title = self.tabBarName!
            }
        })
        
        
        
        
        //拿 UID
        if let user = FIRAuth.auth()?.currentUser {
            
            uid = user.uid  // The user's ID, unique to the Firebase project.
            // Do NOT use this value to authenticate with
            // your backend server, if you have one. Use
            // getTokenWithCompletion:completion: instead.
        } else {
            // No user is signed in.
        }
        
        //確認我的uid名字 Real-Name
        let reff = FIRDatabase.database().reference(withPath: "ID/\(self.uid)/Profile/Real-Name")
        print("selfuid is \(self.uid)")
        reff.observe(.value, with: { (snapshot) in
            if let safeName = (snapshot.value){
                self.myName = safeName as? String
                print("my name is \(self.myName)")
            }
        })
        
        
        
        self.clientTable.register(UITableViewCell.self, forCellReuseIdentifier: "tableViewCell")
        
        //Retrieve data from Firebase database
        // ref = FIRDatabase.database().reference(withPath: "Message/Chat")
        
        configureDatabase()
    }

    
    
    // UITextViewDelegate protocol methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else { return true }
        let data = [Constants.MessageFields.text: text]
        sendMessage(withData: data)
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //拿 UID
        if let user = FIRAuth.auth()?.currentUser {
            
            uid = user.uid  // The user's ID, unique to the Firebase project.
            // Do NOT use this value to authenticate with
            // your backend server, if you have one. Use
            // getTokenWithCompletion:completion: instead.
        } else {
            // No user is signed in.
        }

        
        let cell = self.clientTable.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath)
        
        // Unpack message from Firebase DataSnapshot
        let messageSnapshot: FIRDataSnapshot! = self.messages[indexPath.row]
        let message = messageSnapshot.value as! Dictionary<String, String>
        
        // let name = message[Constants.MessageFields.name] as String!
        
            let text = message[Constants.MessageFields.text] as String!

            var reff = FIRDatabase.database().reference(withPath: "ID/\(self.uidToDisplay)/Profile/Real-Name")
            reff.observe(.value, with: { (snapshot) in
                if let secureName = (snapshot.value){
                    
                    //FIRDatabase.database().reference(withPath: "ID/\(self.uid)/Profile/ChatList/\(self.uidToDisplay)").setValue(secureName)
                    
                    //FIRDatabase.database().reference(withPath: "Message/Chat/\(self.uid)/\(secureName)").setValue("")
                    self.name = (secureName as! String)
                    cell.textLabel?.text = self.name! + ": " + text!

                }
            })
            
            /*//
            let ref = FIRDatabase.database().reference(withPath: "ID/\(self.uid)/Profile/Real-Name")
            
            ref.observe(.value, with: { (snapshot) in
                if let secureName = (snapshot.value){
                    print("uid is \(self.uid)")
                    self.name = (secureName as! String)
                    print("name is \(self.name)")
                    cell.textLabel?.text = self.name! + ": " + text!
                }
            })
             */
            
            //cell.textLabel?.text = text!
            
            cell.imageView?.image = UIImage(named: "ic_account_circle")
            if let photoURL = message[Constants.MessageFields.photoURL], let URL = URL(string: photoURL), let data = try? Data(contentsOf: URL) {
                cell.imageView?.image = UIImage(data: data)
            }
        
        return cell
    }
    
    @IBAction func sendButton(_ sender: AnyObject) {
        textFieldShouldReturn(textField)
        
    }
    
    
    func configureDatabase() {
        ref = FIRDatabase.database().reference()
        // Listen for new messages in the Firebase database
        _refHandle = self.ref.child("Message/Chat/\(self.uid)").observe(.childAdded, with: { [weak self] (snapshot) -> Void in
            guard let strongSelf = self else { return }
            strongSelf.messages.append(snapshot)
            strongSelf.clientTable.insertRows(at: [IndexPath(row: strongSelf.messages.count-1, section: 0)], with: .automatic)
        })
    }
    
    func sendMessage(withData data: [String: String]) {
        
        //(Message/Chat/self.uid/uidToDisplay/Auto/-name: -text:

        var ref = FIRDatabase.database().reference(withPath: "ID/\(self.uidToDisplay)/Profile/Real-Name")
        ref.observe(.value, with: { (snapshot) in
            if let secureName1 = (snapshot.value){
                var mdata = data
                mdata[Constants.MessageFields.name] = secureName1
            }
        })
        
        //var mdata = data
        //mdata[Constants.MessageFields.name] = AppState.sharedInstance.displayName
        
        
        // Push data to Firebase Database
        
        self.ref.child("Message/Chat/\(self.uid)").childByAutoId().setValue(mdata)
        
    }
    
    
    deinit {
        self.ref.child("Message/Chat/\(self.uid)").removeObserver(withHandle: _refHandle)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        
        let newLength = text.characters.count + string.characters.count - range.length
        return newLength <= self.msglength.intValue // Bool
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


struct Constants {
    
    struct NotificationKeys {
        static let SignedIn = "onSignInCompleted"
    }
    
    struct Segues {
        static let SignInToFp = "SignInToFP"
        static let FpToSignIn = "FPToSignIn"
    }
    
    struct MessageFields {
        static let name = "name"
        static let text = "text"
        static let photoURL = "photoURL"
        static let imageURL = "imageURL"
    }
}




class AppState: NSObject {
    
    static let sharedInstance = AppState()
    
    var signedIn = false
    var displayName: String?
    var photoURL: URL?
}
