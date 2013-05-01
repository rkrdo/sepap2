class Teacher::AssignmentsController < Teacher::BaseController
  # GET /teacher/assignments/1
  # GET /teacher/assignments/1.json
  def show
    @group = Group.find(params[:group_id])
    @assignment = @group.assignments.find(params[:id])
    if params[:user_id]
      @user = @group.users.find(params[:user_id])
      @attempts = @assignment.attempts.where(:user_id => @user.id)
    else
      @attempts = @assignment.attempts.includes(:user)
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @assignment }
    end
  end

  # GET /teacher/assignments/new
  # GET /teacher/assignments/new.json
  def new
    @group = Group.find(params[:group_id])
    @assignment = Assignment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @assignment }
    end
  end

  # GET /teacher/assignments/1/edit
  def edit
    @group = Group.find(params[:group_id])
    @assignment = @group.assignments.find(params[:id])
  end

  # POST /teacher/assignments
  # POST /teacher/assignments.json
  def create
    @group = Group.find(params[:group_id])
    @assignment = @group.assignments.build(params[:assignment])

    respond_to do |format|
      if @assignment.save
        format.html { redirect_to [:teacher, @group], notice: 'Assignment was successfully created.' }
        format.json { render json: @assignment, status: :created, location: @assignment }
      else
        format.html { render action: "new" }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /teacher/assignments/1
  # PUT /teacher/assignments/1.json
  def update
    @group = Group.find(params[:group_id])
    @assignment = @group.assignments.find(params[:id])

    respond_to do |format|
      if @assignment.update_attributes(params[:assignment])
        format.html { redirect_to [:teacher, @group], notice: 'Assignment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teacher/assignments/1
  # DELETE /teacher/assignments/1.json
  def destroy
    @group = Group.find(params[:group_id])
    @assignment = @group.assignments.find(params[:id])
    @assignment.destroy

    respond_to do |format|
      format.html { redirect_to teacher_assignments_url }
      format.json { head :no_content }
    end
  end

  # GET /teacher/groups/{group_id}/assignments/{assignment_id}/compare
  def compare
    @group = Group.find(params[:group_id])
    @assignment = @group.assignments.find(params[:id])

  end
end
