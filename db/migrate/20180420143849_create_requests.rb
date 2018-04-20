class CreateRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :requests, id: :uuid do |t|
      t.string :title
      t.text :description
      t.uuid :user_id
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
