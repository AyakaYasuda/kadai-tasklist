class TasksController < ApplicationController
  def index
    if logged_in?
      @task = current_user.tasks.build
      @tasks = current_user.tasks.order(id: :desc)
    end  
  end
  
  def show
    @task = current_user.tasks.find(params[:id])
  end
  
  def new
    @task = current_user.tasks.build
  end
  
  def create
    @task = current_user.tasks.build(task_params)
    
    if @task.save
      flash[:success] = "タスクは正常に作成されました"
      redirect_to @task
    else
      flash.now[:danger] = "タスクは作成できませんでした"
      render :new
    end  
  end
  
  def edit
    @task = current_user.tasks.find(params[:id])
  end
  
  def update
    @task = current_user.tasks.find(params[:id])
    
    if @task.update(task_params)
      flash[:success] = "タスクは正常に更新されました"
      redirect_to @task
    else
      flash.now[:danger] = "タスクは更新されませんでした"
      render :edit
    end  
  end
  
  def destroy
    @task = current_user.tasks.find(params[:id])
    @task.destroy
    
    flash[:success] = "タスクは正常に削除されました"
    redirect_to tasks_url
  end  

private

  def task_params
    params.require(:task).permit(:content, :status, :user)
  end
end
