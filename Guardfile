guard :rspec do
  watch(%r{^app/(.+)\.rb$})                           { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^app/controllers/(.+)_(controller)\.rb$})  { |m| ["spec/routing/#{m[1]}_routing_spec.rb", "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb"] }
  watch(%r{^spec/(.+)\_spec.rb$})                     { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^spec/support/(.+)\.rb$})                  { "spec" }
  watch('app/controllers/application_controller.rb')  { "spec/controllers" }
  watch('config/routes.rb')                           { "spec/routing" }
  watch('spec/spec_helper.rb')                        { "spec" }

  notification :tmux,
    :display_message => true,
    :timeout => 5, # in seconds
    :default_message_format => '%s // %s',
    :line_separator => ' > ', # since we are single line we need a separator
    :color_location => 'status-left-fg' # to customize which tmux element will change color
end

