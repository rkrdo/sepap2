class AttemptsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :judge_results
  skip_before_filter :set_menu_location, :only => :judge_results
  skip_before_filter :set_locale, :only => :judge_results
  skip_before_filter :authenticate_user!, :only => :judge_results
  # GET /attempts
  # GET /attempts.json
  def index
    @attempts = current_user.attempts.joins(:problem).where(:problems => {:active => true}).group(:problem_id)
    @times_attempted = current_user.attempts.count(:group => :problem_id)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @attempts }
    end
  end

  # GET /attempts/1
  # GET /attempts/1.json
  def show
    @attempt = Attempt.find(params[:id])
    respond_to do |format|
      format.html {render partial: 'show_code', formats: :html}
      format.json
    end
  end

  # POST /attempts
  # POST /attempts.json
  def create
    @problem = Problem.find(params[:problem_id])
    @attempt = @problem.attempts.build(params[:attempt])
    @attempt.user = current_user
    @attempt.assignment = Assignment.find_by_id(params[:assignment_id])

    respond_to do |format|
      if @attempt.save
         new_tab = polymorphic_path([@attempt.assignment, @problem]) + "/#attempt1"
         format.html { redirect_to new_tab, notice: "Your attempt was successfully created." }
         format.json { render json: @problem, status: :created, location: @attempt }
      else
        format.html { redirect_to @problem, alert: 'Make sure you select the language and write the code.' }
        format.json { render json: @problem.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /attempts/judge_results
  def judge_results
    attempt = Attempt.find(params["id"])
    if params["error_code"].nil?
      result = attempt.results.create({:case_id => params["case"], :result => params["result"]})

      # Try to update the state to fail if the result is false
      attempt.maybe_set_fail_state unless result.result
    else

      # If the attempt is still in compiling state, set the first error that is reported back
      attempt.set_error(params["error_code"], params["stderr"]) if attempt.compiling?
    end
    render :nothing => true, :status => 200, :content_type => 'text/html'
  end
end
