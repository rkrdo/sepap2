ActiveAdmin.register Problem do
	controller do
		def create
			@problem = Problem.new(params[:problem])
			respond_to do |format|
				if @problem.save
					@problem.compile_solution
					format.html { redirect_to admin_problem_path(@problem), notice: 'Problem was successfully created.' }
				else
					format.html { render action: "new" }
					format.json { render json: @problem.errors, status: :unprocessable_entity }
				end
			end
		end
	end

	collection_action :type_tokens, :method => :get do
		@tags = ActsAsTaggableOn::Tag.where("name like ?", "%#{params[:q]}%")
		respond_to do |format|
			format.json { render :json => @tags.map {|t| {:id => t.id.to_s, :name => t.name }} }
		end
  	end

	form do |f|
		f.inputs do
			f.input :title
			f.input :description
			f.input :time
			f.input :main
			f.input :method
			f.input :type_list, :input_html => {:id => "type_autocomplete"}
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
