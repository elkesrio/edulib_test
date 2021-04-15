class RepositoryDecorator < Draper::Decorator
  delegate_all

  def name
    url.split('/').last
  end
end
