#
# Be sure to run `pod lib lint Yosef.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Yosef'
  s.version          = '0.1.0'
  s.summary          = 'Create views from JSON'

  s.description      = <<-DESC
Yosef reads JSON files to generate views, so that they can be created dynamically. Change the JSON to create different views.
                       DESC

  s.homepage      = 'https://github.com/guibayma/Yosef'
  # s.screenshots   = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license         = { :type => 'MIT', :file => 'LICENSE' }
  s.author          = { 'Guilherme Bayma' => 'guilherme.bayma@concrete.com.br', 'Emannuel Carvalho' => 'emannuel.carvalho@concrete.com.br' }
  s.source          = { :git => 'https://github.com/guibayma/Yosef.git', :tag => s.version.to_s }

  s.platform                = :ios, '9.0'
  s.ios.deployment_target   = '9.0'
  s.requires_arc            = true

  s.source_files = 'Yosef/Classes/**/*'
  
  # s.resource_bundles = {
  #   'Yosef' => ['Yosef/Assets/*.xcassets']
  # }

  # s.frameworks = 'UIKit', 'MapKit'

  s.dependency 'Kingfisher', '~> 4.0'
  s.dependency 'lottie-ios', '~> 2.0'
end
