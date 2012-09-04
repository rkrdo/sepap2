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
  
end
