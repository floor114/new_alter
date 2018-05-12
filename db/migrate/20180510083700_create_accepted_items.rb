class CreateAcceptedItems < ActiveRecord::Migration[5.0]
  def change
    create_table :accepted_items, id: :uuid do |t|
      t.uuid :decision_id
      t.uuid :required_item_id
      t.integer :count
      t.integer :helped_count
    end
  end
end
