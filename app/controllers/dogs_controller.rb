class DogsController < ApplicationController

  def create
    @dogs = Dog.all
    @newdog = Dog.new(dog_params)
    @newdog.user_id = current_user.id
   if @newdog.save
     redirect_to dogs_path, notice: "投稿されました"
   else
      @user = current_user
      render :index
   end
  end

  def index
    @newdog = Dog.new
    @dogs = Dog.all
    @user = current_user
  end
  
  def edit
    @dog = Dog.find(params[:id])
  end
  
  def update
    @dog = Dog.find(params[:id])
    if @dog.update(dog_params)
      redirect_to dog_path(@dog.id),notice: "編集されました"
    else
      render :edit
    end
  end
  
    
  def show
    @review = Review.new
    @dog=Dog.find(params[:id])
    @user = @dog.user
    @dog_comment = DogComment.new
  end

  def destroy
    @dog = Dog.find(params[:id])
    @dog.destroy
    redirect_to dogs_path, notice: "削除されました"
  end


  private

  def dog_params
    params.require(:dog).permit(:name, :image, :caption, category_ids: [])
  end

end
