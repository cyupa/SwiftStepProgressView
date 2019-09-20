Pod::Spec.new do |s|
 s.name = 'SwiftStepProgressView'
 s.version = '0.0.1'
 s.license = { :type => "MIT", :file => "LICENSE" }
 s.summary = 'A step progress view written in Swift'
 s.homepage = 'http://applicodo.com'
 s.social_media_url = 'https://twitter.com/cyupa89'
 s.authors = { "Ciprian Redinciuc" => "ciprian@applicodo.com" }
 s.source = { :git => "https://github.com/cyupa/SwiftStepProgressView.git", :tag => "v"+s.version.to_s }
 s.platforms = { :ios => "9.0", :osx => "10.10", :tvos => "9.0", :watchos => "2.0" }
 s.requires_arc = true

 s.default_subspec = "Core"
 s.subspec "Core" do |ss|
     ss.source_files  = "Sources/**/*.swift"
     ss.framework  = "Foundation"
 end
end
