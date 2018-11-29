class UpdateCategories < ActiveRecord::Migration[5.2]
  def change
    Category.create(name: 'Agricultural & Life Sciences')
    Category.create(name: 'Arts')
    Category.create(name: 'Education')
    Category.create(name: 'Engineering')
    Category.create(name: 'Environmental Studies')
    Category.create(name: 'Human Ecology')
    Category.create(name: 'Information')
    Category.create(name: 'International')
    Category.create(name: 'Journalism & Mass Communication')
    Category.create(name: 'Languages')
    Category.create(name: 'Law')
    Category.create(name: 'Medicine & Public Health')
    Category.create(name: 'Music')
    Category.create(name: 'Nursing')
    Category.create(name: 'Pharmacy')
    Category.create(name: 'Social Work')
    Category.create(name: 'Study Abroad')
    Category.create(name: 'Vetrinary Medicine')
    Category.create(name: 'Education')
  end
end
