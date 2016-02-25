module ApplicationHelper

  def sign_in_out
    if signed_in_user?
      render "layouts/shared/sign_out_form"
    else
      render "layouts/shared/sign_in_form"
    end
  end

  def present(object, klass=nil)
    klass ||= "#{object.class}Presenter".constantize
    presenter = klass.new(object, self)
    yield presenter if block_given?
  end

end
