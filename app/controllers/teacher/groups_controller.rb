class Teacher::GroupsController < Teacher::BaseController
  # GET /teacher/groups
  # GET /teacher/groups.json
  def index
    @teacher_groups = Group.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @teacher_groups }
    end
  end

  # GET /teacher/groups/1
  # GET /teacher/groups/1.json
  def show
    @teacher_group = Group.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @teacher_group }
    end
  end

  # GET /teacher/groups/new
  # GET /teacher/groups/new.json
  def new
    @teacher_group = Group.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @teacher_group }
    end
  end

  # GET /teacher/groups/1/edit
  def edit
    @teacher_group = Group.find(params[:id])
  end

  # POST /teacher/groups
  # POST /teacher/groups.json
  def create
    @teacher_group = Group.new(params[:teacher_group])

    respond_to do |format|
      if @teacher_group.save
        format.html { redirect_to @teacher_group, notice: 'Group was successfully created.' }
        format.json { render json: @teacher_group, status: :created, location: @teacher_group }
      else
        format.html { render action: "new" }
        format.json { render json: @teacher_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /teacher/groups/1
  # PUT /teacher/groups/1.json
  def update
    @teacher_group = Group.find(params[:id])

    respond_to do |format|
      if @teacher_group.update_attributes(params[:teacher_group])
        format.html { redirect_to @teacher_group, notice: 'Group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @teacher_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teacher/groups/1
  # DELETE /teacher/groups/1.json
  def destroy
    @teacher_group = Group.find(params[:id])
    @teacher_group.destroy

    respond_to do |format|
      format.html { redirect_to teacher_groups_url }
      format.json { head :no_content }
    end
  end
end
