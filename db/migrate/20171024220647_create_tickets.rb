class CreateTickets < ActiveRecord::Migration[5.1]
  def change
    create_table :tickets do |t|
      t.string :zendesk_id
      t.string :subject
      t.text :description
      t.string :status
      t.string :creation_date
      t.string :solved_date

      t.timestamps
    end
  end
end
