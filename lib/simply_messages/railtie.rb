require 'rails'

require File.join(File.dirname(__FILE__), 'action_view_extension')

module SimplyMessages
  class Railtie < ::Rails::Railtie #:nodoc:
    initializer 'simply_messages' do |app|
      ActiveSupport.on_load(:action_view) do
        ::ActionView::Base.send :include, SimplyMessages::ActionViewExtension
      end
    end
  end
end
