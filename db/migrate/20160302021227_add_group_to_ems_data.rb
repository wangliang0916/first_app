class AddGroupToEmsData < ActiveRecord::Migration
  def change
	  add_column :ems_data, :group, :string
  end
end
