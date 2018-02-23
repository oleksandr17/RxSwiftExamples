# Spec locations
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '11.0'
use_frameworks!
inhibit_all_warnings!

def shared_pods
    pod 'RxSwift'
    pod 'RxCocoa'
end

# Targets setup
target 'RxSwiftExamples' do
    shared_pods
end

post_install do |installer|
    # RxSwift
    installer.pods_project.targets.each do |target|
        if target.name == 'RxSwift'
            target.build_configurations.each do |config|
                if config.name == 'Debug'
                    config.build_settings['OTHER_SWIFT_FLAGS'] ||= ['-D', 'TRACE_RESOURCES']
                end
            end
        end
    end
end
