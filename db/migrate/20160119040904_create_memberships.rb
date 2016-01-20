class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.belongs_to :user
      t.belongs_to :event
      t.boolean :approved, default: false, null: false
    end
    add_index :memberships, [:user_id, :event_id], unique: true
  end
end
