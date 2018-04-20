# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    build_resource
    yield resource if block_given?
    render_view :new, cell: ::Devise::Cell::Registrations::New, model: resource
  end

  # POST /resource
  def create # rubocop:disable all
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      render_view :new, cell: ::Devise::Cell::Registrations::New, model: resource
    end
  end

  # GET /resource/edit
  def edit
    render_view :new, cell: ::Devise::Cell::Registrations::Edit, model: resource
  end

  # PUT /resource
  def update # rubocop:disable all
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    resource_updated = if account_update_params[:current_password].present?
                         resource.update_with_password(account_update_params)
                       else
                         resource.update_without_password(account_update_params)
                       end

    yield resource if block_given?
    if resource_updated
      if is_flashing_format?
        flash_key = if update_needs_confirmation?(resource, prev_unconfirmed_email)
                      :update_needs_confirmation
                    else
                      :updated
                    end
        set_flash_message :notice, flash_key
      end
      bypass_sign_in resource, scope: resource_name
      respond_with resource, location: user_path(resource)
    else
      clean_up_passwords resource
      set_minimum_password_length
      render_view :new, cell: ::Devise::Cell::Registrations::Edit,
                        model: resource,
                        flashes: { alert: resource.errors.full_messages }
    end
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(
      :sign_up,
      keys: %i[first_name last_name]
    )
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(
      :account_update,
      keys: %i[first_name last_name info phone_number avatar]
    )
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
