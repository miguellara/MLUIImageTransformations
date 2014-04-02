Pod::Spec.new do |s|
  s.name             = "MLUIImageTransformations"
  s.version          = "0.0.1"
  s.summary          = "Convenient image transformation categories on top of UIImage."
  s.homepage         = "https://github.com/miguellara/MLUIImageTransformations.git"
  s.license          = 'MIT'
  s.author           = { "Miguel Lara" => "miguel@mac.com" }
  s.source           = { :git => "https://github.com/miguellara/MLUIImageTransformations.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/bigbrowntheory'

  s.ios.deployment_target = '7.0'
  s.requires_arc = true

  s.source_files = 'MLUIImageTransformations/**/*.{h,m}'
  s.frameworks = 'QuartzCore', 'XCTest'
end
