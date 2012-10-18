class Attempt < ActiveRecord::Base
	belongs_to :problem
	belongs_to :user
	attr_accessible :language, :outcome, :problem_id, :code

	# File uploader
	mount_uploader :code, CodeUploader

	def compile

		basepath_user=Rails.root.to_s+"/files/users/#{self.user.num}/#{self.problem_id}"

		basepath_problem=Rails.root.to_s+"/files/problems/#{self.problem_id}"

#		if self.problem.module?
#			link = `cd #{basepath};ln -s #{self.problem.main}`
#		end

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

			# File to execute after compile
			exe=basepath_user+" "+file_basename

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

end
