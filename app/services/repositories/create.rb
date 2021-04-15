class Repositories::Create
  def initialize(url:, description:, nb_of_stars:)
    @url = url
    @description = description
    @nb_of_stars = nb_of_stars
  end

  def call
    Repository.create! url: @url, description: @description, nb_of_stars: @nb_of_stars
  end
end
