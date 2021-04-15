class GithubClient
  def repositories(user:)
    client.repos.list user: user
  end

  private

  def client
    @client ||= Github.new
    # @client ||= Github.new endpoint: 'http://google.com/'
  end
end
