//
//  AppDelegate.swift
//  UsersList
//
//  Created by Breno Morais on 22/07/23.
//

import Foundation

protocol ViewCodeProtocol {
    func viewCodeSetup()
    func viewCodeHierarchySetup()
    func viewCodeConstraintSetup()
    func viewCodeAdditioalSetup()
}

extension ViewCodeProtocol {
    func viewCodeSetup() {
        self.viewCodeHierarchySetup()
        self.viewCodeConstraintSetup()
        self.viewCodeAdditioalSetup()
    }
    
    func viewCodeHierarchySetup() {
        // needs be override
    }
    
    func viewCodeConstraintSetup() {
       // needs be override
    }
    
    func viewCodeAdditioalSetup() {
        // optional method
    }
}
