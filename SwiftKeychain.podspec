Pod::Spec.new do |s|

  s.name         = "SwiftKeychain"
  s.version      = "0.1.5"
  s.summary      = "Swift wrapper around the Apple Keychain API"

  s.description  = <<-DESC
                   An elegant Swift wrapper around the Apple Keychain API, made for iOS.
                   DESC

  s.homepage     = "https://github.com/yankodimitrov/SwiftKeychain"
  s.license      = { :type => "MIT", :file => "LICENSE.txt" }
  s.author       = { "Yanko Dimitrov" => "yanko@yankodimitrov.com" }
  s.social_media_url   = "https://twitter.com/_yankodimitrov"

  s.platform     = :ios, "8.0"
  s.ios.deployment_target = "8.0"

  s.source       = { :git => "https://github.com/yankodimitrov/SwiftKeychain.git", :tag => "v#{s.version}" }
  s.source_files  = "SwiftKeychain/Keychain/*.swift"
  
  s.framework  = "Security"

  s.requires_arc = true

end
