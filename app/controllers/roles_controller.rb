class RolesController < ApplicationController
    before_action :set_role, only: [:show, :edit, :update, :destroy]
  
    def index
      @roles = Role.all
    end
  
    def new
      @role = Role.new
    end
  
    def create
      @role = Role.new(role_params)
      if @role.save
        redirect_to roles_path, notice: 'Role created successfully.'
      else
        render :new
      end
    end
  
    def show
      render json: {role: @role}
    end
 
    def update
      if @role.update(role_params)
        redirect_to role_path(@role), notice: 'Role updated successfully.'
      else
        render :edit
      end
    end
  
    def destroy
      @role.destroy
      redirect_to roles_path, notice: 'Role deleted successfully.'
    end
  
    private
  
    def role_params
      params.require(:role).permit(:name)
    end
  
    def set_role
      @role = Role.find(params[:id])
    end
  end
  