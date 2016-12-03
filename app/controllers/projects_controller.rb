class ProjectsController < ApplicationController
  before_action :set_project , only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user! , only: [:new, :edit, :create, :update, :posted, :taken, :bidded, :completed]
  before_action :check_authority , only: [:update, :edit, :destroy]
  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  def setter project_params
    newparams = Hash.new()
    newparams = {:title => project_params[:title],:description => project_params[:description], :budget => project_params[:budget], :time => project_params[:time]}
  end

  # POST /projects
  # POST /projects.json
  def create
    newparams = setter(project_params)
    @project = Project.new(newparams)
    @project.poster = current_user
    @project.poster.tag(@project, :with => project_params[:tags] , :on => :skills)
    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    newparams = setter(project_params)
    respond_to do |format|
      if @project.update(newparams)
        @project.poster.tag(@project, :with => project_params[:tags] , :on => :skills)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def taken
    @projects = current_user.taken_projects
  end

  def completed
    @projects = current_user.completed_projects
  end

  def bidded
    @projects = current_user.bidded_projects
  end

  def posted
    @projects = current_user.posted_projects
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:title, :description, :tags, :budget, :time)
    end

  def check_authority
    if current_user == @project.poster
      true
    else
      redirect_to '/projects' , alert: "Unauthorized to make any change"
      return
    end
  end
end
