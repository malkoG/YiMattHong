# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # POST /resource
  def create
    @user = User.new(sign_up_params)
    success, classnet_information = check_if_classnet_account_exists(classnet_params)
    @user.classnet_realname = classnet_information[:student_name]
    if success && @user.save
      return redirect_to root_path
    end
    flash[:error] = "회원가입 정보를 올바르게 입력했는지 확인해주세요"
    flash[:error] = '클래스넷 인증이 올바르지 않습니다.' unless success
    redirect_to new_user_registration_path
  end

  protected

  def check_if_classnet_account_exists(secure_params)
    classnet_handle = secure_params[:classnet_handle]
    classnet_password = secure_params[:classnet_password]

    result = []
    begin
      sso_client = HongikSso::Client.new(classnet_handle, classnet_password)
      sso_client.authenticate

      classnet_information = sso_client.get_student_info
      result = [true, classnet_information]
    rescue => e
      result = [false, {}]
    end

    result
  end

  def sign_up_params
    student_params.except(:classnet_password)
  end

  def student_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation, :classnet_handle, :classnet_password)
  end

  def classnet_params
    student_params.slice(:classnet_handle, :classnet_password)
  end

  def update_resource(resource, params)
    if params[:password].present?
      resource.password = params[:password]
      resource.password_confirmation = params[:password_confirmation]
    end

    resource.update_without_password(params)
  end

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || notices_path
  end
end
