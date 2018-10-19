module GroupsHelper
  def category_options(group)
    categories = Category.order(:name).map do |category|
      [category.name, category.id]
    end
    options_for_select(categories, selected: group.category_id)
  end
end
