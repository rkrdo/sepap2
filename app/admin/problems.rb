ActiveAdmin.register Problem do
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
