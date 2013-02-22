class Admin::AssignmentsController < Admin::BaseController
  # GET /admin/assignments
  # GET /admin/assignments.json
  def index
    @admin_assignments = Assignment.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @admin_assignments }
    end
  end

  # GET /admin/assignments/1
  # GET /admin/assignments/1.json
  def show
    @admin_assignment = Assignment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @admin_assignment }
    end
  end

  # GET /admin/assignments/new
  # GET /admin/assignments/new.json
  def new
    @admin_assignment = Assignment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @admin_assignment }
    end
  end

  # GET /admin/assignments/1/edit
  def edit
    @admin_assignment = Assignment.find(params[:id])
  end

  # POST /admin/assignments
  # POST /admin/assignments.json
  def create
    @admin_assignment = Assignment.new(params[:assignment])

    respond_to do |format|
      if @admin_assignment.save
        format.html { redirect_to [:admin, @admin_assignment], notice: 'Assignment was successfully created.' }
        format.json { render json: @admin_assignment, status: :created, location: @admin_assignment }
      else
        format.html { render action: "new" }
        format.json { render json: @admin_assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/assignments/1
  # PUT /admin/assignments/1.json
  def update
    @admin_assignment = Assignment.find(params[:id])

    respond_to do |format|
      if @admin_assignment.update_attributes(params[:assignment])
        format.html { redirect_to [:admin, @admin_assignment], notice: 'Assignment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @admin_assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/assignments/1
  # DELETE /admin/assignments/1.json
  def destroy
    @admin_assignment = Assignment.find(params[:id])
    @admin_assignment.destroy

    respond_to do |format|
      format.html { redirect_to admin_assignments_url }
      format.json { head :no_content }
    end
  end
end
