# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # POST /resource
  def create
    @user = User.new(student_params)
    success, classnet_information = check_if_classnet_account_exists(classnet_params)
    @user.classnet_realname = classnet_information[:realname]
    if success && @user.save
      return redirect_to root_path
    end
    flash[:error] = "회원가입 정보를 올바르게 입력했는지 확인해주세요"
    redirect_to new_user_registration_path
  end

  protected

  def check_if_classnet_account_exists(secure_params)
    Rails.logger.error secure_params
    [true, {}]
  end

  def student_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation, :classnet_handle)
  end

  def classnet_params
    params.require(:user).permit(:classnet_handle, :classnet_password)
  end

  def update_resource(resource, params)
    if params[:password].present?
      resource.password = params[:password]
      resource.password_confirmation = params[:password_confirmation]
    end

    resource.update_without_password(params)
  end

  def after_sign_in_path_for(resource)
    stored_location_for(resource)
  end
end
