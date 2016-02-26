require 'rails_helper'

describe User, type: :model do
  let(:user) { build :user }

  context "creating a user" do
    context "valid information" do
      it "default user is valid" do
        expect( user ).to be_valid
      end

      it "a user with a (borderline) short password is valid" do
        short_password_user = build( :user, password: "password", password_confirmation: "password")
        expect( short_password_user ).to be_valid
      end

      it "a user with a (borderline) long password is valid" do
        long_password_user = build( :user, password: "passwordpasswordpassword",  password_confirmation: "passwordpasswordpassword")
        expect( long_password_user ).to be_valid
      end
    end

    context "invalid information" do
      it "a user with an empty email is invalid" do
        blank_email_user = build( :user, email: "")
        expect( blank_email_user ).not_to be_valid
      end

      it "a user with a nil email is invalid" do
        nil_email_user = build( :user, email: nil)
        expect( nil_email_user ).not_to be_valid
      end

      it "a user with a duplicate email is invalid" do
        user.save
        new_user = build(:user, email: user.email)
        expect(new_user).not_to be_valid
      end

      it "a user with an empty password is invalid" do
        passwordless_user = build( :user, password: nil )
        expect( passwordless_user ).not_to be_valid
      end

      it "a user with a too-short password is invalid" do
        too_short_password_user = build( :user, password: "passwor", password_confirmation: "passwor")
        expect( too_short_password_user ).not_to be_valid
      end

      it "a user with a too-long password is invalid" do
        too_long_password_user = build( :user, password: "passwordpasswordpasswords",  password_confirmation: "passwordpasswordpasswords")
        expect( too_long_password_user ).not_to be_valid
      end
    end

    context "associations" do
      it "a user has a profile" do
        expect(user.profile).not_to be_nil
      end

      it "destroying a user destroys the profile" do
        user.save
        expect{ user.destroy }.to change{ Profile.count }.by(-1)
      end
    end

    context "generating auth tokens" do
      it "generates an auth token" do
        user.save
        expect(user.auth_token).not_to be_nil
      end

      it "generates a new auth token" do
        user.save
        at = user.auth_token
        user.regenerate_auth_token
        expect(user.auth_token).not_to eq(at)
      end
    end
  end

end
