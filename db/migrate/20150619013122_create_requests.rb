class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.string :name
      t.text :header
      t.text :body
      t.references :endpoint, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
