//
//  GuestViewController.swift
//  Dancing Dream
//
//  Created by Wade Li on 4/6/19.
//  Copyright © 2019 Wade Li. All rights reserved.
//

import UIKit

class GuestViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableV: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableV.dequeueReusableCell(withIdentifier: "InfoCell") as! InfoCell
        cell.nameF.text = "A"
        cell.addressF.text = "110-24 MC"
        cell.phoneF.text = "555-555-5555"
        cell.styleF.text = "Tap"
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableV.dataSource = self
        tableV.delegate = self
        guard let path = Bundle.main.path(forResource: "s", ofType: "txt") else { return }
        let url = URL(fileURLWithPath: path)
        do {
            let data = try Data(contentsOf: url)
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            guard let array = json as? [Any] else { return }
            for user in array{
                guard let userDict = user as? [String: Any] else { return }
                guard let userText = userDict["text"] as? [String: Any] else { return }
                print(userDict)
            }
        }
        catch {
            print(error)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
