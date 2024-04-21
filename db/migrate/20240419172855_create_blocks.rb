class CreateBlocks < ActiveRecord::Migration[7.1]
  def change
    create_table :blocks do |t|
      t.string :block_hash
      t.integer :height
      t.integer :time
      t.bigint :total_fee
      t.integer :subsidy

      t.timestamps
    end
  end
end
