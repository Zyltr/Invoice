//
//  SingleViewController.swift
//  Invoice
//
//  Created by Erik Huerta on 8/30/18.
//  Copyright © 2018 Zyltr. All rights reserved.
//

import Cocoa

class SingleViewController: NSViewController, DatePickerViewControllerDelegate {
    private static let numberFormatter = NumberFormatter()
    
    /* Important NSTextField Variables */
    private var activeTextField : NSTextField?
    private var activeText : NSText?
    
    /* Invoice Variables */
    @objc private dynamic var name : String = String ()
    @objc private dynamic var address : String = String ()
    @objc private dynamic var forMonth : String = String ()
    @objc private dynamic var firstNote : String = String ()
    @objc private dynamic var secondNote : String = String ()
    @objc private dynamic var gardener : String = String ()
    
    @objc private dynamic var total : Double = Double ()
    
    @objc private dynamic var date : Date = Date () {
        didSet {
            let currentMonth = Calendar.current.component (.month, from: self.date) - 1
            self.forMonth = "for " + Calendar.current.monthSymbols[currentMonth]
        }
    }
    
    @objc private dynamic var lawnService : NSNumber = NSNumber () {
        didSet {
            updateTotal (oldValue: oldValue, newValue: self.lawnService)
        }
    }
    
    @objc private dynamic var pruneAndTrim : NSNumber = NSNumber () {
        didSet {
            updateTotal (oldValue: oldValue, newValue: self.pruneAndTrim)
        }
    }
    
    @objc private dynamic var cleanUp : NSNumber = NSNumber () {
        didSet {
            updateTotal (oldValue: oldValue, newValue: self.cleanUp)
        }
    }
    
    @objc private dynamic var fertilizer : NSNumber = NSNumber () {
        didSet {
            updateTotal (oldValue: oldValue, newValue: self.fertilizer)
        }
    }
    
    @objc private dynamic var seedAndTopping : NSNumber = NSNumber () {
        didSet {
            updateTotal (oldValue: oldValue, newValue: self.seedAndTopping)
        }
    }
    
    @objc private dynamic var plantsAndColor : NSNumber = NSNumber () {
        didSet {
            updateTotal (oldValue: oldValue, newValue: self.plantsAndColor)
        }
    }
    @objc private dynamic var irrigationSprinklers : NSNumber = NSNumber () {
        didSet {
            updateTotal (oldValue: oldValue, newValue: self.irrigationSprinklers)
        }
    }
    
    @objc private dynamic var planterWork : NSNumber = NSNumber () {
        didSet {
            updateTotal (oldValue: oldValue, newValue: self.planterWork)
        }
    }
    
    @objc private dynamic var spray : NSNumber = NSNumber () {
        didSet {
            updateTotal (oldValue: oldValue, newValue: self.spray)
        }
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    override func viewDidLoad () {
        super.viewDidLoad ()
        
        // Do any additional setup after loading the view.
        NSPrintInfo.shared.topMargin = 36.0
        NSPrintInfo.shared.leftMargin = 36.0
        NSPrintInfo.shared.rightMargin = 36.0
        NSPrintInfo.shared.bottomMargin = 36.0
        
        NSPrintInfo.shared.paperSize = NSMakeSize (419.5, 595.3)
        
        NSPrintInfo.shared.horizontalPagination = .fitPagination
        NSPrintInfo.shared.verticalPagination = .fitPagination
        
        NSPrintInfo.shared.isHorizontallyCentered = true
        NSPrintInfo.shared.isVerticallyCentered = true
        
        let currentMonth = Calendar.current.component (.month, from: self.date) - 1
        self.forMonth = "for " + Calendar.current.monthSymbols[currentMonth]
    }
    
    override func prepare (for segue: NSStoryboardSegue, sender: Any?) {
        if let dest = segue.destinationController as? DatePickerViewController {
            dest.date = self.date
            dest.delegate = self
        }
    }
    
    override func controlTextDidBeginEditing (_ obj: Notification) {
        if let textField = obj.object as? NSTextField, let text = obj.userInfo?["NSFieldEditor"] as? NSText {
            self.activeTextField = textField
            self.activeText = text
        }
    }
    
   func endTextFieldEditing () {
        if let textField = activeTextField, let text = activeText {
            textField.endEditing (text)
        }
    }
    
    private func updateTotal (oldValue : NSNumber, newValue : NSNumber) {
        total -= oldValue.doubleValue
        total += newValue.doubleValue
    }
    
    func updateButtonPushed (sender: DatePickerViewController) {
        if let date = sender.date {
            self.date = date
        }
    }
    
    func fillUsingInvoice (_ invoice: Invoice, _ date: Date) {
        let numberFormatter = SingleViewController.numberFormatter
        numberFormatter.formatterBehavior = .behavior10_4
        numberFormatter.numberStyle = .currency
        numberFormatter.isLenient = true
        numberFormatter.localizesFormat = true
        
        self.date = date
        
        self.name = invoice.name
        self.address = invoice.address
        
        if let lawnService = numberFormatter.number (from: invoice.lawnService) {
            self.lawnService = lawnService
        }
        
        if let pruneAndTrim = numberFormatter.number (from: invoice.pruneAndTrim) {
            self.pruneAndTrim = pruneAndTrim
        }
        
        if let cleanUp = numberFormatter.number (from: invoice.cleanUp) {
            self.cleanUp = cleanUp
        }
        
        if let fertilizer = numberFormatter.number (from: invoice.fertilizer) {
            self.fertilizer = fertilizer
        }
        
        if let seedAndTopping = numberFormatter.number (from: invoice.seedAndTopping) {
            self.seedAndTopping = seedAndTopping
        }
        
        if let plantsAndColor = numberFormatter.number (from: invoice.plantsAndColor) {
            self.plantsAndColor = plantsAndColor
        }
        
        if let irrigationSprinklers = numberFormatter.number (from: invoice.irrigationSprinklers) {
            self.irrigationSprinklers = irrigationSprinklers
        }
        
        if let planterWork = numberFormatter.number (from: invoice.planterWork) {
            self.planterWork = planterWork
        }
        
        if let spray = numberFormatter.number (from: invoice.spray) {
            self.spray = spray
        }
        
        self.firstNote = invoice.note
        
        if let total = numberFormatter.number (from: invoice.total) {
            self.total = total.doubleValue
        }
        
        self.gardener = invoice.gardener
    }
    
}
