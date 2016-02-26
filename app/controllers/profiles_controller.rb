class ProfilesController < ApplicationController


  # TODO: fill in methods, or do everything from the user create/show/update/destroy

  # def create
  #
  # end
  #
  #
  # def update
  #
  # end
  #
  #
  # def destroy
  #
  # end


  private

  def profile_params
    # TODO: update necessary params based on backend
    params.require(:profile).permit()
  end

end
