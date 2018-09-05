//
//  BatchView.swift
//  Invoice
//
//  Created by Erik Huerta on 9/4/18.
//  Copyright © 2018 Zyltr. All rights reserved.
//

import Cocoa

class BatchView: NSView {

    private var date : Date = Date ()
    private var invoices : [Invoice] = []
    
    init (invoices: [Invoice], date: Date) {
        self.date = date
        self.invoices = invoices
        
        let printInfo = NSPrintInfo.shared
        
        let width = printInfo.paperSize.width - printInfo.leftMargin - printInfo.rightMargin
        let height = printInfo.paperSize.height - printInfo.topMargin - printInfo.bottomMargin
        
        super.init(frame: NSMakeRect(0.0, 0.0, width, height))
    }
    
    required init? (coder decoder: NSCoder) {
        super.init(coder: decoder)
        assertionFailure("PrintableInvoiceView cannot be instantiated from a nib.")
    }
    
    override var isFlipped: Bool {
        return true
    }
    
    override func knowsPageRange(_ range: NSRangePointer) -> Bool {
        range.pointee = NSMakeRange (1, self.invoices.isEmpty ? 1 : self.invoices.count)
        return true
    }

    override func rectForPage (_ page: Int) -> NSRect {
        return self.frame
    }
    
    override func draw (_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        // Drawing code here.
        let identifier = NSStoryboard.SceneIdentifier ("Single")
        if let viewController = NSStoryboard.main?.instantiateController (withIdentifier: identifier) as? SingleViewController {
            if let current = NSPrintOperation.current {
                viewController.fillUsingInvoice (self.invoices[current.currentPage - 1], self.date)
                let data = viewController.view.dataWithPDF (inside: NSMakeRect(0.0, 0.0, 420.0, 595.0))
                if let image = NSImage (data: data) {
                    image.draw (in: self.frame)
                }
            }
        }
    }
    
}
