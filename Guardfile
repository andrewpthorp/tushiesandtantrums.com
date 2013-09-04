# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard :rspec do
  watch(%r{^app/(.+)\.rb$})                           { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^app/(.*)(\.erb|\.haml)$})                 { |m| "spec/#{m[1]}#{m[2]}_spec.rb" }
  watch(%r{^app/controllers/(.+)_(controller)\.rb$})  { |m| "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb" }
  watch(%r{^spec/support/(.+)\.rb$})                  { "spec" }
  watch('app/controllers/application_controller.rb')  { "spec/controllers" }
  watch('spec/spec_helper.rb')  { "spec" }

  notification :tmux,
    :display_message => true,
    :timeout => 5, # in seconds
    :default_message_format => '%s // %s',
    :line_separator => ' > ', # since we are single line we need a separator
    :color_location => 'status-left-fg' # to customize which tmux element will change color
end

