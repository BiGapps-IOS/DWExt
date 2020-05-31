
Pod::Spec.new do |spec|

  spec.name         = "DWExtensions"
  spec.version      = "1.0.0"
  spec.summary      = "This is my first pod"
  spec.description  = "My Useful extensions"
  spec.homepage     = "https://github.com/BiGapps-IOS/DWExtensions"
  spec.license      = "MIT"
  spec.author       = { "denis windover" => "denis@bigapps.co.il" }
  spec.platform     = :ios, "11.0"
  spec.source       = { :git => "https://github.com/BiGapps-IOS/DWExtensions.git", :tag => "1.0.0" }
  spec.source_files = "DWExtensions/**/*"
  spec.exclude_files = "DWExtensions/DWExtensions/*.plist"
  spec.swift_versions = "5.0"
  #spec.dependency 'RxSwift', 'RxCocoa', 'RxAnimated'

end
