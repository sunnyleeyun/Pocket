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
    
    @IBAction func BasicContact_StartChatting_Button_Tapped(_ sender: UIButton) {
        
        
    }
    var uid = ""
    var uidToDisplay = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.uidToDisplay = Manager.messageText
        
        
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
