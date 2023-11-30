module ApplicationHelper
  def show_dashboard_layout
    user_signed_in? && controller_name != 'pages'
  end

  # example for actions_by_controller:
  # {
  #   'job_postings' => ['index', 'new', 'edit'],
  #   'another_controller' => []
  # }
  def active_sidebar_option?(actions_by_controller)
    actions_by_controller.any? do |controller, actions|
      next false if controller != controller_path
      next true if actions.empty?

      actions.any? { |action| action == action_name }
    end
  end

  def omniauth_authorize_path_for(resource, provider)
    public_send("#{resource.class.name.downcase}_#{provider}_omniauth_authorize_path")
  end
end
