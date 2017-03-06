Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "NSGIF"
  s.version      = "1.2.4"
  s.summary      = "iOS Library for converting your videos into beautiful animated GIFs."
  s.homepage     = "https://github.com/sebyddd/NSGIF"
  s.screenshots  = "https://dl.dropboxusercontent.com/s/0rq3fr0dtpvwd4h/NSGIF-header.png?dl=0"


  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Licensing your code is important. See http://choosealicense.com for more info.
  #  CocoaPods will detect a license file if there is a named LICENSE*
  #  Popular ones are 'MIT', 'BSD' and 'Apache License, Version 2.0'.
  #

  s.license      = "MIT (example)"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Sebastian Dobrincu" => "sebyddd@gmail.com" }
  s.platform     = :ios
  s.platform     = :osx
  s.ios.deployment_target = '7.0'
  s.osx.deployment_target = '10.9'
  s.source       = { :git => 'https://github.com/NSRare/NSGIF.git', :tag => "#{s.version}" }
  s.source_files  = "NSGIF/*.{h,m}"

  s.requires_arc = true

end
