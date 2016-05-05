Pod::Spec.new do |s|

  s.name     = 'KFToast' 
  s.version  = '1.0.0'
  s.license  = "MIT"
  s.summary  = 'This is a toast view used on iOS'
  s.homepage = 'https://github.com/jh981479486/KFToast'
  s.author   = { 'jinhua' => 'jinhua9093@gamil.com' }
  s.source   = { :git => 'https://github.com/jh981479486/KFToast.git', :tag => "1.0.1" }
  s.platform = :ios 
  s.source_files = 'KFToast/*'
  s.framework = 'UIKit'
  s.requires_arc = true

end