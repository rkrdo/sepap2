class Admin::ProblemsController < Admin::BaseController
  skip_before_filter :verify_authenticity_token, :only => :judge_results
  skip_before_filter :set_menu_location, :only => :judge_results
  skip_before_filter :set_locale, :only => :judge_results
  skip_before_filter :authenticate_user!, :only => :judge_results
  skip_before_filter :require_privileges, :only => :judge_results
  # GET /admin/problems
  # GET /admin/problems.json
  def index
    @problems = Problem.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @problems }
    end
  end

  # GET /admin/problems/1
  # GET /admin/problems/1.json
  def show
    @problem = Problem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @problem }
    end
  end

  # GET /admin/problems/new
  # GET /admin/problems/new.json
  def new
    @problem = Problem.new
    @problem.titles.build({:locale => "es"})
    @problem.titles.build({:locale => "en"})
    @problem.descriptions.build({:locale => "es"})
    @problem.descriptions.build({:locale => "en"})
    @problem.cases.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @problem }
    end
  end

  # GET /admin/problems/1/edit
  def edit
    @problem = Problem.find(params[:id])
  end

  # POST /admin/problems
  # POST /admin/problems.json
  def create
    @problem = Problem.new(params[:problem])
    @problem.active = true

    respond_to do |format|
      if @problem.save
        format.html { redirect_to [:admin, @problem], notice: 'Problem was successfully created.' }
        format.json { render json: @problem, status: :created, location: @problem }
      else
        format.html { render action: "new" }
        format.json { render json: @problem.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/problems/1
  # PUT /admin/problems/1.json
  def update
    @problem = Problem.find(params[:id])

    respond_to do |format|
      if @problem.update_attributes(params[:problem])
        format.html { redirect_to [:admin, @problem], notice: 'Problem was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @problem.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/problems/1
  # DELETE /admin/problems/1.json
  def destroy
    @problem = Problem.find(params[:id])
    @problem.destroy

    respond_to do |format|
      format.html { redirect_to admin_problems_url }
      format.json { head :no_content }
    end
  end

  # POST /admin/problems/judge_results
  def judge_results
    if params.has_key?("stderr")
      problem = Problem.find(params["id"])
      problem.compile_error = true
      problem.error_message = params["stderr"]
      problem.save
    else
      problem = Problem.find(params["id"])
      cse = problem.cases.find(params["case"])
      cse.output = params["result"]
      cse.save
    end
    render :nothing => true, :status => 200, :content_type => 'text/html'
  end

  def toggle_active
    problem = Problem.find(params[:problem_id])
    problem.toggle(:active)
    respond_to do |format|
      if problem.save
        format.html { redirect_to admin_problems_path }
      else
        format.html { redirect_to admin_problems_path }
      end
    end
  end

end
