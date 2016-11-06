//
//  LogInViewController.swift
//  TalentNearMe
//
//  Created by Sunny on 2016/10/23.
//  Copyright © 2016年 M.A.D. Crew. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class SignUpViewController: UIViewController {
    
    
    //Initialization for Firebase database
    var ref: FIRDatabaseReference!
    
    
    var SignUpCompletionProgressView_Count = 0.0
    
    @IBOutlet weak var Name_Button: UIButton!
    var Name_Button_Completion_Count = 0
    
    @IBAction func Name_Button_Tapped(_ sender: UIButton) {
        
        //Create Alert Controller
        let alert = UIAlertController(title: "我的名字", message: "請輸入您的真實姓名", preferredStyle: UIAlertControllerStyle.alert)
        
        
        //Create OK Action
        let ok = UIAlertAction(title: "完成", style: UIAlertActionStyle.default) { (action: UIAlertAction) -> Void in
            
            let textField = alert.textFields?[0]
            if textField?.text! != "" {
                
                //Write data to Firebase database
                self.ref = FIRDatabase.database().reference(withPath: "ID/\(self.uid)/Profile/Real-Name")
                
                self.ref.setValue(textField?.text!)
                
                
                self.Name_Button.alpha = 0.20
                
                if self.Name_Button_Completion_Count == 0 {
                    
                    self.SignUpCompletionProgressView_Count += 10/90 // 1.0(100%) / 9(items) / 10(0.0 - 1.0)
                    
                    self.Master_SignUp_Button_Completion_Count += 1
                }
                
                self.Name_Button_Completion_Count = 1
                
                self.updateSignUpCompletionProgressView()
                
                
                //Write to Firebase database
                //self.ref.child("users").
                
            }
        }
        
        alert.addAction(ok)
        
        
        //Create Cancel Action
        let cancel = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler: nil)
        
        alert.addAction(cancel)
        
        
        //Add text field
        alert.addTextField(configurationHandler: {(textField: UITextField) -> Void in textField.placeholder = "如：李大明"})
        
        
        
        //Present Alert Controller
        self.present(alert, animated: true, completion: nil)
        
        
        
    }
    
    
    
    @IBOutlet weak var PhoneNumber_Button: UIButton!
    var PhoneNumber_Button_Completion_Count = 0
    
    @IBAction func PhoneNumber_Button_Tapped(_ sender: UIButton) {
        
        //Create Alert Controller
        let alert = UIAlertController(title: "我的電話", message: "請輸入您的聯絡電話", preferredStyle: UIAlertControllerStyle.alert)
        
        //Create OK Action
        let ok = UIAlertAction(title: "完成", style: UIAlertActionStyle.default) { (action: UIAlertAction) -> Void in
            
            let textField = alert.textFields?[0]
            if textField?.text! != "" {
                
                //Write data to Firebase database
                self.ref = FIRDatabase.database().reference(withPath: "ID/\(self.uid)/Profile/Phone-Number")
                
                self.ref.setValue(textField?.text!)
                
                
                self.PhoneNumber_Button.alpha = 0.20
                
                if self.PhoneNumber_Button_Completion_Count == 0 {
                    
                    self.SignUpCompletionProgressView_Count += 10/90 // 1.0(100%) / 9(items) / 10(0.0 - 1.0)
                    
                    self.Master_SignUp_Button_Completion_Count += 1
                }
                
                self.PhoneNumber_Button_Completion_Count = 1
                
                self.updateSignUpCompletionProgressView()
                
                
                //Write to Firebase database
                //self.ref.child("users").
                
            }
        }
        
        alert.addAction(ok)
        
        
        //Create Cancel Action
        let cancel = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler: nil)
        
        alert.addAction(cancel)
        
        
        //Add text field
        alert.addTextField(configurationHandler: {(textField: UITextField) -> Void in textField.placeholder = "如：0912-345-678"})
        
        
        
        //Present Alert Controller
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    
    
    @IBOutlet weak var Email_Button: UIButton!
    var Email_Button_Completion_Count = 0
    
    @IBAction func Email_Button_Tapped(_ sender: UIButton) {
        
        //Create Alert Controller
        let alert = UIAlertController(title: "我的 E-mail", message: "請輸入您的 E-mail", preferredStyle: UIAlertControllerStyle.alert)
        
        //Create OK Action
        let ok = UIAlertAction(title: "完成", style: UIAlertActionStyle.default) { (action: UIAlertAction) -> Void in
            
            let textField = alert.textFields?[0]
            if textField?.text! != "" {
                
                //Write data to Firebase database
                self.ref = FIRDatabase.database().reference(withPath: "ID/\(self.uid)/Profile/Email")
                
                self.ref.setValue(textField?.text!)
                
                
                self.Email_Button.alpha = 0.20
                
                if self.Email_Button_Completion_Count == 0 {
                    
                    self.SignUpCompletionProgressView_Count += 10/90 // 1.0(100%) / 9(items) / 10(0.0 - 1.0)
                    
                    self.Master_SignUp_Button_Completion_Count += 1
                }
                
                self.Email_Button_Completion_Count = 1
                
                self.updateSignUpCompletionProgressView()
                
                
                //Write to Firebase database
                //self.ref.child("users").
                
            }
        }
        
        alert.addAction(ok)
        
        
        //Create Cancel Action
        let cancel = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler: nil)
        
        alert.addAction(cancel)
        
        
        //Add text field
        alert.addTextField(configurationHandler: {(textField: UITextField) -> Void in textField.placeholder = "如：Amy@gmail.com"})
        
        
        
        //Present Alert Controller
        self.present(alert, animated: true, completion: nil)
        
        
        
        
    }
    
    
    
    
    
    @IBOutlet weak var Photo_Button: UIButton!
    var Photo_Button_Completion_Count = 0
    @IBAction func Photo_Button_Tapped(_ sender: UIButton) {
        

        
        
        self.Photo_Button.alpha = 0.20
        
        if self.Photo_Button_Completion_Count == 0 {
            
            self.SignUpCompletionProgressView_Count += 10/90 // 1.0(100%) / 9(items) / 10(0.0 - 1.0)
            
            self.Master_SignUp_Button_Completion_Count += 1
        }
        
        self.Photo_Button_Completion_Count = 1
        
        self.updateSignUpCompletionProgressView()
        
        
    }
    
    
    
    
    
    
    @IBOutlet weak var JobDescription_Button: UIButton!
    var JobDescription_Button_Completion_Count = 0
    
    @IBAction func JobDescription_Button_Tapped(_ sender: UIButton) {
        
        //Create Alert Controller
        let alert = UIAlertController(title: "我的職稱", message: "請輸入您的職稱", preferredStyle: UIAlertControllerStyle.alert)
        
        //Create OK Action
        let ok = UIAlertAction(title: "完成", style: UIAlertActionStyle.default) { (action: UIAlertAction) -> Void in
            
            let textField = alert.textFields?[0]
            if textField?.text! != "" {
                
                //Write data to Firebase database
                self.ref = FIRDatabase.database().reference(withPath: "ID/\(self.uid)/Profile/Job-Description")
                
                self.ref.setValue(textField?.text!)
                
                
                self.JobDescription_Button.alpha = 0.20
                
                if self.JobDescription_Button_Completion_Count == 0 {
                    
                    self.SignUpCompletionProgressView_Count += 10/90 // 1.0(100%) / 9(items) / 10(0.0 - 1.0)
                    
                    self.Master_SignUp_Button_Completion_Count += 1
                }
                
                self.JobDescription_Button_Completion_Count = 1
                
                self.updateSignUpCompletionProgressView()
                
                
                //Write to Firebase database
                //self.ref.child("users").
                
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
    
    
    
    @IBOutlet weak var Learning_Goal_Button: UIButton!
    var Learning_Goal_Button_Completion_Count = 0
    @IBAction func Learning_Goal_Button_Tapped(_ sender: UIButton) {
        
        
        //Create Alert Controller
        let alert = UIAlertController(title: "我的專長/想學的事物", message: "請輸入您的專長 或 想學的事物", preferredStyle: UIAlertControllerStyle.alert)
        
        //Create OK Action
        let ok = UIAlertAction(title: "完成", style: UIAlertActionStyle.default) { (action: UIAlertAction) -> Void in
            
            let textField = alert.textFields?[0]
            if textField?.text! != "" {
                
                //Write data to Firebase database
                self.ref = FIRDatabase.database().reference(withPath: "ID/\(self.uid)/Profile/Learning-Goal")
                
                self.ref.setValue(textField?.text!)
                
                
                self.Learning_Goal_Button.alpha = 0.20
                
                if self.Learning_Goal_Button_Completion_Count == 0 {
                    
                    self.SignUpCompletionProgressView_Count += 10/90 // 1.0(100%) / 9(items) / 10(0.0 - 1.0)
                    
                    self.Master_SignUp_Button_Completion_Count += 1
                }
                
                self.Learning_Goal_Button_Completion_Count = 1
                
                self.updateSignUpCompletionProgressView()
                
                
                //Write to Firebase database
                //self.ref.child("users").
                
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
    
    
    
    
    @IBOutlet weak var SelfIntroduction_Button: UIButton!
    var SelfIntroduction_Button_Completion_Count = 0
    
    @IBAction func SelfIntroduction_Button_Tapped(_ sender: UIButton) {
        
        
        
        //Create Alert Controller
        let alert = UIAlertController(title: "自我簡介", message: "介紹自己，讓大家更容易認識你", preferredStyle: UIAlertControllerStyle.alert)
        
        //Create OK Action
        let ok = UIAlertAction(title: "完成", style: UIAlertActionStyle.default) { (action: UIAlertAction) -> Void in
            
            let textField = alert.textFields?[0]
            if textField?.text! != "" {
                
                //Write data to Firebase database
                self.ref = FIRDatabase.database().reference(withPath: "ID/\(self.uid)/Profile/Self-Introduction")
                
                self.ref.setValue(textField?.text!)
                
                
                self.SelfIntroduction_Button.alpha = 0.20
                
                if self.SelfIntroduction_Button_Completion_Count == 0 {
                    
                    self.SignUpCompletionProgressView_Count += 10/90 // 1.0(100%) / 9(items) / 10(0.0 - 1.0)
                    self.Master_SignUp_Button_Completion_Count += 1
                }
                
                self.SelfIntroduction_Button_Completion_Count = 1
                
                self.updateSignUpCompletionProgressView()
                
                
                //Write to Firebase database
                //self.ref.child("users").
                
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
    
    
    @IBOutlet weak var JobCategories_Button: UIButton!
    var JobCategories_Button_Completion_Count = 0
    
    @IBAction func JobCategories_Button_Tapped(_ sender: UIButton) {
        
        
        
        //Create Alert Controller
        let alert = UIAlertController(title: "職務類別", message: "請選擇您的職務類別", preferredStyle: UIAlertControllerStyle.alert)
        
        //Create 經營/人資類 Action
        let HR = UIAlertAction(title: "經營/人資類", style: UIAlertActionStyle.default) { (action: UIAlertAction) -> Void in
            
            
            //Write data to Firebase database
            self.ref = FIRDatabase.database().reference(withPath: "ID/\(self.uid)/Profile/Job-Category")
            
            self.ref.setValue("經營/人資類")
            
            
            self.JobCategories_Button.alpha = 0.20
            
            if self.JobCategories_Button_Completion_Count == 0 {
                
                self.SignUpCompletionProgressView_Count += 10/90 // 1.0(100%) / 9(items) / 10(0.0 - 1.0)
                self.Master_SignUp_Button_Completion_Count += 1
            }
            
            self.JobCategories_Button_Completion_Count = 1
            
            self.updateSignUpCompletionProgressView()
            
            
            
        }
        
        alert.addAction(HR)
        
        
        
        //Create 行政/總務/法務類 Action
        let AD = UIAlertAction(title: "行政/總務/法務類", style: UIAlertActionStyle.default) { (action: UIAlertAction) -> Void in
            
            
            //Write data to Firebase database
            self.ref = FIRDatabase.database().reference(withPath: "ID/\(self.uid)/Profile/Job-Category")
            
            self.ref.setValue("行政/總務/法務類")
            
            
            self.JobCategories_Button.alpha = 0.20
            
            if self.JobCategories_Button_Completion_Count == 0 {
                
                self.SignUpCompletionProgressView_Count += 10/90 // 1.0(100%) / 9(items) / 10(0.0 - 1.0)
                self.Master_SignUp_Button_Completion_Count += 1
            }
            
            self.JobCategories_Button_Completion_Count = 1
            
            self.updateSignUpCompletionProgressView()
            
            
            
        }
        
        alert.addAction(AD)
        
        
        
        //Create 資訊軟體系統類 Action
        let CS = UIAlertAction(title: "資訊軟體系統類", style: UIAlertActionStyle.default) { (action: UIAlertAction) -> Void in
            
            
            //Write data to Firebase database
            self.ref = FIRDatabase.database().reference(withPath: "ID/\(self.uid)/Profile/Job-Category")
            
            self.ref.setValue("資訊軟體系統類")
            
            
            self.JobCategories_Button.alpha = 0.20
            
            if self.JobCategories_Button_Completion_Count == 0 {
                
                self.SignUpCompletionProgressView_Count += 10/90 // 1.0(100%) / 9(items) / 10(0.0 - 1.0)
                self.Master_SignUp_Button_Completion_Count += 1
            }
            
            self.JobCategories_Button_Completion_Count = 1
            
            self.updateSignUpCompletionProgressView()
            
            
            
        }
        
        alert.addAction(CS)
        
        
        
        
        
        //Create Cancel Action
        let cancel = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler: nil)
        
        alert.addAction(cancel)
        
        
        
        
        //Present Alert Controller
        self.present(alert, animated: true, completion: nil)
        
        
        
        
    }
    
    
    
    var Gender_Button_Completion_Count = 0
    @IBOutlet weak var Man_Button: UIButton!
    @IBAction func Man_Button_Tapped(_ sender: UIButton) {
        
        
        //Write data to Firebase database
        self.ref = FIRDatabase.database().reference(withPath: "ID/\(self.uid)/Profile/Gender")
        
        self.ref.setValue("男")
        
        
        self.Man_Button.alpha = 0.20
        
        Woman_Button.alpha = 0.80
        
        if self.Gender_Button_Completion_Count == 0 {
            
            self.SignUpCompletionProgressView_Count += 10/90 // 1.0(100%) / 9(items) / 10(0.0 - 1.0)
            self.Master_SignUp_Button_Completion_Count += 1
        }
        
        self.Gender_Button_Completion_Count = 1
        
        self.updateSignUpCompletionProgressView()
        
        
    }
    
    @IBOutlet weak var Woman_Button: UIButton!
    @IBAction func Woman_Button_Tapped(_ sender: UIButton) {
        
        //Write data to Firebase database
        self.ref = FIRDatabase.database().reference(withPath: "ID/\(self.uid)/Profile/Gender")
        
        self.ref.setValue("女")
        
        
        self.Woman_Button.alpha = 0.20
        
        Man_Button.alpha = 0.80
        
        if self.Gender_Button_Completion_Count == 0 {
            
            self.SignUpCompletionProgressView_Count += 10/90 // 1.0(100%) / 9(items) / 10(0.0 - 1.0)
            self.Master_SignUp_Button_Completion_Count += 1
        }
        
        self.Gender_Button_Completion_Count = 1
        
        self.updateSignUpCompletionProgressView()
        
        
    }
    
    @IBOutlet weak var SignUp_Progress_Bar: UIProgressView!
    
    
    
    var Master_SignUp_Button_Completion_Count = 0 //要大於 9，完成鈕才能給予通過
    var confirmMessage = "" //資料全部填寫完成，讓使用者確認資料的訊息內容
    @IBAction func SignUp_Completion_Button_Tapped(_ sender: UIButton) {
        
        
        
        
        if Master_SignUp_Button_Completion_Count > 8 {
            
            
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
            ref.observe(.value, with: { snapshot in (tempString = snapshot.value as! String, self.showConfirmationPage())
            })

            
            
            
            
            
            
            
            
            
        } else {
            
            //####提醒尚未完成之項目
            
            
            
            //Create Alert Controller
            let alert = UIAlertController(title: "還有項目沒有填完唷！", message: "填寫完整資料，讓大家更容易認識你。", preferredStyle: UIAlertControllerStyle.alert)
            
            //Create confirm Action
            let confirm = UIAlertAction(title: "繼續填寫註冊資料", style: UIAlertActionStyle.default) { (action: UIAlertAction) -> Void in
                
            }
            
            alert.addAction(confirm)
            
            
            
            
            
            //Present Alert Controller
            self.present(alert, animated: true, completion: nil)
            

            
        }
        
        
    }
    
    func composeConfirmationMessage(newString: String){
        
        confirmMessage += newString
        
    }
    
    
    
    func showConfirmationPage(){
        
        
        //Create Alert Controller
        let alert = UIAlertController(title: "註冊資料確認", message: confirmMessage, preferredStyle: UIAlertControllerStyle.alert)
        
        //Create confirm Action
        let confirm = UIAlertAction(title: "確定", style: UIAlertActionStyle.default) { (action: UIAlertAction) -> Void in
            
            //Open LogInViewController
            let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LogInViewControllerID") as! LogInViewController
            self.addChildViewController(popOverVC)
            popOverVC.view.frame = self.view.frame
            self.view.addSubview(popOverVC.view)
            popOverVC.didMove(toParentViewController: self)
            
            
        }
        
        alert.addAction(confirm)
        
        
        
        
        
        
        //Create Cancel Action
        let cancel = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel) { (action: UIAlertAction) -> Void in self.confirmMessage = ""
        }
        
        alert.addAction(cancel)
        
        
        
        
        //Present Alert Controller
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    
    //--->###### Merge 後刪除
    @IBOutlet weak var jobTextLabel: UILabel!
    var myJob = "尚未選取"
    //<---###### Merge 後刪除
    
    
    
    @IBOutlet weak var SignUpCompletionProgressView: UIProgressView!
    var uid = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Initialize count for SignUpCompletionProgressView
        SignUpCompletionProgressView_Count = 0
        
        jobTextLabel.text = myJob
        
        jobTextLabel.transform = CGAffineTransform(rotationAngle: -0.24)
        
        
        //Just to make sure confirmation page doesn't load before the app is done importing data from Firebase
        //拿 UID
        if let user = FIRAuth.auth()?.currentUser {
            
            uid = user.uid  // The user's ID, unique to the Firebase project.
            // Do NOT use this value to authenticate with
            // your backend server, if you have one. Use
            // getTokenWithCompletion:completion: instead.
        } else {
            // No user is signed in.
        }
        
        
        
        self.ref = FIRDatabase.database().reference(withPath: "ID/\(uid)/Profile/Safety-Check")
        self.ref.setValue("ON")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateSignUpCompletionProgressView() {
        
        
        SignUpCompletionProgressView.progress = Float(SignUpCompletionProgressView_Count)
        
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
