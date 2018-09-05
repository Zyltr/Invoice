//
//  ViewController.swift
//  Invoice
//
//  Created by Erik Huerta on 8/29/18.
//  Copyright © 2018 Zyltr. All rights reserved.
//

import Cocoa

class MainViewController: NSViewController {
    
    @IBOutlet weak var tabView: NSTabView!
    
    enum TabIdentifer : String {
        case Single
        case Batch
    }
    
    enum SegueIdentifier : String {
        case SingleSegue
        case BatchSegue
    }
    
    private var singleViewController : SingleViewController!
    private var batchViewController : BatchViewController!
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    override func viewDidLoad () {
        super.viewDidLoad ()
        
        // Do any additional setup after loading the view.
    }
    
    override func prepare (for segue: NSStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier?.rawValue, let type = SegueIdentifier (rawValue: identifier) {
            switch type {
            case .BatchSegue:
                self.batchViewController = segue.destinationController as! BatchViewController
            case .SingleSegue:
                self.singleViewController = segue.destinationController as! SingleViewController
            }
        }
    }
    
    @IBAction private func printInvoice (_ sender: Any?) {
        if let identifier = self.tabView.selectedTabViewItem?.identifier as? String, let type = TabIdentifer (rawValue: identifier) {
            switch type {
            case .Batch:
                Swift.print ("Printing Batch")
                if let invoices = self.batchViewController.invoices (), invoices.count > 0 {
                     Swift.print("Printing \(invoices.count) invoice(s)")
                    let view = BatchView (invoices: invoices, date: self.batchViewController.invoiceDate())
                    NSPrintOperation (view: view).run ()
                }
            case .Single:
                Swift.print ("Printing Single")
                self.singleViewController.endTextFieldEditing ()
                NSPrintOperation (view: self.singleViewController.view).run ()
            }
        }
    }
    
    @IBAction func helpButtonPressed(_ sender: Any) {
        if let identifier = self.tabView.selectedTabViewItem?.identifier as? String, let type = TabIdentifer (rawValue: identifier) {
            switch type {
            case .Batch:
                let identifier = NSStoryboardSegue.Identifier ("BatchHelpSegue")
                self.performSegue(withIdentifier: identifier, sender: self)
            case .Single:
                let identifier = NSStoryboardSegue.Identifier ("SingleHelpSegue")
                self.performSegue (withIdentifier: identifier, sender: self)
            }
        }
    }
    
}

