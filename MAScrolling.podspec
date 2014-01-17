#
# Be sure to run `pod spec lint NAME.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# To learn more about the attributes see http://docs.cocoapods.org/specification.html
#
Pod::Spec.new do |s|
  s.name         = "MAScrolling"
  s.version      = "0.0.1"
  s.summary      = "Multiple Animation in ScrollView"
  s.description  = "Library makes easy to do multiple animation in ScrollView"
  s.homepage     = "https://github.com/alekoleg/MAScrolling"
  s.license      = 'MIT'
  s.author       = { "@Oleg Alekseenko" => "@alekoleg@gmail.com" }
  s.source       = { :git => "https://github.com/alekoleg/MAScrolling", :tag => s.version.to_s }

  s.platform     = :ios, '6.0'
  s.requires_arc = true

  s.source_files = 'Classes/ios/*.{h,m}'
  s.resources = 'Assets'

  s.ios.exclude_files = 'Classes/osx'
  s.osx.exclude_files = 'Classes/ios'
  s.public_header_files = 'Classes/**/*.h'
  s.frameworks = 'UIKit', 'Foundation', 'CoreAnimation', 'QuartzCore'
end
