class Problem < ActiveRecord::Base
  has_many :attempts, :dependent => :delete_all
  attr_accessible :description, :module, :time, :title, :main, :method

  mount_uploader :main, MainUploader
  mount_uploader :method, MethodUploader
  
  validates :title, :description, :main, :presence => true
  validates_numericality_of :time, :greater_than_or_equal_to =>1, :message => "El tiempo no puede ser negativo."

	def compile_solution	

		basepath_problem=Rails.root.to_s+"/files/problems/#{self.id}"
		
		# File containing compile errors
		error=basepath_problem+"/error"	

		# File with main, source code
		file=self.main.to_s

		# File extension
		extension=File.extname(file)
		
		if extension.include? "java"
			# Compile!
			compile=`./lib/scripts/compilarJava_solucion #{basepath_problem} #{file} #{error}`
		elsif (extension.include? "c") || (extension.include? "cpp")
			exe=File.basename(file,extension)
			# Compile C code !
			compile=`./lib/scripts/compilarC_solucion #{basepath_problem} #{file} #{exe} #{error}`
		else
			compile="error"
		end
			

	end

end
