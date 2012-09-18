class ProblemsController < ApplicationController
  # GET /problems
  # GET /problems.json
  def index
    @problems = Problem.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @problems }
    end
  end

  # GET /problems/1
  # GET /problems/1.json
  def show
    @problem = Problem.find(params[:id])
    @user_problem_attempts = Attempt.where(problem_id: @problem.id, user_id: current_user)
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @problem }
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

    basepath_problem=Rails.root.to_s+"/files/problems/#{@problem.id}"
    file = File.basename(@problem.main.to_s, File.extname(@problem.main.to_s))

    exe = basepath_problem+" "+file
    puts "/////////////////////////////////////////////////////"
    puts params[:input]

    @resultado = `#{Rails.root.to_s}/lib/scripts/toolkit '#{exe}' '#{params[:input]}'`
    @resultado.gsub! /\n/, "&#013;&#010;"
    #@resultado = <<-HMM
     # roberto
      #plancarte
   # HMM

    #@resultado = "Guayo"

    puts @resultado
    respond_to do |format|
      format.js
    end

  end
end
