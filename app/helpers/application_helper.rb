module ApplicationHelper
  def show_dashboard_layout
    user_signed_in? && controller_name != 'pages'
  end

  def active_sidebar_option?(actions_by_controller)
    actions_by_controller.any? do |controller, actions|
      next false if controller != controller_path
      next true if actions.empty?

      actions.any?(action_name)
    end
  end

  def omniauth_authorize_path_for(resource, provider)
    public_send(:"#{resource.class.name.downcase}_#{provider}_omniauth_authorize_path")
  end

  def translate_enum_value(model, enum, value)
    I18n.t("activerecord.attributes.#{model}.#{enum}.#{value}")
  end

  module_function :translate_enum_value
end
