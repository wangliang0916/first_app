class CreateEmsData < ActiveRecord::Migration
  def change
    create_table :ems_data do |t|
      t.string :tagname
      t.string :value

      t.timestamps
    end
  end
end
