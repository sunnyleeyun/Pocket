//
//  PopUpViewController.swift
//  TalentNearMe
//
//  Created by M.A.D. Crew. on 21/10/2016.
//  Copyright © 2016 M.A.D. Crew. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class BasicContactViewController: UIViewController {

    @IBOutlet weak var BasicContact_Name: UILabel!
    
    @IBOutlet weak var BasicContact_JobDescription: UILabel!
    
    @IBOutlet weak var BasicContact_Line: UIImageView!
    
    @IBOutlet weak var BasicContact_SelfIntroduction: UITextView!
    
    @IBAction func BasicContact_SeeMore_Button_Tapped(_ sender: AnyObject) {
        
    }
    
    
    var chatListPeople = ""
    var IntChatListPeople: Int = 0
    var chatListAccount = ""
    
    @IBAction func BasicContact_StartChatting_Button_Tapped(_ sender: UIButton) {
        
        //Iterate through every user's chatlist in database
        FIRDatabase.database().reference().child("ID/\(self.uid)/Profile/ChatList").observe(.value, with: { (snapshot) in
            
            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot]{
                
                for child in snapshots{
                    
                    //好友代號0, 1, 2, ...
                    self.chatListPeople = child.key as! String
                    print("chatListPeople is \(self.chatListPeople)")
                    
                    //好友uid
                    self.chatListAccount = child.value as! String
                    print("chatListAccount is \(self.chatListAccount)")
                    
                    //如果chatListAccount不存在，
                    //  chatListPeople + 1，
                    //  childListAccount -> uidToDisplay
                    //  跳到chatRoom V.C.
                    //  Add: Message/Chat/self.uid/chatListAccount
                    //如果chatListAccount已經存在，
                    //  chatListPeople + 0，
                    //  chatListAccount -> uidToDisplay
                    //  跳到chatRoom V.C.
                    //  Existed: Message/Chat/self.uid/chatListAccount
                    
                    if self.chatListAccount != self.uidToDisplay{
                        
                        self.IntChatListPeople = Int(self.chatListPeople)!
                        self.IntChatListPeople += 1
                        print("Integer of ChatListPeople is \(self.IntChatListPeople)")
                        
                        FIRDatabase.database().reference(withPath: "ID/\(self.uid)/Profile/ChatList/\(self.chatListPeople)").setValue(self.chatListAccount, withCompletionBlock: { (Error, FIRDatabaseReference) in
                            if Error != nil {
                                print("CAN'T UPLOAD, Error: \(Error)")
                            }
                        })
                        print("doinioininini")
                        FIRDatabase.database().reference(withPath: "Message/Chat/\(self.uid)").setValue(self.chatListAccount, withCompletionBlock: { (Error, FIRDatabaseReference) in
                            if Error != nil {
                                print("CAN'T UPLOAD, Error: \(Error)")
                            }
                        })
                        
                        self.chatListPeople = String(self.IntChatListPeople)
                        
                    }
                    
                    
                }
            }
            
        })
        
        /*
        let reff = FIRDatabase.database().reference(withPath: "ID/\(self.uid)/Profile/ChatList/\(chatListPeople)")
        reff.observe(.value, with: { (snapshot) in
            if let chatPerson = (snapshot.value){
                self.chatListPeople += 0
                //self.name = (secureName as! String)
                //print("name is \(self.name)")
                //self.chatName.title = self.name!
            }else{
                self.chatListPeople += 1
            }
            print("which is\(self.chatListPeople)")
        })
        */
        
        /*
        var ref = FIRDatabase.database().reference(withPath: "ID/\(self.uid)/Profile/ChatList/\(chatListPeople)")
        //setvalue放到firebase
        ref.setValue(self.uidToDisplay, withCompletionBlock:
            {(Error, FIRDatabaseReference) -> Void in
                print("CAN'T UPLOAD, Error: \(Error)")
                
        })
        */

        
    }
    var uid = ""
    var uidToDisplay = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.uidToDisplay = Manager.messageText
        print("UISTODISPLAY is \(self.uidToDisplay)")
        
        
        //拿 UID
        if let user = FIRAuth.auth()?.currentUser {
            
            uid = user.uid  // The user's ID, unique to the Firebase project.
            // Do NOT use this value to authenticate with
            // your backend server, if you have one. Use
            // getTokenWithCompletion:completion: instead.
        } else {
            // No user is signed in.
        }
        
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        //Retrieve data from Firebase database
        var ref = FIRDatabase.database().reference(withPath: "ID/\(self.uidToDisplay)/Profile/Real-Name")
        ref.observe(.value, with: { snapshot in (self.BasicContact_Name.text = snapshot.value as! String)
            })
        
        
        
        
        
        //Retrieve data from Firebase database
        ref = FIRDatabase.database().reference(withPath: "ID/\(self.uidToDisplay)/Profile/Job-Description")
        ref.observe(.value, with: { snapshot in (self.BasicContact_JobDescription.text = snapshot.value as! String)
        })
        
        
        //Retrieve data from Firebase database
        ref = FIRDatabase.database().reference(withPath: "ID/\(self.uidToDisplay)/Profile/Self-Introduction")
        ref.observe(.value, with: { snapshot in (self.BasicContact_SelfIntroduction.text = snapshot.value as! String)
        })
      
        
        
        self.showAnimate()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closePopUp(_ sender: AnyObject) {
        
        self.removeAnimate()
        //self.view.removeFromSuperview()
        
    }
    
    
    func showAnimate(){
        
        self.view.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.25, animations: {
            
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            
        })
        
    }
    
    func removeAnimate(){
        
        UIView.animate(withDuration: 0.25, animations: {
            
            self.view.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0
            }, completion: {(finished : Bool) in
                if (finished){
                    
                    
                    self.view.removeFromSuperview()
                    
                }
        })
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    


}
