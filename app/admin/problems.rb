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

		def edit
			@problem = Problem.find(params[:id])
			@types = @problem.taggings.map {|t| {:id => t.tag_id.to_s, :name=>ActsAsTaggableOn::Tag.find(t.tag_id).name}}
			puts "/////////////////////////////////////////////////////////////////////////"
			puts @types.to_s
		end

		def show
		    @problem = Problem.find(params[:id])
		    respond_to do |format|
		      	format.html # new.html.erb
		      	format.json { render json: @problem.taggings.map {|t| {:id => t.tag_id.to_s, :name=>ActsAsTaggableOn::Tag.find(t.tag_id).name}}}
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
			@types = f.object.taggings.map {|t| {:id => t.tag_id.to_s, :name=>ActsAsTaggableOn::Tag.find(t.tag_id).name}}
			@preP = @types.to_s
			puts "/////////////////////////////////////////////jamonazo///////////////////////////////////"
			@preP.gsub!(":", "\"")
			@preP.gsub!("=>", "\":")
			f.input :type_list, input_html: {id: "type_autocomplete", "data-pre" => @preP}
			#f.input :type_list, input_html: {id: "type_autocomplete", "data-pre" => "[{\"id\":\"25\",\"name\":\"lolol\"},{\"id\":\"26\",\"name\":\"reddit\"},{\"id\":\"28\",\"name\":\"hadouken\"},{\"id\":\"29\",\"name\":\"mayhem\"}]"}
			f.input :description
			f.input :time
			f.input :main
			f.input :method
		end
		f.buttons
	end

 	#filters
 	filter :id
	filter :title
	filter :taggings_tag_name, :label => "Type", :as => :check_boxes,
        :collection => proc {  ActsAsTaggableOn::Tag.all.map{|t| [t.name, t.name]} }
    #filter :taggings_tag_name, :label => "Type", :as => :string,
    #     :collection => proc {  ActsAsTaggableOn::Tag.all.map{|t| [t.name, t.name]} }, :input_html => {:id => "type_autocomplete_search"}
	filter :created_at


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
	  		row :type_list
	  	end
  	end
end
