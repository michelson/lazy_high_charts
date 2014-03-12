class CreateLogData < ActiveRecord::Migration

  def change

    create_table :log_data do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
