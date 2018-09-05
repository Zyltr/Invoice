//
//  Header.swift
//  Invoice
//
//  Created by Erik Huerta on 9/3/18.
//  Copyright © 2018 Zyltr. All rights reserved.
//

import Foundation

enum Header : String {
    /* Required */
    case Name
    case Address
    case Gardener
    
    /* Optional */
    case Ignore
    case LawnService = "Lawn Service"
    case PruneAndTrim = "Prune & Trim"
    case CleanUp = "Clean-Up"
    case Fertilizer
    case SeedAndTopping = "Seed & Topping"
    case PlantsAndColor = "Plants & Color"
    case IrrigationSprinklers = "Irrigation Sprinklers"
    case PlanterWork = "Planter Work"
    case Spray
    case Note
    case Total
}
