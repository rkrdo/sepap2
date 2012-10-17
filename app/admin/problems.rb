ActiveAdmin.register Problem do
	controller do
		def create
			@problem = Problem.new(params[:problem])
			respond_to do |format|
				if @problem.save
					# Create and store input
					@problem.store_input
					@problem.compile_solution
					
					format.html { redirect_to upload_partial_admin_problem_path(@problem), notice: 'Problem was successfully created. Next step is to add feedback messages' }
				else
					format.html { render action: "new" }
					format.json { render json: @problem.errors, status: :unprocessable_entity }
				end
			end
		end
	end

	# GET /admin/problems/:id/upload_partial
	member_action :upload_partial, :method => :get do
		@problem = Problem.find_by_id(params[:id])
		
		@out=[]
		
		output_file=File.open(@problem.output,"r")
		output_file.each_with_index { |line,i|
			@out[i]=line
		}
		output_file.close
		render 'admin/problems/upload_partial'
	end	
	
	# GET /admin/problems/:id/upload_created
	member_action :upload_created, :method => :post do
		@problem = Problem.find_by_id(params[:id])
		
		puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>_______________"
		for i in 0..Integer(params[:lines])-1
			if(!params["#{i}"].empty?)
				f = Feedback.new()
				f.problem = @problem
				f.line_number = i
				f.comment=params["#{i}"]
				f.save
			end
		end

		render 'admin/problems/upload_created'
	end	
	
	#form :partial => "upload_partial"
	form do |f|
		f.inputs do
			f.input :title
			f.input :description
			f.input :time
			f.input :main
			f.input :method
			f.input :input, :as => :text
		end
		f.buttons
	end

	index do
		column "ID", :sortable=>true do |problem|
     			link_to problem.id, admin_problem_path(problem)
		end
		column :title
		column :time
		column :module
		column :created_at
		column :updated_at
		default_actions
  	end

  	show do |problem|
  		attributes_table do 
	  		row :id
	  		row :title
	  		row :description
	  		row :time
	  	end
  	end
end
