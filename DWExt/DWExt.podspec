
Pod::Spec.new do |spec|

  spec.name         = "DWExt"
  spec.version      = "1.0.3"
  spec.summary      = "This is my first pod"
  spec.description  = "My Useful extensions"
  spec.homepage     = "https://github.com/BiGapps-IOS/DWExt"
  spec.license      = "MIT"
  spec.author       = { "denis windover" => "denis@bigapps.co.il" }
  spec.platform     = :ios, "11.0"
  spec.source       = { :git => "https://github.com/BiGapps-IOS/DWExt.git", :tag => "1.0.3" }
  spec.source_files = "DWExt/**/*"
  spec.exclude_files = "DWExt/DWExt/*.plist"
  spec.swift_versions = "5.0"

  spec.dependency 'RxCocoa'
  spec.dependency 'RxSwift'
  spec.dependency 'RxAnimated'
  spec.dependency 'RxDataSources'

end
