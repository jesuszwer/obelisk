class UsersController < Clearance::UsersController
  #!? методы :new, :redirect_signed_in_users, :require_login  уже прописаны в Clearance::UsersController
  #!? и их не нужно переопределять
  #TODO перед выполнением действия проверить залогинен ли пользователь
  before_action :redirect_signed_in_users, only: [:create, :new]
  before_action :require_authenticated_user, only: [:show, :index, :edit, :update]
  before_action :authorize_user, only: [:edit, :update]

  #TODO пропустить выполнение действия если пользователь уже залогинен
  skip_before_action :require_login, only: [:create, :new], raise: false

  def index
    @users = User.all # TODO Select all users
  end
  def show
    @user = User.find_by(id: params[:id]) # TODO Select one user
  end

  def create
    @user = user_from_params
    if @user.save
      sign_in @user
      redirect_back_or url_after_create
    else
      render template: "users/new", status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    if @user.update(updated_user_params)
      redirect_to @user
    else
      render :edit
    end
  end

  def user_from_params # TODO Select and takeing values from params for user model
    email = user_params.delete(:email)
    password = user_params.delete(:password)
    username = user_params.delete(:username)

    Clearance.configuration.user_model.new(user_params).tap do |user|
      user.email = email
      user.password = password
      user.username = username
    end
  end

  private

  def updated_user_params
    params.require(:user).permit(:name, :lastname, :age, :description)
  end

  def require_authenticated_user
    unless signed_in?
      Rails.logger.debug("User is not signed in")
      redirect_to sign_in_url, notice: "Please sign in to access this page."
    end
  end

  def authorize_user
    @user = User.find_by(id: params[:id])
    unless current_user.id == @user.id
      redirect_to user_path(current_user), alert: "You are not authorized to edit this profile."
    end
  end

end
