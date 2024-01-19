class RolesController < ApplicationController
    before_action :set_role, only: [:show, :update, :destroy]
  
    def index
      @roles = Role.all
      render json: {roles: @roles}
    end
  
    def new
      @role = Role.new
    end
  
    def create
      @role = Role.new(role_params)
      if @role.save
        render json:{status: 'Role created successfully.' }
      else
        render json:{status: 'Role not created.' }
      end
    end
  
    def show
      render json: {role: @role}
    end
 
    def update
      if @role.update(role_params)
        render json:{status: 'Role updated successfully.'}
      else
        render json:{status: 'Role not updated .'}
      end
    end
  
    def destroy
      @role.destroy
      render json: {status: 'Role deleted successfully.'}
    end
  
    private
  
    def role_params
      params.require(:role).permit(:name)
    end
  
    def set_role
      @role = Role.find(params[:id])
    end
  end
  