class UserPresenter < BasePresenter

  presents :user

  delegate :profile, :to => :user
  delegate :email, :to => :user



  def user_show_photo
    if !user.profile.photo.nil?
      h.image_tag(user.profile.photo.photo.url(:medium))
    else
      #h.link_to("Choose a Photo", "#", "data-toggle" => "modal", "data-target" => "#signinform", class: "btn btn-block btn-primary" )
    end
  end

  def user_show_link
    h.link_to(user.profile.full_name, h.user_path(user))
  end

  def followed_user_show_link(activity)
    h.link_to(User.find(activity.activable_id).profile.full_name, h.user_path(User.find(activity.activable_id)))
  end

  def username
    if user.profile.username.nil?
      "N/A"
    else
      user.profile.username
    end
  end

  def pokemon_name
    if user.profile.pokemon.nil?
      "N/A"
    else
      user.profile.pokemon.name.capitalize
    end
  end

  def pokemon_type
    if user.profile.pokemon_type.nil?
      "N/A"
    else
      user.profile.pokemon_type.name.capitalize
    end
  end

  def question_right(result)
    if result == 'true'
      "correct"
    elsif result == 'false'
      "wrong"
    end
  end

  def followed?(followed)
    !h.current_user.followeds.include?(followed)
  end

  def follow_button
    unless user == h.current_user
      if followed?(h.get_user)
        h.link_to("Follow Me", h.followings_path(id: h.get_user.id), method: 'post', class: 'btn btn-lg btn-primary')
      elsif !(followed?(h.get_user))
        h.link_to("Unfollow Me", h.following_path( h.current_user.followeds.find_by_id(h.get_user.id )), method: 'delete', class: 'btn btn-lg btn-warning')
      end
    end
  end


end
