//
//  Copyright 2020 Readium Foundation. All rights reserved.
//  Use of this source code is governed by the BSD-style license
//  available in the top-level LICENSE file of the project.
//

import Foundation
import R2Shared

public extension LCPService {

    /// Imports a protected publication from a standalone LCPL file.
    @available(*, unavailable, message: "Use `acquirePublication()` instead", renamed: "acquirePublication")
    func importPublication(from lcpl: URL, authentication: LCPAuthenticating?, sender: Any?, completion: @escaping (CancellableResult<LCPAcquisition.Publication, LCPError>) -> Void) -> Observable<DownloadProgress> {
        fatalError("Not available anymore")
    }
    
    @available(*, unavailable, message: "Use `acquirePublication()` instead", renamed: "acquirePublication")
    func importPublication(from lcpl: URL, authentication: LCPAuthenticating?, completion: @escaping (CancellableResult<LCPAcquisition.Publication, LCPError>) -> Void) -> Observable<DownloadProgress> {
        fatalError("Not available anymore")
    }
    
}


/// LCP service factory.
@available(*, unavailable, message: "Use `LCPService()` instead", renamed: "LCPService")
public func R2MakeLCPService() -> LCPService {
    fatalError("Not implemented")
}

@available(*, unavailable, message: "Remove all the code in `handleLcpPublication` and use `LCPLibraryService.loadPublication` instead, in the latest version of r2-testapp-swift")
final public class LcpSession {}


final public class LcpLicense {

    @available(*, unavailable, message: "Replace all the LCP code in `publication(at:)` by `LCPService.importPublication` (see `LCPLibraryService.fulfill` in the latest version)")
    public init(withLicenseDocumentAt url: URL) throws {}
    
    @available(*, deprecated)
    public init(withLicenseDocumentIn url: URL) throws {}
    
    @available(*, deprecated, message: "Removing the LCP license is not needed anymore, delete the LCP-related code in `remove(publication:)`")
    public func removeDataBaseItem() throws {}
    
    @available(*, deprecated, message: "Removing the LCP license is not needed anymore, delete the LCP-related code in `remove(publication:)`")
    public static func removeDataBaseItem(licenseID: String) throws {}

}


@available(*, unavailable, message: "Remove `promptPassphrase` and implement the protocol `LCPAuthenticating` instead (see LCPLibraryService in the latest version)")
public enum LcpError: Error {}

@available(*, deprecated, renamed: "LCPAcquisition.Publication")
public typealias LCPImportedPublication = LCPAcquisition.Publication
