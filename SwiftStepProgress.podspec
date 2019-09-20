Pod::Spec.new do |s|
 s.name = 'SwiftStepProgress'
 s.version = '0.0.1'
 s.license = { :type => "MIT", :file => "LICENSE" }
 s.summary = 'A step progress view written in Swift'
 s.homepage = 'http://applicodo.com'
 s.social_media_url = 'https://twitter.com/cyupa89'
 s.authors = { "Ciprian Redinciuc" => "ciprian@applicodo.com" }
 s.source = { :git => "https://github.com/cyupa/SwiftStepProgressView.git", :tag => s.version.to_s }
 s.platforms = { :ios => "9.0" }
 s.requires_arc = true
 s.swift_versions = ['3.2', '4.0', '4.2', '5.0']

 s.default_subspec = "Core"
 s.subspec "Core" do |ss|
     ss.source_files  = "Sources/**/*.swift"
     ss.frameworks  = ["Foundation", "UIKit", "QuartzCore"]
 end
end
