class CreateTasks < ActiveRecord::Migration[5.2]
  def self.up
    create_table :tasks do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.string :sla_type
      t.string :sla_name
      t.string :task_number
      t.integer :duration
      t.string :stage

      t.timestamps
    end
  end
	def self.down
	  drop_table :tasks
	end
end
