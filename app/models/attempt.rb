class Attempt < ActiveRecord::Base
	belongs_to :problem
	belongs_to :user
	has_many :enrollments, through: :user
	has_many :groups, through: :enrollments
	attr_accessible :language, :outcome, :problem_id, :code, :groups, :user, :enrollments

	# File uploader
	mount_uploader :code, CodeUploader
	validates_presence_of :code
	
	def compile
		basepath_user=Rails.root.to_s+"/files/users/#{self.user.num}/#{self.problem_id}/#{self.id}/"
		basepath_problem=Rails.root.to_s+"/files/problems/#{self.problem_id}"

		# Time limit
		time=Integer(self.problem.time)

		# Source code with solution
		file=self.code

		# Filename without extension
		file_basename=File.basename(self.code.to_s, File.extname(self.code.to_s))

		# Input for executable
		input=basepath_problem+"/input"

		# File that stores the output
		output=basepath_user+"/output"

		# File that stores expected output of the problem,
		#  provided by teacher
		expected_output=basepath_problem+"/output"

		# File that stores compile/execution errors thrown
		error=basepath_user+"/error"
		
		# Route where the scripts run
		route=Rails.root.to_s+"/lib/scripts"

		if self.language.include? "Java"

			if self.problem.method?
				to_link = self.problem.exe+".class"
				link = `cd #{basepath_user};ln -s #{to_link}`
				exe = basepath_user+" "+File.basename(self.problem.main.to_s,File.extname(self.problem.main.to_s))
			else
				# File to execute after compile
				exe=basepath_user+" "+file_basename
			end

			self.update_attributes(:outcome=>`./lib/scripts/compilarJava2 #{file} '#{exe}' #{input} #{output} #{expected_output} #{error} #{time} #{route}`)

		elsif self.language.include? "C"

			# File to execute after compile
			exe=basepath_user+"/"+file_basename

			self.update_attributes(:outcome=>`./lib/scripts/compilarC #{file} '#{exe}' #{input} #{output} #{expected_output} #{error} #{time} #{route}`)

		else
			self.update_attributes(:outcome=>"Lenguaje no identificado")
		end
	end

	def show_code
	  IO.read((self.code.to_s))
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
