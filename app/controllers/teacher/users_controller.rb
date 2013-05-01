class Teacher::UsersController < Teacher::BaseController
  # GET /teacher/users
  # GET /teacher/users.json
  def index
    @teacher_users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @teacher_users }
    end
  end

  # GET /teacher/users/1
  # GET /teacher/users/1.json
  def show
    @teacher_user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @teacher_user }
    end
  end

  # GET /teacher/users/new
  # GET /teacher/users/new.json
  def new
    @teacher_user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @teacher_user }
    end
  end

  # GET /teacher/users/1/edit
  def edit
    @teacher_user = User.find(params[:id])
  end

  # POST /teacher/users
  # POST /teacher/users.json
  def create
    @teacher_user = User.new(params[:teacher_user])

    respond_to do |format|
      if @teacher_user.save
        format.html { redirect_to @teacher_user, notice: 'User was successfully created.' }
        format.json { render json: @teacher_user, status: :created, location: @teacher_user }
      else
        format.html { render action: "new" }
        format.json { render json: @teacher_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /teacher/users/1
  # PUT /teacher/users/1.json
  def update
    @teacher_user = User.find(params[:id])

    respond_to do |format|
      if @teacher_user.update_attributes(params[:teacher_user])
        format.html { redirect_to @teacher_user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @teacher_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teacher/users/1
  # DELETE /teacher/users/1.json
  def destroy
    @teacher_user = User.find(params[:id])
    @teacher_user.destroy

    respond_to do |format|
      format.html { redirect_to teacher_users_url }
      format.json { head :no_content }
    end
  end
end
