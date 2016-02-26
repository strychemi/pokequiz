require 'rails_helper'

describe UsersController, type: :controller do

  describe "Visitor" do

    context "tries to make an account" do
      it "GET #new to visit signup page" do
        get :new
        expect(response).to render_template :new
      end

      it "POST #create with good attributes sends to user_path" do
        post :create, { user: attributes_for( :user, profile_attributes: { first_name: "Harry", last_name: "Potter", username: "harry"} ) }

        expect(response).to redirect_to user_path(assigns(:user))
      end

      it "POST #create with bad/empty attributes sends to user_path" do
        post :create, { user: attributes_for( :user ) }

        expect(response).to render_template :new
      end
    end

    it "GET #index redirects to signup page" do
      get :index
      expect(response).to redirect_to new_user_path
    end

    it "GET #show redirects to root_path" do
      get :show, id: 1
      expect(response).to redirect_to root_path
    end

    it "PATCH #update redirects to root_path" do
      patch :update, { id: 1, user: attributes_for(:user) }
      expect(response).to redirect_to root_path
    end

    it "DELETE #destroy redirects to root_path" do
      delete :destroy, id: 1
      expect(response).to redirect_to root_path
    end
  end

  describe "Logged in User" do
    let(:user) { build( :user ) }

    before do
      create_session(user)
    end

    it "GET #index page works as normal" do
      get :index
      expect(response).to render_template :index
    end

    it "PATCH #update with good params" do
      patch :update, { id: user, user: attributes_for( :user, profile_attributes: { first_name: "Harry", last_name: "Potter", username: "harry"} ) }
      expect(response).to redirect_to user_path(user)
      expect(flash[:success]).to eq "User information updated!"
    end

    it "PATCH #update with no params" do
      patch :update, { id: user.id, user: attributes_for(:user) }
      expect(response).to redirect_to user_path(user)
      expect(flash[:success]).to eq "User information updated!"
    end

    it "DELETE #destroy redirects to signup path" do
      delete :destroy, id: user.id
      expect(response).to redirect_to root_path
      expect(flash[:success]).to eq "User destroyed!"
    end
  end

end
