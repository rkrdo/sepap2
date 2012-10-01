class Attempt < ActiveRecord::Base
	belongs_to :problem
	belongs_to :user
	attr_accessible :language, :outcome, :problem_id, :code

	# File uploader
	mount_uploader :code, CodeUploader
	
	def compile
		if self.language.include? "Java"	

			basepath_user=Rails.root.to_s+"/files/users/#{self.user.num}/#{self.problem_id}"
			
			basepath_problem=Rails.root.to_s+"/files/problems/#{self.problem_id}"
			
			file_basename=File.basename(self.code.to_s,".java")
			
			# Time limit
			time=self.problem.time
			
			# Source code with solution
			file=self.code

			# File to execute after compile
			exe=basepath_user+" "+file_basename

			
			# Input for executable		
			input=basepath_problem+"/input"	

			# File that stores the output			
			output=basepath_user+"/output"

			# File that stores expected output of the problem, 
			#  provided by teacher
			expected_output=basepath_problem+"/expected_output"

			# File that stores compile/execution errors thrown
			error=basepath_user+"/error"

			self.update_attributes(:outcome=>`./lib/scripts/compilarJava2 #{file} '#{exe}' #{input} #{output} #{expected_output} #{error} #{time}`)

			puts "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
			puts file
			puts Rails.root.to_s
			puts exe
			puts input
			puts output
			puts expected_output
			puts error

		else
			self.outcome="Lenguaje no identificado"
			
		end	
	end 	
end