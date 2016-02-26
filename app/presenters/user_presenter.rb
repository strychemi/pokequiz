class UserPresenter < BasePresenter

  presents :user


  def user_show_link
    h.link_to(user.profile.full_name, h.user_path(user))
  end

  def followed_user_show_link(activity)
    h.link_to(activity.followed_user.profile.full_name, h.user_path(activity.followed_user))
  end

  def question_right(result)
    if result == 'true'
      "correct"
    elsif result == 'false'
      "wrong"
    end
  end


end