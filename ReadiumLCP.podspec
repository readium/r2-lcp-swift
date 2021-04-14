Pod::Spec.new do |s|

  s.name          = "ReadiumLCP"
  s.version       = "2.0.0-beta.2"
  s.license       = "BSD 3-Clause License"
  s.summary       = "Readium LCP"
  s.homepage      = "http://readium.github.io"
  s.author        = { "Aferdita Muriqi" => "aferdita.muriqi@gmail.com" }
  s.source        = { :git => "https://github.com/readium/r2-lcp-swift.git", :branch => "develop" }
  s.exclude_files = ["**/Info*.plist"]
  s.requires_arc  = true
  s.resources     = ['readium-lcp-swift/Resources/**']
  s.source_files  = "readium-lcp-swift/**/*.{m,h,swift}"
  s.platform      = :ios
  s.ios.deployment_target = "10.0"
  s.xcconfig      = { 'HEADER_SEARCH_PATHS' => '$(SDKROOT)/usr/include/libxml2'}
  
  s.dependency 'R2Shared' 

  s.dependency 'ZIPFoundation'
  s.dependency 'SQLite.swift'
  s.dependency 'CryptoSwift'

end
