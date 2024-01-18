require 'pry'
class UsersController < ApplicationController
	# binding.pry
	before_action :set_user, only: [:show, :edit, :update, :destroy]
	def index
      @users = User.all.paginate(page: params[:page], per_page: 15)
      @roles = Role.all
			render json:@users.sort
	end

	def new
		@user = User.new
		@roles = Role.all
	end

	def edit
		@user=" user not found" if !@user.present?

    render json: @user 
  end
	def create
		@user = User.new(user_params)
		if @user.save
			UserMailer.welcome_email(@user).deliver_now
			redirect_to users_path, notice: 'User created successfully.'
		else
			render :new
		end
	end

	def update
		user=@user.update(user_params)
		render json: user
  end

	def show
		render json: {user: @user}
	end

  def destroy
    @user.destroy
    redirect_to users_path, notice: 'User deleted successfully.'
  end

	def report#
		attributes = %w{first_name last_name role_id} 
		users = User.all
		csv_data = CSV.generate do |csv|
			csv << attributes
			users.each do |user|
				csv << [user.first_name, user.last_name, user.role_id]
			end
		end
	
		respond_to do |format|
			format.csv do
				send_data csv_data,
									type: 'text/csv; charset=utf-8; header=present',
									disposition: "attachment; filename=users_report_#{Time.now.to_i}.csv"
			end
		end
	end
	

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :role_id, :image)
  end

  def set_user
    @user = User.find(params[:id])
	end  
end