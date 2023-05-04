class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.references :person, null: false

      t.string :street, null: false
      t.string :city, null: false
      t.string :state, null: false
      t.string :country, null: false

      t.integer :postal_code, null: false

      t.uuid :uuid, index: true, null: false, default: 'gen_random_uuid()', unique: true

      t.timestamps
    end
  end
end
