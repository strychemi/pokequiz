class UserPresenter < BasePresenter

  presents :user

  def fullname
    "#{user.profile.first_name} #{user.profile.last_name}"
  end



end