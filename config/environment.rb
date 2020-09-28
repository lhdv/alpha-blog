# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

#
# Remove field_with_erros div when ActiveRecord returns a validation error
#
ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  html_tag.html_safe
end