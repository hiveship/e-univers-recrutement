class Evaluation < ActiveRecord::Base

  validates_presence_of :mark
  validates_inclusion_of :mark, {in: 0..5}

  belongs_to :candidature
  belongs_to :user

end