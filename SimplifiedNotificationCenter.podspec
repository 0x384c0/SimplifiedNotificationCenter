#
# Be sure to run `pod lib lint SimplifiedNotificationCenter.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SimplifiedNotificationCenter'
  s.version          = '1.0.5'
  s.summary          = 'Simple Notification Center'


  s.homepage         = 'https://github.com/0x384c0/SimplifiedNotificationCenter'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '0x384c0' => '0x384c0@gmail.com' }
  s.source           = { :git => 'https://github.com/0x384c0/SimplifiedNotificationCenter.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'SimplifiedNotificationCenter/Classes/**/*'
end
