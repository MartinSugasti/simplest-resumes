module ApplicationHelper
  def show_dashboard_layout
    user_signed_in? && controller_name != 'pages'
  end

  def omniauth_authorize_path_for(resource, provider)
    public_send("#{resource.class.name.downcase}_#{provider}_omniauth_authorize_path")
  end
end
