class Users::RegistrationsController < Devise::RegistrationsController


  def new
    # Override Devise default behaviour and create a profile as well
    build_resource({})
    resource.assets.build
    respond_with self.resource
  end

  def edit

    resource.assets.build
    
  end
end