# Improving Large Rails Apps with Service Objects by Aaron Lasseigne
# https://aaronlasseigne.com/2016/04/27/improving-large-rails-apps-with-service-objects/



# Code starts in the controller:

def new
  @user = User.new
end

def create
  @user = User.create(params[:user])

  if @user.valid?
    Notifications.welcome(@user).deliver_later

    redirect_to(@user)
  else
    render 'new'
  end
end

# Then progresses to the model:

User.sign_up
Group.invite
Issue.comment
Cart.purchase

# Then progresses to service objects:

# Instead of User.sign_up you’ll have SignUp. Each interaction is called with run and passed a Hash of arguments.

SignUp.run(
  client: Client.find(1),
  name: 'Aaron',
  email: 'aaron.lasseigne@gmail.com',
  password: 'supersecure'
)

# In a controller you might directly pass params.

SignUp.run(params.merge(client: current_client))

# The interaction itself looks like this:

class SignUp < ActiveInteraction::Base
  object :client
  string :name, :email, :password

  def execute
    user = User.create(
      client: client,
      name: name,
      email: email,
      password: password
    )

    if user.valid?
      Notifications.welcome(user).deliver
    else
      errors.merge!(user.errors)
    end

    user
  end
end

# Using it in your controller will also look familiar.

def new
  @sign_up = SignUp.new
end

def create
  @sign_up = SignUp.run(params[:user])

  if @sign_up.valid?
    user = @sign_up.result
    redirect_to(user)
  else
    render 'new'
  end
end