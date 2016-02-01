class AddNumberOfMembersToEvents < ActiveRecord::Migration
  def change
    add_column :events, :needed, :string, null: false
  end
end
