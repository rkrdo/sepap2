class Teacher::AssignmentsController < Teacher::BaseController
  # GET /teacher/assignments
  # GET /teacher/assignments.json
  def index
    @teacher_assignments = Assignment.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @teacher_assignments }
    end
  end

  # GET /teacher/assignments/1
  # GET /teacher/assignments/1.json
  def show
    @teacher_assignment = Assignment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @teacher_assignment }
    end
  end

  # GET /teacher/assignments/new
  # GET /teacher/assignments/new.json
  def new
    @teacher_assignment = Assignment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @teacher_assignment }
    end
  end

  # GET /teacher/assignments/1/edit
  def edit
    @teacher_assignment = Assignment.find(params[:id])
  end

  # POST /teacher/assignments
  # POST /teacher/assignments.json
  def create
    @teacher_assignment = Assignment.new(params[:teacher_assignment])

    respond_to do |format|
      if @teacher_assignment.save
        format.html { redirect_to @teacher_assignment, notice: 'Assignment was successfully created.' }
        format.json { render json: @teacher_assignment, status: :created, location: @teacher_assignment }
      else
        format.html { render action: "new" }
        format.json { render json: @teacher_assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /teacher/assignments/1
  # PUT /teacher/assignments/1.json
  def update
    @teacher_assignment = Assignment.find(params[:id])

    respond_to do |format|
      if @teacher_assignment.update_attributes(params[:teacher_assignment])
        format.html { redirect_to @teacher_assignment, notice: 'Assignment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @teacher_assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teacher/assignments/1
  # DELETE /teacher/assignments/1.json
  def destroy
    @teacher_assignment = Assignment.find(params[:id])
    @teacher_assignment.destroy

    respond_to do |format|
      format.html { redirect_to teacher_assignments_url }
      format.json { head :no_content }
    end
  end
end
