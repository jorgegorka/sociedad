class ResourcesController < ManagerController
  before_action :find_account
  before_action :find_resource, only: %i[edit update destroy]

  def index
    @resources = @account.resources
  end

  def new
    @resource = @account.resources.new
  end

  def create
    @resource = @account.resources.create resource_params

    if @resource.save
      notice = t('resources.created')
      redirect_to resources_path, notice:
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @resource.update(resource_params)
      notice = t('resources.updated')
      redirect_to resources_path, notice:
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    @resource.destroy

    notice = t('resources.deleted')

    redirect_to resources_path, notice:
  end

  private

  def resource_params
    params.require(:resource).permit(:name, :max_capacity)
  end

  def find_account
    @account = Current.user.account
  end

  def find_resource
    @resource = @account.resources.find params[:id]
  end
end
