//
//  JobCategoriesViewController.swift
//  TalentNearMe
//
//  Created by M.A.D. Crew on 2016/10/23.
//  Copyright © 2016年 M.A.D. Crew. All rights reserved.
//

import UIKit

class JobCategoriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    var jobCategory = ["批發","大眾","文教","電子"]

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobCategory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        print(indexPath.row)
        cell.textLabel?.text = jobCategory[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "jobSegue", sender: jobCategory[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let guest = segue.destination as! SignUpViewController
        
        guest.myJob = sender as! String
    }


}
