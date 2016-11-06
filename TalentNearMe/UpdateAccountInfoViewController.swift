//
//  UpdateAccountInfoViewController.swift
//  TalentNearMe
//
//  Created by M.A.D. Crew on 23/10/2016.
//  Copyright © 2016 M.A.D. Crew. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class UpdateAccountInfoViewController: UIViewController {
    
    @IBOutlet weak var jobTextLabel: UILabel!

    @IBAction func UpdatePersonalInfo_Photo_Button_Tapped(_ sender: UIButton) {
        
        
    }
    
    @IBOutlet weak var UpdatePersonalInfo_LearningPlan_Button: UIButton!
    @IBAction func UpdatePersonalInfo_LearningPlan_Button_Tapped(_ sender: UIButton) {
        
        //Create Alert Controller
        let alert = UIAlertController(title: "我的專長/想學的事物", message: "請輸入您的專長 或 想學的事物", preferredStyle: UIAlertControllerStyle.alert)
        
        //Create OK Action
        let ok = UIAlertAction(title: "完成", style: UIAlertActionStyle.default) { (action: UIAlertAction) -> Void in
            
            let textField = alert.textFields?[0]
            if textField?.text! != "" {
                
                //Write data to Firebase database
                let ref = FIRDatabase.database().reference(withPath: "ID/\(self.uid)/Profile/Learning-Goal")
                
                ref.setValue(textField?.text!)
                
                
                self.UpdatePersonalInfo_LearningPlan_Button.alpha = 0.20
            
                
                

                
            }
        }
        
        alert.addAction(ok)
        
        
        //Create Cancel Action
        let cancel = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler: nil)
        
        alert.addAction(cancel)
        
        
        //Add text field
        alert.addTextField(configurationHandler: {(textField: UITextField) -> Void in textField.placeholder = "如：擅長 Firebase，想學 GitHub"})
        
        
        
        //Present Alert Controller
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    
    @IBOutlet weak var UpdatePersonalInfo_JobDescription_Button: UIButton!
    @IBAction func UpdatePersonalInfo_JobDescription_Button_Tapped(_ sender: UIButton) {
        
        
        //Create Alert Controller
        let alert = UIAlertController(title: "我的職稱", message: "請輸入您的職稱", preferredStyle: UIAlertControllerStyle.alert)
        
        //Create OK Action
        let ok = UIAlertAction(title: "完成", style: UIAlertActionStyle.default) { (action: UIAlertAction) -> Void in
            
            let textField = alert.textFields?[0]
            if textField?.text! != "" {
                
                //Write data to Firebase database
                let ref = FIRDatabase.database().reference(withPath: "ID/\(self.uid)/Profile/Job-Description")
                
                ref.setValue(textField?.text!)
                
                
                self.UpdatePersonalInfo_JobDescription_Button.alpha = 0.20
                
                
             
            }
        }
        
        alert.addAction(ok)
        
        
        //Create Cancel Action
        let cancel = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler: nil)
        
        alert.addAction(cancel)
        
        
        //Add text field
        alert.addTextField(configurationHandler: {(textField: UITextField) -> Void in textField.placeholder = "如：iOS 工程師"})
        
        
        
        //Present Alert Controller
        self.present(alert, animated: true, completion: nil)
        
        

        
        
        
        
        
    }
    
    @IBOutlet weak var UpdatePersonalInfo_JobCategories_Button: UIButton!
    
    @IBAction func UpdatePersonalInfo_JobCategories_Button_Tapped(_ sender: UIButton) {

        
        
        //Create Alert Controller
        let alert = UIAlertController(title: "職務類別", message: "請選擇您的職務類別", preferredStyle: UIAlertControllerStyle.alert)
        
        //Create 經營/人資類 Action
        let HR = UIAlertAction(title: "經營/人資類", style: UIAlertActionStyle.default) { (action: UIAlertAction) -> Void in
            
            
            //Write data to Firebase database
            let ref = FIRDatabase.database().reference(withPath: "ID/\(self.uid)/Profile/Job-Category")
            
            ref.setValue("經營/人資類")
            
            
            self.UpdatePersonalInfo_JobCategories_Button.alpha = 0.20
            
        }
        
        alert.addAction(HR)
        
        
        
        //Create 行政/總務/法務類 Action
        let AD = UIAlertAction(title: "行政/總務/法務類", style: UIAlertActionStyle.default) { (action: UIAlertAction) -> Void in
            
            
            //Write data to Firebase database
            let ref = FIRDatabase.database().reference(withPath: "ID/\(self.uid)/Profile/Job-Category")
            
            ref.setValue("行政/總務/法務類")
            
            
            self.UpdatePersonalInfo_JobCategories_Button.alpha = 0.20
            
                   }
        
        alert.addAction(AD)
        
        
        
        //Create 資訊軟體系統類 Action
        let CS = UIAlertAction(title: "資訊軟體系統類", style: UIAlertActionStyle.default) { (action: UIAlertAction) -> Void in
            
            
            //Write data to Firebase database
            let ref = FIRDatabase.database().reference(withPath: "ID/\(self.uid)/Profile/Job-Category")
            
            ref.setValue("資訊軟體系統類")
            
            
            self.UpdatePersonalInfo_JobCategories_Button.alpha = 0.20
                }
        
        alert.addAction(CS)
        
        
        
        
        
        //Create Cancel Action
        let cancel = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler: nil)
        
        alert.addAction(cancel)
        
        
        
        
        //Present Alert Controller
        self.present(alert, animated: true, completion: nil)
        
        

        
    }
    
    @IBOutlet weak var UpdatePersonalInfo_SelfIntroduction_Button: UIButton!
    @IBAction func UpdatePersonalInfo_SelfIntroduction_Button_Tapped(_ sender: UIButton) {
        
        
        
        
        //Create Alert Controller
        let alert = UIAlertController(title: "自我簡介", message: "介紹自己，讓大家更容易認識你", preferredStyle: UIAlertControllerStyle.alert)
        
        //Create OK Action
        let ok = UIAlertAction(title: "完成", style: UIAlertActionStyle.default) { (action: UIAlertAction) -> Void in
            
            let textField = alert.textFields?[0]
            if textField?.text! != "" {
                
                //Write data to Firebase database
                let ref = FIRDatabase.database().reference(withPath: "ID/\(self.uid)/Profile/Self-Introduction")
                
                ref.setValue(textField?.text!)
                
                
                self.UpdatePersonalInfo_SelfIntroduction_Button.alpha = 0.20
                
                
            }
        }
        
        alert.addAction(ok)
        
        
        //Create Cancel Action
        let cancel = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler: nil)
        
        alert.addAction(cancel)
        
        
        //Add text field
        alert.addTextField(configurationHandler: {(textField: UITextField) -> Void in textField.placeholder = "如：大家好，.............."})
        
        
        
        //Present Alert Controller
        self.present(alert, animated: true, completion: nil)
        

        
    }
    
    
    var confirmMessage = ""
    @IBAction func UpdatePersonalInfo_Completion_Button_Tappped(_ sender: UIButton) {
        
        
        
            
            self.confirmMessage = ""
            
            
            //跳出資料確認視窗
            //Retrieve data from Firebase database + Compose confirmMessage
            var ref = FIRDatabase.database().reference(withPath: "ID/\(self.uid)/Profile/Real-Name")
            ref.observe(.value, with: { snapshot in (self.confirmMessage += "\n我的名字：", self.composeConfirmationMessage(newString: snapshot.value as! String))
            })
            
            
            ref = FIRDatabase.database().reference(withPath: "ID/\(self.uid)/Profile/Phone-Number")
            ref.observe(.value, with: { snapshot in (self.confirmMessage += "\n我的電話：", self.composeConfirmationMessage(newString: snapshot.value as! String))
            })
            
            
            ref = FIRDatabase.database().reference(withPath: "ID/\(self.uid)/Profile/Email")
            ref.observe(.value, with: { snapshot in (self.confirmMessage += "\n我的 E-mail：", self.composeConfirmationMessage(newString: snapshot.value as! String))
            })
            
            
            ref = FIRDatabase.database().reference(withPath: "ID/\(self.uid)/Profile/Job-Description")
            ref.observe(.value, with: { snapshot in (self.confirmMessage += "\n我的職稱：", self.composeConfirmationMessage(newString: snapshot.value as! String))
            })
            
            
            
            ref = FIRDatabase.database().reference(withPath: "ID/\(self.uid)/Profile/Learning-Goal")
            ref.observe(.value, with: { snapshot in (self.confirmMessage += "\n我的專長/想學的事物：", self.composeConfirmationMessage(newString: snapshot.value as! String))
            })
            
            
            ref = FIRDatabase.database().reference(withPath: "ID/\(self.uid)/Profile/Self-Introduction")
            ref.observe(.value, with: { snapshot in (self.confirmMessage += "\n自我簡介：", self.composeConfirmationMessage(newString: snapshot.value as! String))
            })
            
            
            ref = FIRDatabase.database().reference(withPath: "ID/\(self.uid)/Profile/Job-Category")
            ref.observe(.value, with: { snapshot in (self.confirmMessage += "\n職務類別：", self.composeConfirmationMessage(newString: snapshot.value as! String))
            })
            
            ref = FIRDatabase.database().reference(withPath: "ID/\(self.uid)/Profile/Gender")
            ref.observe(.value, with: { snapshot in (self.confirmMessage += "\n性別：", self.composeConfirmationMessage(newString: snapshot.value as! String))
            })
            
            
            //Just to make sure confirmation page doesn't load before the app is done importing data from Firebase
            var tempString = ""
            ref = FIRDatabase.database().reference(withPath: "ID/\(self.uid)/Profile/Safety-Check")
        ref.observe(.value, with: { snapshot in (tempString = snapshot.value as! String, self.showConfirmationPage(),        //Go back to SettingViewController
             self.view.removeFromSuperview())
            })
            
            
            
            
            
            
            
            
            
            
        
        
        
        
        
        
    }
    
    func composeConfirmationMessage(newString: String){
        
        confirmMessage += newString
        
    }
    
    
    
    func showConfirmationPage(){
        
        
        //Create Alert Controller
        let alert = UIAlertController(title: "個人資料更新完成！", message: confirmMessage, preferredStyle: UIAlertControllerStyle.alert)
        
        
        
        
        
        //Create Confirm Action
        let cancel = UIAlertAction(title: "確定", style: UIAlertActionStyle.cancel) { (action: UIAlertAction) -> Void in self.confirmMessage = ""
        }
        
        alert.addAction(cancel)
        
        
        
        
        //Present Alert Controller
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
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
        
        
        jobTextLabel.transform = CGAffineTransform(rotationAngle: -0.23)

        // Do any additional setup after loading the view.
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
