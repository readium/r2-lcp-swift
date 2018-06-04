//
//  LCPDatabase.swift
//  readium-lcp-swift
//
//  Created by Alexandre Camilleri on 10/2/17.
//  Copyright © 2017 Readium. All rights reserved.
//

import Foundation
import SQLite

enum LCPDatabaseError: Error {
}

final class LCPDatabase {
    /// Shared instance.
    public static let shared = LCPDatabase()

    /// Connection.
    let connection: Connection
    /// Tables.
    let licenses: Licenses!
    let transactions: Transactions!
    let registerItems: RegisterItems!

    private init() {
        do {
            var url = try FileManager.default.url(for: .libraryDirectory,
                                                  in: .userDomainMask,
                                                  appropriateFor: nil, create: true)

            url.appendPathComponent("lcpdatabase.sqlite")
            connection = try Connection(url.absoluteString)
            licenses = Licenses(connection)
            transactions = Transactions(connection)
            registerItems = RegisterItems(connection)
        } catch {
            fatalError("Error initializing db.")
        }
    }
}

