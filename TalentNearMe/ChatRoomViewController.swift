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
    var name = ""
    var myName: String?
    
    var messengerAutoID = ""
    
    var tabBarName: String?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
         UITabBarItem.appearance().setTitleTextAttributes( [NSFontAttributeName: UIFont(name:"your_font_name", size:11)!, NSForegroundColorAttributeName: UIColor(rgb: 0x929292)], forState: .Normal)
         */
        
        
    /////////////////??  Haven't Set Title font  ??//////////////////
        
        self.clientTable.register(UITableViewCell.self, forCellReuseIdentifier: "tableViewCell")
        
        //設立tab bar item's title
        self.uidToDisplay = Manager.messageText
        let ref1 = FIRDatabase.database().reference(withPath: "ID/\(self.uidToDisplay)/Profile/Real-Name")
        ref1.observe(.value, with: { (snapshot) in
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
        let ref2 = FIRDatabase.database().reference(withPath: "ID/\(self.uid)/Profile/Real-Name")
        print("selfuid is \(self.uid)")
        ref2.observe(.value, with: { (snapshot) in
            if let safeName = (snapshot.value){
                self.myName = safeName as? String
                print("my name is \(self.myName)")
            }
        })
        
                
// ID/self.uid/Profile/ChatList/self.uidToDisplay/real-name
        
        let ref3 = FIRDatabase.database().reference(withPath: "ID/\(self.uid)/Profile/ChatList/\(self.uidToDisplay)")
        ref3.observe(.value, with: { (snapshot) in
            if let secureMessenger = (snapshot.value){
                self.messengerAutoID = secureMessenger as! String
                print("messengerName is \(self.messengerAutoID)")
            }
        })
        
        

        
        
        //configureDatabase()
    }
    
    

    
    
    // UITextViewDelegate protocol methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else { return true }
        let data = [Constants.MessageFields.text: text]
        sendMessage(withData: data)
        return true
    }
    
    func sendMessage(withData data: [String: String]) {
        
        var mdata = data
        
        mdata[Constants.MessageFields.name] = self.name
        
        
        print("mdata is\(mdata)")
        
                //////// check for nil

        self.ref.child("Message/\(self.messengerAutoID)").childByAutoId().setValue(mdata)
        
        
    
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        

        let cell = self.clientTable.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath)
        
        // Unpack message from Firebase DataSnapshot
        let messageSnapshot: FIRDataSnapshot! = self.messages[indexPath.row]
        let message = messageSnapshot.value as! Dictionary<String, String>
        
        
        // Path: Message/one,two,three.../childAuto/-name: -text:
        
        //let name = message[Constants.MessageFields.name] as String!
        let text = message[Constants.MessageFields.text] as String!
        
            cell.textLabel?.text = self.name + ": " + text!
        
            let reff = FIRDatabase.database().reference(withPath: "ID/\(self.uid)/Profile/Real-Name")
            reff.observe(.value, with: { (snapshot) in
                if let secureName = (snapshot.value){
                    self.name = (secureName as! String)
                    print("the one who's talking is \(self.name)")
                    cell.textLabel?.text = self.name + ": " + text!
                    
                }
            })
 
        return cell
    }
    
    @IBAction func sendButton(_ sender: AnyObject) {
        textFieldShouldReturn(textField)
    }
    
    // Path: Message/one,two,three.../childAuto/-name: -text:

    func configureDatabase() {
        ref = FIRDatabase.database().reference()
        // Listen for new messages in the Firebase database
        
        
        //////// deal with this /////////
        
        
        _refHandle = self.ref.child("Message/\(self.messengerAutoID)").observe(.childAdded, with: { [weak self] (snapshot) -> Void in
            guard let strongSelf = self else { return }
            strongSelf.messages.append(snapshot)
            strongSelf.clientTable.insertRows(at: [IndexPath(row: strongSelf.messages.count-1, section: 0)], with: .automatic)
        })
    }
    
    func showAlert(withTitle title:String, message:String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title,
                                          message: message, preferredStyle: .alert)
            let dismissAction = UIAlertAction(title: "Dismiss", style: .destructive, handler: nil)
            alert.addAction(dismissAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    
    deinit {
        self.ref.child("Message/\(self.messengerAutoID)").removeObserver(withHandle: _refHandle)
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


