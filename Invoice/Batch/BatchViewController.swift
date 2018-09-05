//
//  BatchViewController.swift
//  Invoice
//
//  Created by Erik Huerta on 8/30/18.
//  Copyright © 2018 Zyltr. All rights reserved.
//

import Cocoa
import CSV

class BatchViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate, DatePickerViewControllerDelegate {
    
    private enum SegueIdentifier : String {
        case BatchDetailSegue
    }
    
    private let openPanel = NSOpenPanel ()
    private let csvAlert = NSAlert ()
    
    @objc private dynamic var csvURL : URL?
    @objc private dynamic var content : [Invoice] = []
    @objc private dynamic var ignored : [Invoice] = []
    
    @objc private dynamic var date : Date = Date ()
    
    @objc private dynamic var searchValue : String = String () {
        didSet {
            if self.searchValue.isEmpty {
                self.contentArrayController.filterPredicate = nil
            }
            else {
                Swift.print ("Search Value : \(self.searchValue)")
                let predicate = NSPredicate (format: "address contains[cd] %@", self.searchValue)
                self.contentArrayController.filterPredicate = predicate
            }
        }
    }
    
    @IBOutlet private weak var contentTableView: NSTableView!
    @IBOutlet private var contentArrayController: NSArrayController!
    
    @IBOutlet private weak var ignoredTableView: NSTableView!
    @IBOutlet private var ignoredArrayController: NSArrayController!
    
    override func viewDidLoad () {
        super.viewDidLoad ()
        
        // Do view setup here.
        openPanel.allowedFileTypes = ["CSV"]
        
        csvAlert.alertStyle = .informational
        csvAlert.messageText = "CSV Error"
        csvAlert.informativeText = "Missing Name, Address, or Gardener header."
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier?.rawValue, let _ = SegueIdentifier (rawValue: identifier) {
            let row = self.contentTableView.selectedRow
            if let destination = segue.destinationController as? BatchDetailViewController {
                destination.invoice = self.content[row]
            }
        }
        else if let dest = segue.destinationController as? DatePickerViewController {
            dest.date = self.date
            dest.delegate = self
        }
    }
    
    func invoices () -> [Invoice]? {
        return self.content.isEmpty ? nil : self.content.filter { invoice in invoice.print }
    }
    
    func invoiceDate () -> Date {
        return self.date
    }
    
    @IBAction private func csvButtonPushed (_ sender: Any) {
        self.openPanel.begin (completionHandler: {
            modalResponse in
            
            if modalResponse == .OK, let url = self.openPanel.urls.first, let stream = InputStream (url: url) {
                do {
                    let csv = try CSV (stream: stream, hasHeaderRow: true)
                    
                    if let headers = csv.headerRow {
                        let containsName = headers.contains (Header.Name.rawValue)
                        let containsAddress = headers.contains (Header.Address.rawValue)
                        let containsGardener = headers.contains (Header.Gardener.rawValue)
                        
                        if containsName && containsAddress && containsGardener {
                            self.csvURL = url
                            
                            if !self.content.isEmpty {
                                self.contentArrayController.remove (contentsOf: self.content)
                            }
                            
                            if !self.ignored.isEmpty {
                                self.ignoredArrayController.remove (contentsOf: self.ignored)
                            }
                            
                            while let row = csv.next () {
                                let invoice = Invoice (headers: headers, row: row)
                                
                                if invoice.ignored {
                                    self.ignoredArrayController.addObject (invoice)
                                }
                                else {
                                    self.contentArrayController.addObject (invoice)
                                }
                            }
                        }
                        else {
                            if let window = self.view.window {
                                self.csvAlert.beginSheetModal (for: window, completionHandler: nil)
                            }
                        }
                    }
                    
                }
                catch {
                    /* Present Error */
                }
            }
        })
    }
    
    @IBAction private func detailButtonPushed (_ sender: Any) {
        if let view = sender as? NSView {
            let row = self.contentTableView.row (for: view)
            self.contentTableView.selectRowIndexes (IndexSet (integer: row), byExtendingSelection: false)
            let identifier = NSStoryboardSegue.Identifier (rawValue: SegueIdentifier.BatchDetailSegue.rawValue)
            self.performSegue (withIdentifier: identifier, sender: view)
        }
    }
    
    func updateButtonPushed (sender: DatePickerViewController) {
        if let date = sender.date {
            self.date = date
        }
    }
    
}
