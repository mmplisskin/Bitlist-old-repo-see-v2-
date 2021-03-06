
class UsersController < ApplicationController
  include SessionsHelper

  def index
    @users=User.all

  end

  def show
    @user=User.find(params[:id])

  end

  def edit
    @user=User.find(params[:id])
  end

  def update
      @user=User.find(params[:id])

      if @user.update_attributes(user_params)
        flash[:notice] = "Succesfully updated your info!"
        redirect_to @user
      else
        flash.now[:error] = @user.errors.full_messages
        render :edit
      end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
      if @user.save
        session[:user_id] = @user.id.to_s
        flash[:notice] = "Welcome to Bitlist!"
        redirect_to users_path
      else
        flash.now[:error] = @user.errors.full_messages
        render :new
    end
  end

  def destroy
    @user=User.find(params[:id])
    @user.items.destroy_all
    @user.destroy
    flash[:notice]="DESTRUCTION COMPLETE"
    redirect_to root_path

  end



private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
