//
//  SecondViewController.swift
//  TalentNearMe
//
//  Created by M.A.D. Crew. on 21/10/2016.
//  Copyright © 2016 M.A.D. Crew. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase
import FirebaseAuth

class ChatListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var conversationList: [String?] = []

    var ref: FIRDatabaseReference!
    
    var uid = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //拿 UID
        if let user = FIRAuth.auth()?.currentUser {
            
            uid = user.uid  // The user's ID, unique to the Firebase project.
            // Do NOT use this value to authenticate with
            // your backend server, if you have one. Use
            // getTokenWithCompletion:completion: instead.
        } else {
            // No user is signed in.
        }
        
        
        tableView.dataSource = self
        tableView.delegate = self
        

        ref = FIRDatabase.database().reference()
        
        chatList()
    }
    
    
    var chatListAccount = ""
    var messengerAutoID = ""
    
    
    //找profile裡面的chatlist
    func chatList(){
        //Iterate through every user's chatlist in database
        FIRDatabase.database().reference().child("ID/\(self.uid)/Profile/ChatList").observe(.value, with: { (snapshot) in
            
            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot]{
                
                for child in snapshots{
                    
                    //好友uid
                    self.chatListAccount = child.key
                    print("ChatListAccount is \(self.chatListAccount)")
                    
                    //messengerName
                    self.messengerAutoID = child.value as! String
                    print("messengerAutoID is \(self.messengerAutoID)")
                    
                    
                    print("snapshots is \(snapshots)")
                    
                    let reff = FIRDatabase.database().reference(withPath: "ID/\(self.chatListAccount)/Profile/Real-Name")
                    reff.observe(.value, with: { (snapshot) in
                        if let secureName = (snapshot.value){
                            
                            self.conversationList.append(secureName as! String)
                            print("conversation list is \(self.conversationList)")
                            
                            self.tableView.reloadData()
                        }
                    })

                    
                    
                }
                
            }

        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print("count of conversation list is \(conversationList.count)")
        return conversationList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        print(indexPath.row)
        
        
        

        cell.textLabel?.text = conversationList[indexPath.row]
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ourSegue", sender: conversationList[indexPath.row])
    }
    

    
}

