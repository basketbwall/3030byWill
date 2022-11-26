//
//  ViewController.swift
//  3030byWill
//
//  Created by William Huang on 11/26/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtDuration: UITextField!
    
    @IBOutlet weak var Table: UITableView!
    
    var TimeBlocks : [TimeBlock] = [
        TimeBlock(Duration: "00:30", Name: "Reading"),
        TimeBlock(Duration: "00:50", Name: "Math"),
        TimeBlock(Duration: "00:40", Name: "Relax")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.red
        Table.dataSource = self
    }

    @IBAction func GoNextClicked(_ sender: UIButton) {
        self.performSegue(withIdentifier: "GoToPlay", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToPlay" {
            let destinationVC = segue.destination as! PlayViewController
            destinationVC.TimeBlocks = TimeBlocks
        }
    }
    
    @IBAction func AddClicked(_ sender: UIButton) {
        if let duration = txtDuration.text, let name = txtName.text {
            let newTimeBlock = TimeBlock(Duration: duration, Name: name)
            TimeBlocks.append(newTimeBlock)
//            print(TimeBlocks)
            
            DispatchQueue.main.async {
                self.Table.reloadData()
            }
        }
        
        
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TimeBlocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Table.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath)
        cell.textLabel?.text = TimeBlocks[indexPath.row].Name + TimeBlocks[indexPath.row].Duration
        return cell
    }
    
    
}

