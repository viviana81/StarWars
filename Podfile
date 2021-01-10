platform :ios, '13.0'
inhibit_all_warnings!

target 'StarWars' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for StarWars
   pod 'SwiftLint'
   pod 'Moya', '~> 13.0'
   pod 'Kingfisher'
   pod "PromiseKit", "~> 6.8"
end

post_install do |installer|

  installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
          config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '10.0'
        end
    end
end
