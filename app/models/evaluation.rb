# integer  "mark"
# string   "commentary"
# integer  "candidature_id"
# integer  "user_id"
# datetime "created_at"
# datetime "updated_at"

class Evaluation < ActiveRecord::Base

  belongs_to :candidature
  belongs_to :user

  validates_presence_of :mark
  validates_inclusion_of :mark, {in: 0..5}

end