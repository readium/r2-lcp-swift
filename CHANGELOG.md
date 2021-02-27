# Changelog

All notable changes to this project will be documented in this file.

**Warning:** Features marked as *experimental* may change or be removed in a future release without notice. Use with caution.

## [Unreleased]

### Changed

* We removed the dependency to the private `R2LCPClient.framework`, which means:
    * Now `r2-lcp-swift` works as a Carthage dependency, no need to use a submodule anymore.
    * You do not need to modify `r2-lcp-swift`'s `Cartfile` anymore to add the private `liblcp` dependency.
    * However, you must provide a facade to `LCPService` (see [README](README.md) for an example implementation).
* The Renew Loan API got revamped to better support renewal through a web page.
    * You will need to implement `LCPRenewDelegate` to coordinate the UX interaction.
    * Readium ships with a default implementation `LCPDefaultRenewDelegate` to handle web page renewal with `SFSafariViewController`.
* CocoaPods is not supported anymore.

### Fixed

* Fixed really slow opening of large PDF documents.


## [2.0.0-beta.1]

### Changed

* Upgraded shared dependencies.


## [2.0.0-alpha.2]

### Added

* LCP implementation of the [Content Protection API](https://readium.org/architecture/proposals/006-content-protection) to work with the new [Streamer API](https://readium.org/architecture/proposals/005-streamer-api).
  * It is highly recommended that you upgrade to the new `Streamer` API to open publications, which will simplify DRM unlocking.
* Two default implementations of `LCPAuthenticating`:
  * `LCPDialogAuthentication` to prompt the user for its passphrase with the official LCP dialog.
  * `LCPPassphraseAuthentication` to provide directly a passphrase, pulled for example from a database or a web service.
* `LCPService.acquirePublication()` is a new API to acquire a publication from a standalone license. Compared to the former `importPublication()`:
  * It doesn't require the passphrase, to allow bulk imports.
  * It can be cancelled by calling `cancel()` on the returned `LCPAcquisition` object.
* `LCPService.isLCPProtected()` provides a way to check if a file is protected with LCP.

### Changed

* `LCPAuthenticating` is now provided with more information and you will need to update your implementation.

### Fixed

* [Decrypting resources in some edge cases](https://github.com/readium/r2-lcp-swift/pull/94).


## [2.0.0-alpha.1]

### Added

* Support for [PDF](https://readium.org/lcp-specs/notes/lcp-for-pdf.html) and [Readium Audiobooks](https://readium.org/lcp-specs/notes/lcp-for-audiobooks.html) protected with LCP.

### Changed

* `LCPAuthenticating` can now return hashed passphrases in addition to clear ones. [This can be used by reading apps](https://github.com/readium/r2-lcp-swift/pull/75) fetching hashed passphrases from a web service or [Authentication for OPDS](https://readium.org/lcp-specs/notes/lcp-key-retrieval.html), for example.
* Provided `LCPAuthenticating` instances are now retained by the LCP service. Therefore, you can provide one without keeping a reference around in your own code.


[unreleased]: https://github.com/readium/r2-lcp-swift/compare/master...HEAD
[2.0.0-alpha.1]: https://github.com/readium/r2-lcp-swift/compare/1.2.3...2.0.0-alpha.1
[2.0.0-alpha.2]: https://github.com/readium/r2-lcp-swift/compare/2.0.0-alpha.1...2.0.0-alpha.2
[2.0.0-beta.1]: https://github.com/readium/r2-lcp-swift/compare/2.0.0-alpha.2...2.0.0-beta.1
