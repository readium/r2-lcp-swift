//
//  DeviceService.swift
//  r2-lcp-swift
//
//  Created by Mickaël Menu on 07.02.19.
//
//  Copyright 2019 Readium Foundation. All rights reserved.
//  Use of this source code is governed by a BSD-style license which is detailed
//  in the LICENSE file present in the project repository where this source code is maintained.
//

import Foundation
import UIKit

final class DeviceService {
    
    private let repository: DeviceRepository
    private let network: NetworkService
    
    init(repository: DeviceRepository, network: NetworkService) {
        self.repository = repository
        self.network = network
    }
    
    /// Returns the device ID, creates it if needed.
    var id: String {
        let defaults = UserDefaults.standard
        guard let deviceId = defaults.string(forKey: "lcp_device_id") else {
            let deviceId = UUID().description
            defaults.set(deviceId.description, forKey: "lcp_device_id")
            return deviceId.description
        }
        return deviceId
    }
    
    // Returns the device's name.
    var name: String {
        return UIDevice.current.name
    }
    
    // Device ID and name as query parameters for HTTP requests.
    var asQueryParameters: [String: String] {
        return [
            "id": id,
            "name": name
        ]
    }
    
    /// Registers the device for the given license.
    /// If the call was made, the updated Status Document data is given to the completion closure.
    /// - Returns: Whether the device was already registered.
    @discardableResult
    func registerLicense(_ license: LicenseDocument, using status: StatusDocument) -> Deferred<(skipped: Bool, statusData: Data?)> {
        return Deferred {
            guard let registered = try? self.repository.isDeviceRegistered(for: license), !registered else {
                return .success((skipped: true, statusData: nil))
            }
    
            guard let link = status.link(withRel: .register),
                let url = self.network.urlFromLink(link, context: self.asQueryParameters)
                else {
                    throw LCPError.statusLinkNotFound(StatusDocument.Rel.register.rawValue)
            }
    
            return self.network.fetch(url, method: .post)
                .map { status, data in
                    guard status == 200 else {
                        throw LCPError.registrationFailure
                    }
                    try? self.repository.registerDevice(for: license)
                    return (skipped: false, statusData: data)
                }
        }
    }
    
}
