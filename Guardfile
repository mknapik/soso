# More info at https://github.com/guard/guard#readme


guard 'bundler' do
  watch('Gemfile')
end

guard 'annotate', show_indexes: true, simple_indexes: true, format: :rdoc, show_migration: true, run_at_start: false do
  watch('db/schema.rb')
end

guard :livereload do
  watch(%r{app/views/.+\.slim$})
  watch(%r{app/helpers/.+\.rb})
  watch(%r{public/.+\.(css|js|html)})
  watch(%r{config/locales/.+\.yml})
  # Rails Assets Pipeline
  watch(%r{(app|vendor)(/assets/\w+/(.+\.(css|less|js|html))).*}) { |m| "/assets/#{m[3]}" }
end

# This group allows to skip running RuboCop if RSpec.
group :red_green_refactor, halt_on_fail: true do
  guard :rspec, spring: true do
    watch(%r{^spec/.+_spec\.rb$})
    watch(%r{^lib/(.+)\.rb$}) { |m| "spec/lib/#{m[1]}_spec.rb" }
    watch('spec/spec_helper.rb') { 'spec' }

    # Rails example
    watch(%r{^app/(.+)\.rb$}) { |m| "spec/#{m[1]}_spec.rb" }
    watch(%r{^app/(.*)(\.slim)$}) { |m| "spec/#{m[1]}#{m[2]}_spec.rb" }
    watch(%r{^app/controllers/(.+)_(controller)\.rb$}) { |m| %W(spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb spec/requests/#{m[1]}_spec.rb) }
    watch(%r{^spec/support/(.+)\.rb$}) { 'spec' }
    watch(%r{^spec/factories/(.+)\.rb$}) { 'spec' }
    watch(%r{^spec/support/(.+)\.rb$}) { 'spec' }
    watch('app/controllers/application_controller.rb') { 'spec/controllers' }

    # Capybara request specs
    watch(%r{^app/views/(.+)/.*(\.slim)$}) { |m| "spec/requests/#{m[1]}_spec.rb" }
  end
=begin
guard :jasmine do
  watch(%r{spec/javascripts/spec\.(js\.coffee|js|coffee)$}) { 'spec/javascripts' }
  watch(%r{spec/javascripts/.+_spec\.(js\.coffee|js|coffee)$})
  watch(%r{app/assets/javascripts/(.+?)\.(js\.coffee|js|coffee)(?:\.\w+)*$}) { |m| "spec/javascripts/#{ m[1] }_spec.#{ m[2] }" }
end
=end

  guard :rubocop, all_on_start: false, cli: %w(--format fuubar --rails) do
    watch(%r{.+\.rb$})
    watch(%r{(?:.+/)?\.rubocop\.yml$}) { |m| File.dirname(m[0]) }
  end
end

