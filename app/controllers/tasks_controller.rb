class TasksController < ApplicationController
  before_action :set_task, only: [:update]
  
  def index
    @tasks = current_user.tasks.page(params[:page]||1).per(10)
    respond_to do |format|
      format.html {
        render :partial => "/tasks/task_listing" if params[:listing].present?
      }
    end
  end
  
  def create
    @task = Task.new(title: params[:task][:title], user_id: current_user.id)
    respond_to do |format|
      if @task.save
        format.html { redirect_to root_path, notice: "Task added successfully." }
        format.json { render action: 'show', status: :created, location: @task }
      else
        format.html { redirect_to root_path, flash: { error: "Sorry, task could not be added. Please try again." } }
        format.json { render json: {:error => @task.errors}, status: :unprocessable_entity }
      end
    end
  end
  
  def update
    respond_to do |format|
      if @task.update_attributes(completed: true, completed_at: Time.now)
        format.html { redirect_to root_path, notice: "Task marked as completed successfully." }
        format.json { render action: 'show', status: :created, location: @task }
        format.js {}
      else
        format.html { redirect_to root_path, flash: { error: "Sorry, task could not be updated. Please try again." } }
        format.json { render json: {:error => @task.errors}, status: :unprocessable_entity }
        format.js {}
      end
    end
  end
  
  def show
    
  end
 
  private
  
  # Use callbacks to share common setup or constraints between actions.
  def set_task
    @task = Task.find(params[:id]) rescue nil
  end
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params[:task].permit(:title, :description, :completed)
  end
  
end
