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
    func viewCodeThemeSetup()
    func viewCodeAdditioalSetup()
}

extension ViewCodeProtocol {
    func viewCodeSetup() {
        self.viewCodeHierarchySetup()
        self.viewCodeConstraintSetup()
        self.viewCodeThemeSetup()
        self.viewCodeAdditioalSetup()
    }
    
    func viewCodeHierarchySetup() {
        // needs be override
    }
    
    func viewCodeConstraintSetup() {
       // needs be override
    }
    
    func viewCodeThemeSetup() {
        // optional method
    }
    
    func viewCodeAdditioalSetup() {
        // optional method
    }
}
