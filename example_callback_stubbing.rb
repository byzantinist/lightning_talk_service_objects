class Post < ActiveRecord::Base
  has_many :followers
  after_save :notify_followers

  def publish!
    self.published_at = Time.now
    save
  end

  private

  def notify_followers
    Notify.post_mailer.deliver
  end
end

describe "publishing the article" do
  it "saves the object with a defined published_at value" do
    Post.any_instance.stub)(:notify_followers)
    post = Post.new(title => "The Problem with Callbacks in Rails")
    post.publish!
    expect(post.published_at).tobe_an_kind_of(Time)
    expect(post).to_not be_a_new_record
  end
end