class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy, :join_group ]

  # GET /groups
  def index
    @groups = Group.all
  end

  # GET /groups/1
  def show
  end

  # GET /groups/new
  def new
    return if enforce_login(groups_path)
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
    return if enforce_permissions(@group)
  end

  # POST /groups
  def create
    return if enforce_login(@group)

    @group = Group.new(group_params)
    @membership = @group.group_memberships.new(user: current_user)

    # @group.group_memberships.where(user: current_user).destroy

    if @group.save && @membership.save
      redirect_to @group, notice: 'Group was successfully created.'
    else
      render :new
    end
  end



  # POST /groups/:id:/join
  def join_group
    return if enforce_login(@group)
    # *** put in enforcing permissions! ***

    if( @group.users.include?(current_user))
      redirect_to @group, notice: 'User already in group!'
      return
    end

    @membership = @group.group_memberships.new(user: current_user)

    if @membership.save
      redirect_to @group, notice: 'Joined group successfully!'
    else
      render :new
    end
  end


  # @group.group_memberships.where(user: current_user).destroy




  # PATCH/PUT /groups/1
  def update
    return if enforce_permissions(@group)
    
    if @group.update(group_params)
      redirect_to @group, notice: 'Group was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /groups/1
  def destroy
    return if enforce_permissions(@group)

    @group.destroy
    redirect_to groups_path, notice: 'Group was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.require(:group).permit(:name, :description, :category_id, :is_public)
    end

    def enforce_permissions(group)
      if !group.can_edit?(current_user)
        redirect_to group, alert: 'You are not allowed to do that.'
        return true
      end
      return false
    end
end
