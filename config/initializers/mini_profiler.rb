if Rack.const_defined?('MiniProfiler')
  Rack::MiniProfiler.config.skip_paths ||= []
  Rack::MiniProfiler.config.skip_paths << '/admin'
end
