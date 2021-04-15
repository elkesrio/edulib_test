class Repositories::FindOrCreate
  def initialize(url:, description:, nb_of_stars:)
    @url = url
    @description = description
    @nb_of_stars = nb_of_stars
  end

  def call
    repository.description = @description
    repository.nb_of_stars = @nb_of_stars
    repository.save!

    repository
  end

  private

  def repository
    @repository ||= Repository.find_or_initialize_by(url: @url)
  end
end
