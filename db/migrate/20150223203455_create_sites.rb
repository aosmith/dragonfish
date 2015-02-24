class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.string     :base_url
      t.timestamps null: false
    end
  end
end
