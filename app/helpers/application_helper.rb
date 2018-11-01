module ApplicationHelper
  def user_label(user)
    user.name
  end

  def category_label(category)
    category.name
  end
end
