module SimplyMessages

  module ActionViewExtension

    extend ::ActiveSupport::Concern

    module InstanceMethods

      def messages_block(options = {})
        # make options[:for] an array
        options[:for] ||= []
        options[:for] = [options[:for]] unless options[:for].is_a?(Array)

        # add model object associated with current controller
        options[:for] << controller.controller_name.split('/').last.gsub(/\_controller$/, '').singularize.to_sym

        # fetch all model objects
        model_objects = options[:for].map do |model_object|
          if model_object.instance_of?(String) or model_object.instance_of?(Symbol)
            instance_variable_get("@#{model_object}")
          else
            model_object
          end
        end.select { |m| m.present? }.uniq

        # messages_block
        messages_block = ''

        # notice/success
        flash_msg = ''
        [:notice, :success].each do |key|
          if flash[key].present?
            flash_msg += content_tag(:p, flash[key])
            messages_block += content_tag(:div, flash_msg.html_safe, :class => key.to_s)
          end
        end

        # alert/error
        flash_msg = ''
        [:alert, :error].each do |key|
          flash_msg += content_tag(:p, flash[key]) if flash[key].present?
        end

        # all models errors
        errors = ''
        model_objects.each do |model|
          if model.errors.any?
            errors += content_tag(:p, I18n.translate(
              model.errors.count > 1 ? :other : :one,
              :count => model.errors.count,
              :model => model.class.model_name.human,
              :scope => [:activerecord, :errors, :template, :header]) + ':')

            msg = ''
            model.errors.full_messages.each do |e|
              msg += content_tag(:li, e)
            end
            errors += content_tag(:ul, msg.html_safe)
          end
        end

        messages_block += content_tag(:div, flash_msg.html_safe + errors.html_safe, :class => 'alert')

        messages_block.html_safe
      end

    end

  end

end
