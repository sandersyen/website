module ApplicationHelper
  def user_label(user)
    content_tag(:span) do
      avatar(user) + content_tag(:span, " #{user.name}")
    end
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
