class DeleteUser
  def initialize(user_id:)
    @user = User.find(user_id)
  end

  def call
    #...
  end
end

---------------

class DeleteUser
  def initialize(user_id:)
    @user_id = user_id
  end

  def call
    #...
  end

  private

  atr_reader :user_id

  def user
    @ser ||= User.find(user_id)
  end
end