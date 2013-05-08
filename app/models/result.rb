class Result < ActiveRecord::Base
  belongs_to :case
  belongs_to :attempt
  attr_accessible :result, :case_id
  
  after_create :maybe_set_attempt_as_accepted
  
  def maybe_set_attempt_as_accepted
    self.attempt.update_attribute(:state, "accept") if self.attempt.compiling? and self.attempt.done_compiling?
  end
  
  def feedback(locale = "en")
    self.case.feedback(locale)
  end
end
