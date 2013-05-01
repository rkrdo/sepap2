class Teacher::ProblemsController < Teacher::BaseController
  # GET /teacher/problems
  # GET /teacher/problems.json
  def index
    @teacher_problems = Problem.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @teacher_problems }
    end
  end

  # GET /teacher/problems/1
  # GET /teacher/problems/1.json
  def show
    @teacher_problem = Problem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @teacher_problem }
    end
  end

  # GET /teacher/problems/new
  # GET /teacher/problems/new.json
  def new
    @teacher_problem = Problem.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @teacher_problem }
    end
  end

  # GET /teacher/problems/1/edit
  def edit
    @teacher_problem = Problem.find(params[:id])
  end

  # POST /teacher/problems
  # POST /teacher/problems.json
  def create
    @teacher_problem = Problem.new(params[:teacher_problem])

    respond_to do |format|
      if @teacher_problem.save
        format.html { redirect_to @teacher_problem, notice: 'Problem was successfully created.' }
        format.json { render json: @teacher_problem, status: :created, location: @teacher_problem }
      else
        format.html { render action: "new" }
        format.json { render json: @teacher_problem.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /teacher/problems/1
  # PUT /teacher/problems/1.json
  def update
    @teacher_problem = Problem.find(params[:id])

    respond_to do |format|
      if @teacher_problem.update_attributes(params[:teacher_problem])
        format.html { redirect_to @teacher_problem, notice: 'Problem was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @teacher_problem.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teacher/problems/1
  # DELETE /teacher/problems/1.json
  def destroy
    @teacher_problem = Problem.find(params[:id])
    @teacher_problem.destroy

    respond_to do |format|
      format.html { redirect_to teacher_problems_url }
      format.json { head :no_content }
    end
  end
end
