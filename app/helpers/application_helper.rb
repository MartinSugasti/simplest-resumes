module ApplicationHelper
  def show_dashboard_layout
    user_signed_in? && controller_name != 'pages'
  end
end
