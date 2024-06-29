source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'

target 'TestDemo' do
pod "AFNetworking", "~> 3.0"
pod 'Masonry'
pod 'MJRefresh'
pod 'pop', '~> 1.0'
pod 'YYModel'
pod 'YYCache'
pod 'YYText'
pod 'YYCategories'
#pod "CTMediator"
pod "HandyFrame"
pod 'SDWebImage', '~> 4.0'
#pod 'LookinServer', :configurations => ['Debug']
use_frameworks!

post_install do |installer|
    installer.generated_projects.each do |project|
        project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
            end
        end
    end
end

end
