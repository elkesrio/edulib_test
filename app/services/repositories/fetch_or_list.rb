class Repositories::FetchOrList
  USERNAME = 'edulib-france'.freeze

  def call
    fetch_and_update_repositories!
  rescue Github::Error::GithubError
    Repository.all
  end

  private

  def github_client
    @github_client ||= GithubClient.new
  end

  def fetch_and_update_repositories!
    Repository.transaction do
      Repository.delete_all

      github_client.repositories(user: USERNAME).map do |repo|
        Repositories::Create.new(url: repo['html_url'], description: repo['description'],
                                 nb_of_stars: repo['stargazers_count']).call
      end
    end
  end
end