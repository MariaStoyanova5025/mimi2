class CreateRsas < ActiveRecord::Migration[5.1]
  def change
    create_table :rsas do |t|
      t.integer :n
      t.integer :e
      t.integer :d

      t.timestamps
    end
  end
end
