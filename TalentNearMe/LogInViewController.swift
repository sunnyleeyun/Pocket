//
//  LogInViewController.swift
//  TalentNearMe
//
//  Created by M.A.D. Crew on 23/10/2016.
//  Copyright © 2016 M.A.D. Crew. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import CoreLocation

class LogInViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var Logo_Picture: UIImageView!
    
    @IBOutlet weak var LogIn_Account: UITextField!
    @IBOutlet weak var LogIn_Password: UITextField!
    var uid = ""
    
    @IBAction func Auto_LogIn_Switch(_ sender: UISwitch) {
        
    }
    
    @IBAction func LogIn_Button_Tapped(_ sender: UIButton) {
        
        // 檢查 帳號跟密碼欄，是否確實有填寫 (ps 帳號欄，目前是用email代替QQ
        if self.LogIn_Account.text == "" || self.LogIn_Password.text == ""{
            let alertController = UIAlertController(title:"Oops!", message: "Please enter Account & password", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title:"OK!", style: .cancel, handler:nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated:true,completion:nil)
        }else{
            FIRAuth.auth()?.signIn(withEmail: self.LogIn_Account.text!, password: self.LogIn_Password.text!, completion:{(user,error) in
                
                if error == nil{
                    
                    //拿 UID
                    self.uid = ""
                    if let user = FIRAuth.auth()?.currentUser {
                        
                        self.uid = user.uid  // The user's ID, unique to the Firebase project.
                        // Do NOT use this value to authenticate with
                        // your backend server, if you have one. Use
                        // getTokenWithCompletion:completion: instead.
                        
                        /////////////////
                        
                        var ref = FIRDatabase.database().reference(withPath: "Online-Status/\(self.uid)")
                        ref.setValue("ON")
                        //ref.updateChildValues()
                        //ref.setValue(nil)
 
                        /////////////
                        
                    } else {
                        // No user is signed in.
                    }
                    
                    
                    
                    var ref = FIRDatabase.database().reference(withPath: "ID/\(self.uid)/Profile/Safety-Check")
                    ref.setValue("ON")
                    
                    
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let nextVC = storyboard.instantiateViewController(withIdentifier: "UITabControllerID")as! UITabBarController
                    self.present(nextVC,animated:true,completion:nil)
                    
                    print("========================Successful already have a account in Firebase!!")
 
 
                    
                }else{
                    let alertController = UIAlertController(title:"Oops!", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title:"OK!", style: .cancel, handler:nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated:true,completion:nil)
                }
            })
        }
       

  
    }

    @IBAction func SignUp_Button_Tapped(_ sender: UIButton) {
        // 檢查 帳號跟密碼欄，是否確實有填寫
        if self.LogIn_Account.text == "" || self.LogIn_Password.text == ""{
            let alertController = UIAlertController(title:"Oops!", message: "Please enter Account & password", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title:"OK!", style: .cancel, handler:nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated:true,completion:nil)
        }else{
            
            // 在Firebase的Auth中，新增使用戶
            FIRAuth.auth()?.createUser(withEmail: self.LogIn_Account.text!, password: self.LogIn_Password.text!, completion: {(user,error) in
                
                if error == nil{

                    
                    //拿 UID
                    self.uid = ""
                    if let user = FIRAuth.auth()?.currentUser {
                        
                        self.uid = user.uid  // The user's ID, unique to the Firebase project.
                        // Do NOT use this value to authenticate with
                        // your backend server, if you have one. Use
                        // getTokenWithCompletion:completion: instead.
                    } else {
                        // No user is signed in.
                    }
                    
                    
                    
                    var ref = FIRDatabase.database().reference(withPath: "ID/\(self.uid)/Profile/Safety-Check")
                    ref.setValue("ON")
                    

                    

                    //跳到註冊頁
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let nextVC = storyboard.instantiateViewController(withIdentifier: "SignUpViewControllerID")as! SignUpViewController
                    self.present(nextVC,animated:true,completion:nil)
        
                    
                }else{
                    let alertController = UIAlertController(title:"Oops!", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title:"OK!", style: .cancel, handler:nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated:true,completion:nil)
                }
            })
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // 使用者登出
        try!FIRAuth.auth()?.signOut()
        //Animate the logo when the app first launches.
        self.Logo_Picture.transform = CGAffineTransform.init(scaleX: 4.3, y: 4.3)
        self.Logo_Picture.alpha = 0.0
        
        UIView.animate(withDuration: 1.50, animations: {
            self.Logo_Picture.alpha = 1.0
            self.Logo_Picture.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
        })
        
        
   /*
        var locationManager: CLLocationManager = CLLocationManager()
        
        // Ask for Authorisation from the User.
        locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        locationManager.requestWhenInUseAuthorization()
        
        
            if CLLocationManager.locationServicesEnabled() {
        //locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        }*/
        
        
        //讓目前使用者的帳號顯現
        if let user = FIRAuth.auth()?.currentUser{
            self.LogIn_Account.text = user.email
        }else{
            self.LogIn_Account.text = ""
        }
         self.hideKeyboardWhenTappedAround()
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

// Function to hide keyboard when touching anywhere else
extension UIViewController {
       func hideKeyboardWhenTappedAround() {
                let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
                view.addGestureRecognizer(tap)
            }
    
        func dismissKeyboard() {
                view.endEditing(true)
            }
    }
