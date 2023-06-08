#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint macos_window_utils.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
	s.name             = 'macos_window_utils'
	s.version          = '1.0.0'
	s.summary          = 'Flutter library for window modifications on macOS.'
	s.description      = <<-DESC
	macos_window_utils is a Flutter package that provides a set of methods for
	modifying the NSWindow of a Flutter application on macOS. With this package,
	you can easily customize the appearance and behavior of your app's window,
	including the title bar, transparency effects, shadow, and more.
						 DESC
	s.homepage         = 'https://github.com/Adrian-Samoticha/macos_window_utils.dart'
	s.license          = { :file => '../LICENSE', :type => 'MIT' }
	s.author           = { 'Adrian Samoticha' => 'adrian@samoticha.de' }
	s.source           = { :git => 'https://github.com/Adrian-Samoticha/macos_window_utils.dart.git',
	                       :tag => s.version.to_s }
	s.source_files     = 'Classes/**/*'
	s.dependency 'FlutterMacOS'
  
	s.platform = :osx, '10.14.6'
	s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
	s.swift_version = '5.0'
  end