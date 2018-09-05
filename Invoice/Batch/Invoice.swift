//
//  Invoice.swift
//  Invoice
//
//  Created by Erik Huerta on 9/3/18.
//  Copyright © 2018 Zyltr. All rights reserved.
//

import Foundation

class Invoice : NSObject {
    @objc var print : Bool = true
    @objc var ignored : Bool = false
    
    @objc var name : String = String ()
    @objc var address : String = String ()
    @objc var lawnService : String = String ()
    @objc var pruneAndTrim : String = String ()
    @objc var cleanUp : String = String ()
    @objc var fertilizer : String = String ()
    @objc var seedAndTopping : String = String ()
    @objc var plantsAndColor : String = String ()
    @objc var irrigationSprinklers : String = String ()
    @objc var planterWork : String = String ()
    @objc var spray : String = String ()
    @objc var note : String = String ()
    @objc var total : String = String ()
    @objc var gardener : String = String ()
    
    init(headers: [String], row: [String]) {
        for (index, header) in headers.enumerated() {
            if let value = Header(rawValue: header) {
                switch value {
                case .Name:
                    self.name = row[index]
                case .Address:
                    self.address = row[index]
                case .LawnService:
                    self.lawnService = row[index]
                case .PruneAndTrim:
                    self.pruneAndTrim = row[index]
                case .CleanUp:
                    self.cleanUp = row[index]
                case .Fertilizer:
                    self.fertilizer = row[index]
                case .SeedAndTopping:
                    self.seedAndTopping = row[index]
                case .PlantsAndColor:
                    self.plantsAndColor = row[index]
                case .IrrigationSprinklers:
                    self.irrigationSprinklers = row[index]
                case .PlanterWork:
                    self.planterWork = row[index]
                case .Spray:
                    self.spray = row[index]
                case .Note:
                    self.note = row[index]
                case .Total:
                    self.total = row[index]
                case .Gardener:
                    self.gardener = row[index]
                case .Ignore:
                    if let shouldIgnore = Bool (row[index].lowercased()), shouldIgnore {
                        self.ignored = true
                    }
                }
            }
        }
    }
}
