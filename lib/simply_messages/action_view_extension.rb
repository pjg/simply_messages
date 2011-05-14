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
        end.select {|m| !m.nil? }.uniq

        # all models errors
        models_errors = []
        model_objects.each do |m|
          errors = m.errors.entries.collect {|field, message| message}.select {|m| m.present?}
          models_errors.concat(errors) if errors.any?
        end

        # messages_block
        messages_block = ''

        # flash[:success] or flash[:notice]
        if flash[:success].present? or flash[:notice].present?

          key = flash[:success].present? ? :success : :notice

          msg = content_tag(:p, flash[key] + '.')
          messages_block += content_tag(:div, msg, :class => key.to_s)
        end

        # flash[:error] or flash[:alert] or models errors
        if flash[:error].present? or flash[:alert] or models_errors.any?
          key = flash[:error].present? ? :error : :alert
          msg = ''

          if flash[key].present?
            msg += content_tag(:p, flash[key] + (models_errors.any? ? ':' : '.'))
          end

          if models_errors.any?
            errors = []
            models_errors.each do |e|
              errors << content_tag(:li, e)
            end
            msg += content_tag(:ul, errors.join)
          end

          messages_block += content_tag(:div, msg, :class => key.to_s)
        end

        messages_block
      end

    end

  end

end
