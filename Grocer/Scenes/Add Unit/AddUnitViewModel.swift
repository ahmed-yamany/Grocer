//
//  AddUnitViewModel.swift
//  Grocer
//
//  Created by Ahmed Yamany on 28/01/2024.
//

import SwiftUI

class AddUnitViewModel: ObservableObject {
    @Published var unit: String = ""

    let router: Router
    let unitManager: UnitContextManager
    init(router: Router, unitManager: UnitContextManager) {
        self.router = router
        self.unitManager = unitManager
    }
    
    public func saveUnit() {
        do {
            try unitManager.save(name: unit)
            router.dismiss()
        } catch {
            Logger.log(error.localizedDescription, category: \.default, level: .fault)
        }
    }
}
