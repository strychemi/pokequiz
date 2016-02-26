require 'rails_helper'

describe User, type: :model do
  let(:user) { build :user }

  context "creating a user" do
    context "valid information" do
      it "default user is valid" do
        expect( user ).to be_valid
      end
    end

    context "invalid information" do
      it "a user with an empty email is invalid" do
        blank_email_user = 
        expect( blank_email_user ).not_to be_valid
      end

      it "a user with a nil email is invalid" do
        expect( nil_email_user ).not_to be_valid
      end

      it "a user with a duplicate email is invalid" do
        user.save
        new_user = build(:user, email: user.email)
        expect(new_user).not_to be_valid
      end

      it "a user with an empty password is invalid" do
        expect( passwordless_user ).not_to be_valid
      end
    end
  end

end
