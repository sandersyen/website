module ApplicationHelper
  def user_label(user)
    content_tag(:span) do
      avatar(user) + content_tag(:span, " #{user.name}")
    end
  end

  def current_class?(test_path)
    request.path.starts_with?(test_path) ? 'active' : ''
  end

  def current_class_exact?(test_path)
    request.path == test_path ? 'active' : ''
  end

  def avatar(user)
    image_tag(user.avatar_url, size: '24x24')
  end

  def category_label(category)
    category.name
  end

  def group_label(group)
    link_to group.name, group
  end
end
