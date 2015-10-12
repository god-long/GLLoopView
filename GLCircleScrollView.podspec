Pod::Spec.new do |s|
  s.name         = "GLCircleScrollView"
  s.version      = "1.0.0"
  s.summary      = "无限循环轮播图"
  s.homepage     = "https://github.com/mouse-lin/GLCircleScrollView"
  s.license      = { type: 'UA', file: 'LICENSE' }
  s.author       = "god-long"
  s.source       = { git: "https://github.com/mouse-lin/GLCircleScrollView.git", tags: "1.0.0"}
  s.platform     = :ios, '8.0'
  s.source_files = 'GLCircleScrollVeiw/CirCleView.swift'
  s.requires_arc = true
end
