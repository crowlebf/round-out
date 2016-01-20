class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.belongs_to :user
      t.string :title, null: false
      t.text :description, null: false
      t.datetime :starts_at, null: false
      t.string :address, null: false
      t.string :address_secondary
      t.string :city, null: false
      t.string :state, null: false

      t.timestamps null: false
    end
  end
end
