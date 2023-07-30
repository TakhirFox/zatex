# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'zatex' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for zatex
  pod 'SwiftKeychainWrapper'
  pod 'SnapKit', '~> 4.0'
  pod 'Alamofire'
  pod 'Kingfisher'
  pod 'YandexMapsMobile', '4.3.1-full'
  pod 'lottie-ios'
  
end

post_install do |installer|
  installer.generated_projects.each do |project|
    project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
         end
    end
  end
end