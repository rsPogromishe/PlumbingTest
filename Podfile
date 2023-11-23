# Uncomment the next line to define a global platform for your project
platform :ios, '14.0'
use_frameworks!
target 'PlumbingTest' do
  # Comment the next line if you don't want to use dynamic frameworks
  # Pods for PlumbingTest
 
  pod 'SDWebImage', '~> 5.0'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
      config.build_settings['CODE_SIGNING_ALLOWED'] = 'NO'
    end
  end
end
