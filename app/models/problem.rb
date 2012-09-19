class Problem < ActiveRecord::Base
  has_many :attempts, :dependent => :delete_all
  attr_accessible :description, :module, :time, :title, :main, :method, :input, :output

  mount_uploader :main, MainUploader
  mount_uploader :method, MethodUploader

  validates :title, :description, :main, :presence => true
  validates_numericality_of :time, :greater_than_or_equal_to =>1, :message => "El tiempo no puede ser negativo."

	def  store_input
		basepath_problem=Rails.root.to_s+"/files/problems/#{self.id}"
		
		input_path = basepath_problem+"/input"
		
		File.open(input_path,'w') {|f| f.write(self.input)}
		self.update_attributes(:input=> input_path)
		
		# Store output path
		self.update_attributes(:output=> basepath_problem+"/output")
		
	end
	
	def compile_solution

		basepath_problem=Rails.root.to_s+"/files/problems/#{self.id}"

		# File containing compile errors
		error=basepath_problem+"/error"

		# File with main, source code
		file=self.main.to_s

		# File extension
		extension=File.extname(file)
		
		# Filename without extension
		file_basename=File.basename(file, extension)

		if extension.include? "java"
			# where executable should be
			exe = basepath_problem+" "+file_basename
			
			puts "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<yesyes"
			puts basepath_problem
			puts file
			puts exe
			puts self.input
			puts self.output
			puts error
			puts "<>>>>>>>>>>>>>>>>>>>>>"

			# Compile!
			compile=`./lib/scripts/compilarJava_solucion #{basepath_problem} #{file} '#{exe}' #{self.input} #{self.output} #{error}`
			
		elsif (extension.include? "c") || (extension.include? "cpp")
			exe=File.basename(file,extension)
			# Compile C code !
			compile=`./lib/scripts/compilarC_solucion #{basepath_problem} #{file} #{exe} #{error}`
		else
			compile="error"
		end


	end

  def toolkit(params)
    basepath_problem="#{Rails.root.to_s}/files/problems/#{id}"
    file = File.basename(main.to_s, File.extname(main.to_s))
    exe = "#{basepath_problem} #{file}"
    puts "#{Rails.root.to_s}/lib/scripts/toolkit '#{exe}' '#{params[:input]}'"
    resultado = `#{Rails.root.to_s}/lib/scripts/toolkit '#{exe}' '#{params[:input]}'`
    resultado.gsub! /\n/, "&#013;&#010;"
    resultado
  end

end
