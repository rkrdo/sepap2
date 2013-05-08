module Admin::UsersHelper
  def admin_icon(user)
    content_tag(:i, '', class: "icon-tasks") if user.admin?
  end
end
