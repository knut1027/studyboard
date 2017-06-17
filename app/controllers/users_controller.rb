class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1.json
  def show
    @notes = @user.like_notes
    @chatrooms = @user.favorite_chatrooms
  end

  def edit
    if !user_signed_in? || current_user.id != @user.id
      redirect_to root_path
    end
  end
  # PATCH/PUT /users/1.json
  def update
    file = params[:user][:image]
    @user.set_image(file)
    
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_path(@user.id), notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1.json
  def destroy
    if !user_signed_in?  #current_user.id != @user.id
      redirect_to root_path
    end
    
    @user.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'ユーザはさくじょされました。' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :studentType, :studentYear)
    end
end
