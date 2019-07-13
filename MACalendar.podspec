Pod::Spec.new do |s|
  s.name             = 'MACalendar'
  s.version          = '1.0'
  s.summary          = 'Persian Calendar'

  s.description      = <<-DESC
This fantastic view changes its color gradually makes your app look fantastic!
                       DESC

  s.homepage         = 'https://github.com/matinouf/MACalendar'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Matin Abdollahi' => 'matin3238@gmail.com' }
  s.source           = { :git => 'https://github.com/matinouf/MACalendar.git', :tag => s.version.to_s }
  s.swift_version    = '4.2'
  s.frameworks       = "UIKit", "Foundation"

  s.ios.deployment_target = '10.0'
  s.source_files = 'MACalendar/**/*.{h,m,swift,xcassets}'
end