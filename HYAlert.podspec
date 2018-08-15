

Pod::Spec.new do |s|
  s.name         = "HYAlert"
  s.version      = "0.0.4"
  s.summary      = "HYAlert"
  s.description  = <<-DESC
  OC 中 Alert 的封装，根据不同的版本选取不同的控件
                   DESC
  s.homepage     = "https://github.com/oceanfive/HYAlert"
  s.license      = "MIT"
  s.author             = { "ocean" => "849638313@qq.com" }
  s.source       = { :git => "https://github.com/oceanfive/HYAlert.git", :tag => "#{s.version}" }
  s.source_files  = "HYAlertDemo/HYAlertDemo/HYAlert/*.{h,m}"
  s.exclude_files = "Classes/Exclude"
  s.platform     = :ios, "7.0"
  s.requires_arc = true
end
