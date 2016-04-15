require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  	
  	# test that asserts that submitting a form for a new user does NOT 
  	# update the user count, as it should fail instead. 


  	test "invalid user signup information" do 	

  		assert_no_difference 'User.count' do
  			get signup_path
  			# ^ same as new_user_path. check routes.rb to see the change
  			
  			post users_path, user: {name: '',
  									email: 'user@invalid',
  									password: 'foo',
  									password_confirmation: 'bar'} 

  		end
  		# asserts that the page resubmits back to users/new
  		assert_template 'users/new'
  	end


  	test "valid user signup information" do
  		get signup_path
  		#the 1 is an optional param. it means, there should be a difference of 1.
  		assert_difference 'User.count',1  do 
  			post_via_redirect users_path, user: { name:  "Example User",
                                            email: "user@example.com",
                                            password:              "password",
                                            password_confirmation: "password" }

  		end
  		assert_template 'users/show'
  	end

end
