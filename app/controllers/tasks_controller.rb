class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

	def import
	  @task = Task
		@import = Rykn0wxx::Importer.new
	end

	def do_import
		@task = Task
	  @import = Rykn0wxx::Importer.new(@task, params[:file])
		@import.import
		if @import.import_result.failed.any?
			render :import
		else
			redirect_to tasks_url, notice: 'Uploaded file was successfully processed.'
		end
	end

  # GET /tasks
  def index
    @tasks = Task.order(:task_number).page(params[:page]).per(10)
  end

  # GET /tasks/1
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to @task, notice: 'Task was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /tasks/1
  def update
    if @task.update(task_params)
      redirect_to @task, notice: 'Task was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /tasks/1
  def destroy
    @task.destroy
    redirect_to tasks_url, notice: 'Task was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def task_params
      params.require(:task).permit(:start_time, :end_time, :sla_type, :sla_name, :task_number, :duration, :stage)
    end
end
