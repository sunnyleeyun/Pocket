//
//  DetailedContactViewController.swift
//  TalentNearMe
//
//  Created by M.A.D. Crew. on 23/10/2016.
//  Copyright © 2016 M.A.D. Crew. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class DetailedContactViewController: UIViewController {

    @IBOutlet weak var DetailedContact_ProfilePicture: UIImageView!
    

    @IBOutlet weak var DetailedContact_Name: UILabel!
    
    @IBOutlet weak var DetailedContact_JobDescription: UILabel!
    
    @IBOutlet weak var DetailedContact_LearningPlan: UILabel!
    
    @IBOutlet weak var DetailedContact_SelfIntroduction: UILabel!
    
    
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
        
        // Do any additional setup after loading the view.
        
        //Retrieve data from Firebase database
        var ref = FIRDatabase.database().reference(withPath: "ID/\(self.uid)/Profile/Real-Name")
        ref.observe(.value, with: { snapshot in (self.DetailedContact_Name.text = snapshot.value as! String)
        })
        
        ref = FIRDatabase.database().reference(withPath: "ID/\(self.uid)/Profile/Job-Description")
        ref.observe(.value, with: { snapshot in (self.DetailedContact_JobDescription.text = snapshot.value as! String)
        })
        
        ref = FIRDatabase.database().reference(withPath: "ID/\(self.uid)/Profile/Learning-Goal")
        ref.observe(.value, with: { snapshot in (self.DetailedContact_LearningPlan.text = snapshot.value as! String)
        })
        
        ref = FIRDatabase.database().reference(withPath: "ID/\(self.uid)/Profile/Self-Introduction")
        ref.observe(.value, with: { snapshot in (self.DetailedContact_SelfIntroduction.text = snapshot.value as! String)
        })
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
