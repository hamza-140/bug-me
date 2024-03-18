class AddCreatedByToBugs < ActiveRecord::Migration[7.1]
  def change
    add_column :bugs, :created_by, :integer
  end
end
