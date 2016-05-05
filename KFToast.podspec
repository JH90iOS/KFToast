Pod::Spec.new do |s|  
  s.name             = “KFToast”  
  s.version          = "1.0.0"  
  s.summary          = “a toast view used on iOS."  
  s.description      = <<-DESC  
                       It is a toast view used on iOS, which implement by Objective-C.  
                       DESC  
  s.homepage         = "https://github.com/jh981479486/KFToast"  
  s.license          = 'MIT'  
  s.author           = { “jinhua” => “jinhua9093@gamil.com” }  
  s.source           = { :git => "https://github.com/jh981479486/KFToast.git", :tag => s.version.to_s }  
  s.platform     = :ios, '4.3'  
  # s.ios.deployment_target = ‘7.0’  
  # s.osx.deployment_target = '10.7'  
  s.requires_arc = true  
  s.source_files = ‘KFToast/*’  
  s.frameworks = 'Foundation', 'UIKit'  

end
