Pod::Spec.new do |s|
  s.name             = 'Yosef'
  s.version          = '0.0.7'
  s.summary          = 'Create views from JSON'

  s.description      = <<-DESC
Yosef reads JSON files to generate views, so that they can be created dynamically. Change the JSON to create different views.
                       DESC

  s.homepage      = 'https://github.com/concretesolutions/yosef-ios'
  s.license         = { :type => 'MIT', :file => 'LICENSE' }
  s.author          = { 'Guilherme Bayma' => 'guilherme.bayma@concrete.com.br', 'Emannuel Carvalho' => 'emannuel.carvalho@concrete.com.br', 'Kaique Pantosi' => 'kaique.pantosi@concrete.com.br', 'Bruno Mazzo' => 'bruno.mazzo@concrete.com.br', 'Concrete' => 'contato@concrete.com.br' }
  s.source          = { :git => 'https://github.com/concretesolutions/yosef-ios.git', :tag => s.version.to_s }

  s.platform                = :ios, '10.0'
  s.ios.deployment_target   = '10.0'
  s.requires_arc            = true

  s.source_files = 'Yosef/Classes/**/*.swift'
  s.swift_version = '5.1'

  s.frameworks = 'UIKit'

  s.dependency 'Kingfisher'
  s.dependency 'lottie-ios'
end
