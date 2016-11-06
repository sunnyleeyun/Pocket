//
//  FirstViewController.swift
//  TalentNearMe
//
//  Created by M.A.D. Crew. on 21/10/2016.
//  Copyright © 2016 M.A.D. Crew. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import Foundation
import Firebase
import FirebaseDatabase
import FirebaseAuth
//import CLLocation


class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    @IBOutlet weak var myMap: MKMapView!
    var locationManager: CLLocationManager = CLLocationManager()
    
    @IBOutlet weak var currentUID: UILabel!
    
    var uid = ""
    //Initialization for Firebase database
    var ref: FIRDatabaseReference!
    
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is PinAnnotation {
            
            
            //print("WE GOT IN 國國國國國國國國國國國國國")
            let annotation1 = MKPointAnnotation()
            annotation1.coordinate = CLLocationCoordinate2D(latitude: 25.034039, longitude: 121.564553)
            
            
            let pinAnnotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "myPin")
            
            if #available(iOS 9.0, *) {
                pinAnnotationView.pinTintColor = .purple
            } else {
                // Fallback on earlier versions
            }
            pinAnnotationView.isDraggable = true
            pinAnnotationView.canShowCallout = true
            //pinAnnotationView.animatesDrop = true
            pinAnnotationView.image = UIImage(named: "Man_1")
            
            
            let profile_picture = UIImageView()
            profile_picture.image = UIImage(named: "Man_1")
            profile_picture.frame.size.width = 44
            profile_picture.frame.size.height = 44
            profile_picture.backgroundColor = UIColor.clear
            
            
            
            let detail = UIButton(type: UIButtonType.custom)
            detail.frame.size.width = 44
            detail.frame.size.height = 44
            detail.backgroundColor = UIColor.blue
            detail.setImage(UIImage(named: "dots"), for: .normal)
            
            
            pinAnnotationView.leftCalloutAccessoryView = profile_picture
            pinAnnotationView.rightCalloutAccessoryView = detail
            
            
            
            
            
            return pinAnnotationView
        }
        
        return nil
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if let annotation = view.annotation as? PinAnnotation {
            //mapView.removeAnnotation(annotation)
            print("機機機機機機機機機機機機機機機機機機機機機機機機機機")
            
            
            
            
            
            let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BusinessCardPopUpID") as! BasicContactViewController
            



            
            self.addChildViewController(popOverVC)
            
            popOverVC.view.frame = self.view.frame
            self.view.addSubview(popOverVC.view)
            popOverVC.didMove(toParentViewController: self)
            

            

            
            /*
             myMap.removeAnnotation(annotation)
             let annotation2 = MKPointAnnotation()
             annotation2.coordinate = CLLocationCoordinate2D(latitude: 25.035368, longitude: 121.562615)
             myMap.removeAnnotation(annotation2)
             
             self.myMap.addAnnotation(annotation2)
             */
            
            /*
             let pinAnnotation = PinAnnotation()
             pinAnnotation.setCoordinate(newCoordinate: annotation.coordinate)
             
             myMap.addAnnotation(pinAnnotation)
             */
            
            
            
            
            
            
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let lastLocation: CLLocation = locations[locations.count - 1]
        /*
         latitudeLabel.text = String(format: "%.6f", lastLocation.coordinate.latitude)
         longitudeLabel.text = String(format: "%.6f", lastLocation.coordinate.longitude)
         */
        
        print("Lat = \(String(format: "%.6f", lastLocation.coordinate.latitude))")
        print("Long = \(String(format: "%.6f", lastLocation.coordinate.longitude))")
        
        // This should match your CLLocationManager()
        manager.stopUpdatingLocation()
        manager.startUpdatingLocation()
        
    }
    

    
    func keepUploadingMyLocation(){
        print("UPLOADINGGGGGGGGGGG")
        
        //拿 UID
        if let user = FIRAuth.auth()?.currentUser {
            
            uid = user.uid  // The user's ID, unique to the Firebase project.
            // Do NOT use this value to authenticate with
            // your backend server, if you have one. Use
            // getTokenWithCompletion:completion: instead.
        } else {
            // No user is signed in.
        }

        //print("UPloadingMyLocation, and the UID is \(uid)")
        //Write data to Firebase database
        //locationManager.stopUpdatingLocation()
        //locationManager.startUpdatingLocation()
        //locationManager(manager: locationManager, didUpdateLocations: [CLLocation])
        var ref = FIRDatabase.database().reference(withPath: "ID/\(self.uid)/Profile/Current-Location/Latitude")
        var myCurrentLatitude = (locationManager.location?.coordinate.latitude)!
        ref.setValue(myCurrentLatitude)
ref.setValue(myCurrentLatitude, withCompletionBlock:
     {(Error, FIRDatabaseReference) -> Void in
        print("CAN'T UPLOAD, Error: \(Error)")
        
    })
        
        print("New MYPIN is at: \(myCurrentLatitude)")
        
    
        
        //Write data to Firebase database
        ref = FIRDatabase.database().reference(withPath: "ID/\(self.uid)/Profile/Current-Location/Longitude")
        var myCurrentLongitude = locationManager.location?.coordinate.longitude
        ref.setValue(myCurrentLongitude!)
    }
    
    
    
    var statusAccount = ""
    func keepFetchingFriendsLocation(){
        
                print("FETCHTING!!!!!")
        /*
        let allAnnotations = self.myMap.annotations
        self.myMap.removeAnnotations(allAnnotations)
        */
        
        //Iterate through Firebase Database
        FIRDatabase.database().reference().child("Online-Status").observe(.value, with: { snapshot in
            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for child in snapshots {
                    
                    var status = child.value as! String
                    self.statusAccount = child.key as! String
                    if (status == "ON" && self.statusAccount != self.uid){
                        //print("是我啦呵呵")
                        
                        //self.performSegue(withIdentifier: "showBusinessCardSegue", sender: self.statusAccount)
                        
                        Manager.messageText = self.statusAccount
                      
                        
                        self.currentUID.text = self.statusAccount
                        //Initialization for Firebase database
                        var ref: FIRDatabaseReference!
                        //Retrieve data from Firebase database
                        ref = FIRDatabase.database().reference(withPath: "ID/\(self.statusAccount)/Profile/Current-Location/Latitude")
                        
                        
                        var lat = self.locationManager.location?.coordinate.latitude
                        
                        ref.observe(.value, with: { snapshot in (lat = snapshot.value as? Double)
                        })
                        
                        ref = FIRDatabase.database().reference(withPath: "ID/\(self.statusAccount)/Profile/Current-Location/Longitude")
                        
                        var longi = self.locationManager.location?.coordinate.longitude
                        
                        ref.observe(.value, with: { snapshot in (longi = snapshot.value as? Double)
                        })
                        
                        
                        let annotation = MKPointAnnotation()
                        annotation.coordinate = CLLocationCoordinate2D(latitude: lat!, longitude: longi!)
                        
                        let pinAnnotation = PinAnnotation()
                        pinAnnotation.setCoordinate(newCoordinate: annotation.coordinate)
                        pinAnnotation.updateProfileInto(currentNeighbor: self.statusAccount)
                        
                        
                       // print("New pin added, at \(annotation.coordinate)")
                        
                        self.myMap.addAnnotation(pinAnnotation)
                        
                        //pin dropped, test with mlutiple accounts
                        
                    } else if status == "OFF" {
                        
                        /*
                         //myMap.removeAnnotation(annotation)
                         
                         let pinAnnotation = PinAnnotation()
                         //pinAnnotation.setCoordinate(newCoordinate: annotation.coordinate)
                         pinAnnotation.updateProfileInto(currentNeighbor: statusAccount)
                         
                         let annotationsToRemove = self.myMap.annotations.filter { $0 as? String == pinAnnotation.annotationID }
                         self.myMap.removeAnnotations( annotationsToRemove )
                         
                         */
                        
                        
                    }
                    
                }
            }
            
        })
        
        /*
         //Drop That PIN!!!
         let annotation = MKPointAnnotation()
         annotation.coordinate = CLLocationCoordinate2D(latitude: 25.034039, longitude: 121.564553)
         
         let pinAnnotation = PinAnnotation()
         pinAnnotation.setCoordinate(newCoordinate: annotation.coordinate)
         
         myMap.addAnnotation(pinAnnotation)
         */
        
        
        
        
        myMap.showAnnotations(myMap.annotations, animated: true)
        myMap.delegate = self
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        //拿 UID
        if let user = FIRAuth.auth()?.currentUser {
            
            uid = user.uid  // The user's ID, unique to the Firebase project.
            // Do NOT use this value to authenticate with
            // your backend server, if you have one. Use
            // getTokenWithCompletion:completion: instead.
        } else {
            // No user is signed in.
        }
        
        
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        if CLLocationManager.locationServicesEnabled() {
            
            //locationManager.startUpdatingLocation()
            //設定預設地圖大小
            let span = MKCoordinateSpanMake(0.075, 0.075)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: (locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!), span: span)
            myMap.setRegion(region, animated: true)
            
            var timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(MapViewController.keepUploadingMyLocation), userInfo: nil, repeats: true)
            
            var timer2 = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(MapViewController.keepFetchingFriendsLocation), userInfo: nil, repeats: true)
            
            
            
            
            
        }
        
        
        
        
        
        
        
        
        /*
         //設定中心點為 台北101
         let annotation = MKPointAnnotation()
         annotation.coordinate = CLLocationCoordinate2D(latitude: 25.034039, longitude: 121.564553)
         //self.myMap.addAnnotation(annotation)
         */
        
        /*
         //設定中心點為 君悅
         let annotation2 = MKPointAnnotation()
         annotation2.coordinate = CLLocationCoordinate2D(latitude: 25.035368, longitude: 121.562615)
         self.myMap.addAnnotation(annotation2)
         */
        
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func showPopUp_Woman(_ sender: UIButton) {
        
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BusinessCardPopUpID") as! BasicContactViewController
        
        self.addChildViewController(popOverVC)
        
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)
        
    }
    
    @IBAction func showPopUp_Man(_ sender: UIButton) {
        
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BusinessCardPopUpID") as! BasicContactViewController
        
        self.addChildViewController(popOverVC)
        
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)
        
        /*
         //設定預設地圖大小
         let span = MKCoordinateSpanMake(0.075, 0.075)
         let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: (locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!), span: span)
         myMap.setRegion(region, animated: true)
         */
    }
    
    

    
}




class PinAnnotation : NSObject, MKAnnotation {
    private var coord: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    
    var coordinate: CLLocationCoordinate2D {
        get {
            return coord
        }
    }
    
    
    
    var title: String? = "A"
    var subtitle: String? = "B"
    
    var annotationID: String? = "C"
    
    func updateProfileInto(currentNeighbor: String){
        
        //Initialization for Firebase database
        var ref: FIRDatabaseReference!
        //Retrieve data from Firebase database
        ref = FIRDatabase.database().reference(withPath: "ID/\(currentNeighbor)/Profile/Real-Name")
        ref.observe(.value, with: { snapshot in (self.title = snapshot.value as? String)
        })
        ref = FIRDatabase.database().reference(withPath: "ID/\(currentNeighbor)/Profile/Job-Description")
        ref.observe(.value, with: { snapshot in (self.subtitle = snapshot.value as? String)
        })
        
        annotationID = currentNeighbor
        
    }
    
    
    
    func setCoordinate(newCoordinate: CLLocationCoordinate2D) {
        
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: 25.034039, longitude: 121.564553)
        
        //self.coord = annotation.coordinate
        self.coord = newCoordinate
        
        
        var uid = ""
        //拿 UID
        if let user = FIRAuth.auth()?.currentUser {
            
            uid = user.uid  // The user's ID, unique to the Firebase project.
            // Do NOT use this value to authenticate with
            // your backend server, if you have one. Use
            // getTokenWithCompletion:completion: instead.
        } else {
            // No user is signed in.
        }
        
        //Initialization for Firebase database
        var ref: FIRDatabaseReference!
        //Retrieve data from Firebase database
        ref = FIRDatabase.database().reference(withPath: "ID/\(uid)/Profile/Real-Name")
        ref.observe(.value, with: { snapshot in (self.title = snapshot.value as? String)
        })
        ref = FIRDatabase.database().reference(withPath: "ID/\(uid)/Profile/Job-Description")
        ref.observe(.value, with: { snapshot in (self.subtitle = snapshot.value as? String)
        })
        
        
    }
    

}



