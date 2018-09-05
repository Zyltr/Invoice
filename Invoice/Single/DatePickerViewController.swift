//
//  DatePickerViewController.swift
//  Invoice
//
//  Created by Erik Huerta on 8/30/18.
//  Copyright © 2018 Zyltr. All rights reserved.
//

import Cocoa

protocol DatePickerViewControllerDelegate {
    func updateButtonPushed(sender: DatePickerViewController)
}

class DatePickerViewController: NSViewController {

    @objc dynamic var date : Date?
    
    var delegate : DatePickerViewControllerDelegate?
    
    override func viewDidLoad () {
        super.viewDidLoad ()
        // Do view setup here.
    }
    
    @IBAction func updateButtonPushed (_ sender: Any) {
        if let delegate = self.delegate {
            delegate.updateButtonPushed (sender: self)
        }
        
        dismissViewController (self)
    }
    
}
