//
//  BatchDetailViewController.swift
//  Invoice
//
//  Created by Erik Huerta on 9/3/18.
//  Copyright © 2018 Zyltr. All rights reserved.
//

import Cocoa

class BatchDetailViewController: NSViewController {

    @objc var invoice : Invoice?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do view setup here.
        let origin = self.view.frame.origin
        self.view.frame  = NSMakeRect (origin.x, origin.y, 300.0, 160.0)
    }
    
}
