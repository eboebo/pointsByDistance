//
//  ViewController.swift
//  PointsByDistance
//
//  Created by Elena Boyd on 1/7/15.
//  Copyright (c) 2015 Whole Foods. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {

    var pointItemList:[PointItem]
    = [PointItem(title: "A", x:0.0, y:0.0),
    PointItem(title:"B", x:1.0, y:1.0),
    PointItem(title:"C", x:4.5, y:3.2),
    PointItem(title:"D", x:2.0, y:3.0),
    PointItem(title:"E", x:-1.3, y:-1.4),
    PointItem(title:"F", x:-4.5, y:2.2),
    PointItem(title:"G", x:1.0, y:-3.0)]
    
    var currentPointItem : PointItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pointItemList.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "CellIdentifier")
        var pointItem = pointItemList[indexPath.row]
        cell.textLabel?.text = pointItem.title;
        if self.currentPointItem != nil {
            var detailText = String(format: "%.2f", pointItem.distanceFromPointItem(self.currentPointItem))
            cell.detailTextLabel?.text = detailText
        }
        return cell
    }
    
    // insertion sort
    func sortByDistance(currentPointItem : PointItem) {
        for (index, value) in enumerate(self.pointItemList) {
            let indexDistance = value.distanceFromPointItem(currentPointItem)
            var j = index;
            var insertionIndex = index
            while (j > 0 && indexDistance < self.pointItemList[j - 1].distanceFromPointItem(currentPointItem)) {
                j = j - 1
                insertionIndex = 1
            }
            
            if insertionIndex < index {
                self.pointItemList.removeAtIndex(index)
                self.pointItemList.insert(value, atIndex:insertionIndex)
            }
        }
    }
    
    @IBAction func setCurrentLocation(sender: AnyObject) {
        let alertController = UIAlertController(title: "Enter Location", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        let locationAction = UIAlertAction(title: "Set Location", style: .Default) { (action) in
            let xTextField = alertController.textFields![0] as UITextField
            let xString = xTextField.text as NSString
            let yTextField = alertController.textFields![1] as UITextField
            let yString = yTextField.text as NSString
            self.currentPointItem = PointItem(title: "current", x: xString.doubleValue, y: yString.doubleValue)
            self.sortByDistance(self.currentPointItem)
            self.tableView.reloadData()

        }
        alertController.addAction(locationAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style:.Cancel) { (action) in }
        alertController.addAction(cancelAction)
    
        alertController.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = "Enter X"
        }
        
        alertController.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = "Enter Y"
        }
        
        self.presentViewController(alertController, animated:true) { }
        
    }

}

