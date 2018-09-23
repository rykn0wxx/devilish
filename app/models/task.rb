# == Schema Information
#
# Table name: tasks
#
#  id          :integer          not null, primary key
#  duration    :integer
#  end_time    :datetime
#  sla_name    :string
#  sla_type    :string
#  stage       :string
#  start_time  :datetime
#  task_number :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Task < ApplicationRecord
end
