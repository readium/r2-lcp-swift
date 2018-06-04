//
//  RegisterItems.swift
//  readium-lcp-swift
//
//  Created by Senda Li on 2018/5/21.
//  Copyright © 2018 Readium. All rights reserved.
//

import Foundation
import SQLite

class RegisterItems {
    /// Table.
    let registerItems = Table("RegisterItems")
    /// Fields.
    let licenseID = Expression<String>("licenseID")
    let updated = Expression<Date?>("updated")
    
    let deviceName = Expression<String>("deiviceName")
    let deviceID = Expression<String>("deviceID")
    
    init(_ connection: Connection) {
        _ = try? connection.run(registerItems.create(temporary: false, ifNotExists: true) { t in
            
            t.column(licenseID)
            t.column(updated)
            
            t.column(deviceName)
            t.column(deviceID)
        })
    }
    
    /// Check if the table already contains an entry for the given license ID.
    ///
    /// - Parameter licenseID: The license ID to check for.
    /// - Returns: A boolean indicating the result of the search, true if found.
    /// - Throws: .
    internal func existingRegister(for licenseID: String) throws -> Bool {
        let db = LCPDatabase.shared.connection
        // Check if empty.
        guard try db.scalar(registerItems.count) > 0 else {
            return false
        }
        let query = registerItems.filter(self.licenseID == licenseID)
        let count = try db.scalar(query.count)
        
        return count > 0
    }
    
    /// Add a registered info to the database.
    ///
    /// - Parameters:
    ///   - license: The license related to register info.
    ///   - deviceNameString: current device name from system.
    ///   - deviceIDString: the unique id for device.
    /// - Throws: .
    internal func insert(_ license: LicenseDocument, deviceNameString: String, deviceIDString: String) throws {
        let db = LCPDatabase.shared.connection
        
        let insertQuery = registerItems.insert(
            licenseID <- license.id,
            updated <- Date(),
            deviceName <- deviceNameString,
            deviceID <- deviceIDString
        )
        
        try db.run(insertQuery)
    }
    
}
