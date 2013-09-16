require 'test_helper'


describe "Authenticate" do

        describe "sign_in" do
        before { visit signin_path }

        describe "with invalid information" do
          before { click_button "Sign_in" }

          it { should have_title('Sign_in') }

        end
      end
end