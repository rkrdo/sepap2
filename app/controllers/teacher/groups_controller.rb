class Teacher::GroupsController < Teacher::BaseController
  # GET /teacher/groups
  # GET /teacher/groups.json
  def index
    @groups = current_user.teached_groups.includes(:users)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @groups }
    end
  end

  # GET /teacher/groups/1
  # GET /teacher/groups/1.json
  def show
    @group = current_user.teached_groups.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @group }
    end
  end

  # GET /teacher/groups/new
  # GET /teacher/groups/new.json
  def new
    @group = Group.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @group }
    end
  end

  # GET /teacher/groups/1/edit
  def edit
    @group = current_user.teached_groups.find(params[:id])
  end

  # POST /teacher/groups
  # POST /teacher/groups.json
  def create
    @group = current_user.teached_groups.build(params[:group])

    respond_to do |format|
      if @group.save
        errors = @group.populate_group
        flash[:errors] = "The following student ids are not valid: #{errors}" unless errors.blank?
        format.html { redirect_to [:teacher, @group], notice: 'Group was successfully created.' }
        format.json { render json: @group, status: :created, location: @group }
      else
        format.html { render action: "new" }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /teacher/groups/1
  # PUT /teacher/groups/1.json
  def update
    @group = current_user.teached_groups.find(params[:id])

    respond_to do |format|
      if @group.update_attributes(params[:group])
        errors = @group.populate_group
        flash[:errors] = "The following student ids are not valid: #{errors}" unless errors.blank?
        format.html { redirect_to [:teacher, @group], notice: 'Group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teacher/groups/1
  # DELETE /teacher/groups/1.json
  def destroy
    @group = current_user.teached_groups.find(params[:id])
    @group.destroy

    respond_to do |format|
      format.html { redirect_to teacher_groups_url }
      format.json { head :no_content }
    end
  end
end
