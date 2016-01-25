class AddLatitudeAndLongitudeToEvent < ActiveRecord::Migration
  def change
    add_column :events, :latitude, :float
    add_column :events, :longitude, :float
    add_column :events, :full_address, :string
  end
end
