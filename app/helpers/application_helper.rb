module ApplicationHelper

  def sign_in_out
    if signed_in_user?
      render "shared/sign_out_form"
    else
      render "shared/sign_in_form"
    end
  end

end
