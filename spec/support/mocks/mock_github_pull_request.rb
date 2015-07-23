class MockGithubPullRequest < Struct.new(:user, :title, :number, :merged_at)
  def self.merged_pulls
    pulls = []
    pulls << MockGithubPullRequest.new(MockGithubUser.lance_hardwood,
                                       'title1',
                                       1,
                                       DateTime.current)
    pulls << MockGithubPullRequest.new(MockGithubUser.lance_hardwood,
                                       'title2',
                                       2,
                                       DateTime.current)
    pulls
  end

  def self.mixed_list
    pulls = []
    pulls << MockGithubPullRequest.new(MockGithubUser.lance_hardwood,
                                       'title1',
                                       1,
                                       DateTime.current)
    pulls << MockGithubPullRequest.new(MockGithubUser.lance_hardwood,
                                       'title3',
                                       3,
                                       nil)
    pulls
  end
end

class MockGithubUser < Struct.new(:login, :avatar_url)
  def self.lance_hardwood
    MockGithubUser.new 'lance_hardwood', 'http://a.b.com/lance.jpg'
  end
end
