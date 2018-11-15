class GroupsController < ApplicationController
  # call method set_group before running the methods given here
  before_action :set_group, only: [
    :show, :edit, :update, :destroy, :join_group, 
    :leave_group, :invite_member, :disinvite_member,
    :accept_invite
  ]

  # GET /groups
  def index
    return if enforce_login(home_path)
    @groups = current_user.groups
  end

  # GET /groups/1
  def show
    @invite = GroupInvite.find_by(user: current_user, group: @group)
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
    @membership = @group.group_memberships.new(user: current_user, role: 'ADMIN')

    if @group.save && @membership.save
      redirect_to @group, notice: 'Group was successfully created.'
    else
      render :new
    end
  end


  # POST /groups/:id/accept_invite
  def accept_invite
    invite = GroupInvite.find_by(group: @group, user: current_user)

    @membership = @group.group_memberships.new(user: current_user, role: 'USER')

    if invite.nil?
      redirect_to @group, notice: 'You have not been invited to that group.'
    elsif @membership.save
      invite.destroy
      redirect_to @group, notice: 'Joined group successfully.'
    else
      redirect_to @group, notice: 'Unable to create membership, try again.'
    end
  end


  # POST /groups/:id/invite
  def invite_member
    return if enforce_permissions(@group)

    invited_user = User.find_by_email(params[:email])
    invite = GroupInvite.new(group: @group, user: invited_user)
    existing_invite = GroupInvite.find_by(group: @group, user: invited_user)

    if invited_user.nil?
      redirect_to @group, alert: 'Unable to find that user.'
      return
    end

    if @group.users.include?(invited_user)
      redirect_to @group, alert: 'That user is already in the group.'
      return
    end

    unless existing_invite.nil?
      redirect_to @group, alert: 'That user has already been invite to the group.'
      return
    end

    if invite.save
      invite.create_notif
      redirect_to @group, notice: "You have invited #{invited_user.name} to the group."
      UserMailer.group_invite(invited_user.email).deliver_now
    else
      redirect_to @group, alert: 'Unable to invite that user.'
    end
  end


  # DELETE /groups/:id/invite
  def disinvite_member
    return if enforce_permissions(@group)

    invited_user = User.find(params[:user_id])
    invite = GroupInvite.find_by(group: @group, user: invited_user)

    if invite.presence
      invite.destroy
      redirect_to @group, notice: "You have disinvited #{invited_user.name} from the group."
    else
      redirect_to @group, alert: 'Unable to disinvite that user, were they not been invited?'
    end
  end



  # POST /groups/:id/join
  def join_group
    return if enforce_login(@group)
    # *** put in enforcing permissions! ***

    unless @group.is_public?
      redirect_to @group, alert: 'You are not allowed to join a private group.'
      return
    end

    if @group.users.include?(current_user)
      redirect_to @group, notice: 'User already in group!'
      return
    end

    @membership = @group.group_memberships.new(user: current_user, role: 'USER')

    if @membership.save
      redirect_to @group, notice: 'Joined group successfully!'
    else
      redirect_to @group, alert: 'Failed to join that group, please try again.'
    end
  end

  # POST /groups/:id/leave
  def leave_group
    return if enforce_login(@group)
    # *** put in enforcing permissions! ***

    unless @group.users.include?(current_user)
      redirect_to @group, notice: 'User not in group!' # shouldnt need this, just in case
      return
    end

    @membership = @group.group_memberships.find_by(user: current_user)

    if @membership.is_admin? && @group.admins.count == 1
      redirect_to @group, alert: 'You cannot leave that group since you are the only admin.'
      return
    else
      @membership.destroy
      redirect_to groups_path, notice: 'Left group successfully!'
    end
  end


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
