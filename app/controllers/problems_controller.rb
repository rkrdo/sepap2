class ProblemsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :judge_results
  skip_before_filter :set_menu_location, :only => :judge_results
  skip_before_filter :set_locale, :only => :judge_results
  skip_before_filter :authenticate_user!, :only => :judge_results

  # GET /problems
  # GET /problems.json
  def index
    @problems = Problem.active.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @problems }
    end
  end

  # GET /problems/1
  # GET /problems/1.json
  def show
    @problem = Problem.active.find(params[:id])
    @assignment = Assignment.find_by_id(params[:assignment_id])
    @assignments_for_problem = current_user.assignments.for(@problem)
    
    @user_problem_attempts = current_user.attempts.where(problem_id: @problem.id, assignment_id: params[:assignment_id]).limit(3).order("created_at DESC")
    @num_attempts = current_user.attempts.where(problem_id: @problem.id, assignment_id: params[:assignment_id]).count
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /problems/new
  # GET /problems/new.json
  def new
    @problem = Problem.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @problem }
    end
  end

  # GET /problems/1/edit
  def edit
    @problem = Problem.find(params[:id])
  end

  # POST /problems
  # POST /problems.json
  def create
    @problem = Problem.new(params[:problem])

    respond_to do |format|
      if @problem.save
        format.html { redirect_to @problem, notice: 'Problem was successfully created.' }
        format.json { render json: @problem, status: :created, location: @problem }
      else
        format.html { render action: "new" }
        format.json { render json: @problem.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /problems/1
  # PUT /problems/1.json
  def update
    @problem = Problem.find(params[:id])

    respond_to do |format|
      if @problem.update_attributes(params[:problem])
        format.html { redirect_to @problem, notice: 'Problem was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @problem.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /problems/1
  # DELETE /problems/1.json
  def destroy
    @problem = Problem.find(params[:id])
    @problem.destroy

    respond_to do |format|
      format.html { redirect_to problems_url }
      format.json { head :no_content }
    end
  end

  def use_toolkit
    @problem = Problem.find(params[:id])

    if @problem.compile_from_toolkit(params)
      render :nothing => true, :status => 200, :content_type => 'text/html'
    end
  end

  # POST /problems/judge_results
  # USED FOR THE TOOLKIT
  def judge_results
    result = params["result"]
    channel = params["channel"]

    Danthes.publish_to channel, :result => result
    render :nothing => true, :status => 200, :content_type => 'text/html'
  end

end
