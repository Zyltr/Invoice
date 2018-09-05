//
//  BatchHelpViewController.swift
//  Invoice
//
//  Created by Erik Huerta on 8/31/18.
//  Copyright © 2018 Zyltr. All rights reserved.
//

import Cocoa

class BatchHelpViewController: NSViewController
{

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction func sampleButtonPushed(_ sender: Any)
    {
        /*
        if let path = Bundle.main.path(forResource: "Sample", ofType: ".csv") {
            let savePanel = NSSavePanel()
            savePanel.nameFieldStringValue = "Sample.csv"
            
            savePanel.begin(completionHandler: {
                modalResponse in
                
                let sampleURL = URL(fileURLWithPath: path)
                let nameFieldStringValue = savePanel.nameFieldStringValue
                
                if modalResponse == .OK, let destinationURL = savePanel.directoryURL?.appendingPathComponent(nameFieldStringValue) {
                    do {
                        try FileManager.default.copyItem(at: sampleURL, to: destinationURL)
                    }
                    catch {
                        /* Handle Error */
                    }
                }
            })
        }
        */
    }
    
}
