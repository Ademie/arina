# homeradar

A new Flutter project.

ARkit -- ios
ARCore -- android

https://developers.google.com/ar/devices#ios

post_install do |installer|
  installer.pods_project.targets.each do |target|
    flutter_additional_ios_build_settings(target)
    target.build_configurations.each do |config|
      config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] ||= [
        '$(inherited)',
        'PERMISSION_CAMERA=1',
        'PERMISSION_PHOTOS=1',
        'PERMISSION_LOCATION=1',
        'PERMISSION_SENSORS=1',
        'PERMISSION_BLUETOOTH=1',
      ]
    end
  end
end

Android adaptive icon generator
