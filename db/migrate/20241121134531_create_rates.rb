class CreateRates < ActiveRecord::Migration[7.2]
  def change
    create_table :rates do |t|
      t.timestamp :time
      t.float :value

      t.timestamps
    end
  end
end
