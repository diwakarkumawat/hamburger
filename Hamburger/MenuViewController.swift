//
//  MenuViewController.swift
//  Hamburger
//
//  Created by Kumawat, Diwakar on 4/21/17.
//  Copyright © 2017 Kumawat, Diwakar. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    private var greenNavController: UIViewController!
    private var blueNavController: UIViewController!
    private var pinkNavController: UIViewController!
    
    var viewControllers: [UIViewController] = []
    var images: [UIImage] = []
    
    var hamburgerViewController: HamburgerViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        greenNavController = storyboard.instantiateViewController(withIdentifier: "greenNavController")
        pinkNavController = storyboard.instantiateViewController(withIdentifier: "pinkNavController")
        blueNavController = storyboard.instantiateViewController(withIdentifier: "blueNavController")
        
        
        viewControllers.append(greenNavController)
        viewControllers.append(pinkNavController)
        viewControllers.append(blueNavController)
        
        
        // ui images
        images.append(UIImage(named: "Circled User Male-64.png")!)
        images.append(UIImage(named: "Timeline-48.png")!)
        images.append(UIImage(named: "VIP-40.png")!)
        
        hamburgerViewController.contentViewController = pinkNavController
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
        
        let titles = ["Profile", "Timeline", "Mentions"]
        print(indexPath.row)
        
        if indexPath.row == 0 {
            cell.menuLabel.text = User._currentUser?.name! as String?
            cell.menuImage.setImageWith((User._currentUser?.profileImageUrl as? URL)!)
        } else {
            cell.menuLabel.text = titles[indexPath.row]
            cell.menuImage.image = images[indexPath.row]
        }
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        hamburgerViewController.contentViewController = viewControllers[indexPath.row]
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
