class Admin::SubjectsController < Admin::BaseController
  # GET /admin/subjects
  # GET /admin/subjects.json
  def index
    @admin_subjects = Subject.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @admin_subjects }
    end
  end

  # GET /admin/subjects/1
  # GET /admin/subjects/1.json
  def show
    @admin_subject = Subject.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @admin_subject }
    end
  end

  # GET /admin/subjects/new
  # GET /admin/subjects/new.json
  def new
    @admin_subject = Subject.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @admin_subject }
    end
  end

  # GET /admin/subjects/1/edit
  def edit
    @admin_subject = Subject.find(params[:id])
  end

  # POST /admin/subjects
  # POST /admin/subjects.json
  def create
    @admin_subject = Subject.new(params[:subject])

    respond_to do |format|
      if @admin_subject.save
        format.html { redirect_to [:admin, @admin_subject], notice: 'Subject was successfully created.' }
        format.json { render json: @admin_subject, status: :created, location: @admin_subject }
      else
        format.html { render action: "new" }
        format.json { render json: @admin_subject.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/subjects/1
  # PUT /admin/subjects/1.json
  def update
    @admin_subject = Subject.find(params[:id])

    respond_to do |format|
      if @admin_subject.update_attributes(params[:subject])
        format.html { redirect_to [:admin, @admin_subject], notice: 'Subject was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @admin_subject.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/subjects/1
  # DELETE /admin/subjects/1.json
  def destroy
    @admin_subject = Subject.find(params[:id])
    @admin_subject.destroy

    respond_to do |format|
      format.html { redirect_to admin_subjects_url }
      format.json { head :no_content }
    end
  end
end
