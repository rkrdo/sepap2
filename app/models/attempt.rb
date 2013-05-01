class Attempt < ActiveRecord::Base
  belongs_to :problem
  belongs_to :user
  belongs_to :assignment
  belongs_to :command

  has_many :enrollments, through: :user
  has_many :results, dependent: :destroy

  attr_accessible :language, :outcome, :problem_id, :code, :groups, :user, :enrollments,
                  :compile_error, :error_message, :command_id, :accepted, :time_exceeded, :state

  after_create :compile_and_run
  
  def compile_and_run
    Problem.request_to_judge hash_for_judge
  end

  def hash_for_judge
    ActiveSupport::JSON.encode({
      :id => self.id,
      :ext => self.command.name.downcase,
      :return_type => 0,
      :command => self.command.compile_command,
      :run_command => command.run_command || " ",
      :run_extension => command.run_extension || " ",
      :source => self.source_code.to_json,
      :time => self.problem.time,
      :cases => Case.to_judge(self.problem.cases),
      :channel => nil
    })
  end

  def source_code
    if self.problem.module?
      self.problem.main.gsub("<yield>",self.code)
    else
      self.code
    end
  end

  # Method that updates the attribute *state* to "fail" when the current state is compiling
  def maybe_set_fail_state
    self.update_attribute(:state, "fail") if self.state == "compiling"
  end

  def done_compiling?
    self.results.count == self.problem.cases.count
  end

  def compiling?
    self.state == "compiling"
  end

  def accepted?
    self.state == "accept"
  end

  def failed?
    self.state == "fail"
  end

  def with_error?
    self.state == "execution_error" or self.state == "compile_error"
  end

  def set_error(error_code, error_message)
    case error_code
    when 0
      self.update_attributes({:error_message => error_message, :state => "compile_error"})
    when 1
      self.update_attributes({:error_message => error_message, :state => "execution_error"})
    when 2
      self.update_attributes({:error_message => error_message, :state => "timeout"})
    end
  end

  def status
    if self.compiled?
      return :accept if self.accepted?
      return :timeout if self.time_exceeded?
      return :fail
    else
      return :uncompile if self.compile_error?
      return :compiling
    end
  end

  def get_feedbacks(locale = :en)
      feedbacks = []
      results.each do |result|
        feedbacks << result.case.feedbacks.find_by_locale(locale)
      end
      feedbacks
  end

  def get_wrong_results_count
    results.where(result: false).count
  end

  def self.accepted_for_problem?(problem)
    #self.where(:problem_id => problem.id, :compiled => true, :accepted => true).count >= 1
    self.where(:problem_id => problem.id, :state => "accept").count >= 1
  end

  def show_code
    IO.read((self.code.to_s))
  end

  def is_assigned(user)
    user.assigned_problems.each do |assignment|
      return assignment.id if assignment.problem == self.problem
    end
  end

  def get_feedback
    basepath_user=Rails.root.to_s+"/files/users/#{self.user.num}/#{self.problem_id}/#{self.id}/"
    basepath_problem=Rails.root.to_s+"/files/problems/#{self.problem_id}"

    output=basepath_user+"/output"
    expected_output = basepath_problem + "/output"

    f1 = File.open(output)
    f2 = File.open(expected_output)

    f1Lines = f1.readlines
    f2Lines = f2.readlines

    expected_output_lines = f2.lineno

    problem = Problem.find(problem_id)
    feedback_list = " <br /><ul>"

    f1Lines.each_with_index do |line, i|
      puts "valores #{i}  con #{expected_output_lines}"
      puts "entra"
      if(i<expected_output_lines)
        if(!line.eql?(f2Lines[i]))
          begin
            feedback_list += "<li>" + problem.get_feedback_comment(i) +"</li>"
          rescue

          end
        end
      end
    end

    f1.close
    f2.close

    feedback_list += "</ul>"
  end
end
