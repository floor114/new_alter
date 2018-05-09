class CreateRequiredItems < ActiveRecord::Migration[5.0]
  def change
    create_table :required_items, id: :uuid do |t|
      t.uuid :request_id
      t.uuid :category_id
      t.integer :goal
    end
  end
end
