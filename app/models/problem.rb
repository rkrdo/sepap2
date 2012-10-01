class Problem < ActiveRecord::Base
  has_many :attempts, :dependent => :delete_all
  attr_accessible :description, :module, :time, :title, :main, :method, :type_list
  attr_reader :type_list

  acts_as_taggable_on :type


  mount_uploader :main, MainUploader
  mount_uploader :method, MethodUploader

  validates_numericality_of :time, :greater_than_or_equal_to =>1, :message => "El tiempo no puede ser negativo."
  validates_presence_of :title, :description, :main

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

  def toolkit(params)
    basepath_problem="#{Rails.root.to_s}/files/problems/#{id}"
    file = File.basename(main.to_s, File.extname(main.to_s))
    exe = "#{basepath_problem} #{file}"
    puts "#{Rails.root.to_s}/lib/scripts/toolkit '#{exe}' '#{params[:input]}'"
    resultado = `#{Rails.root.to_s}/lib/scripts/toolkit '#{exe}' '#{params[:input]}'`
    resultado.gsub! /\n/, "&#013;&#010;"
    resultado
  end

  def type_tokens=(ids)
    self.type_ids = ids.split(",")
  end

end
