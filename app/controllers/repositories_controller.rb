class RepositoriesController < ApplicationController
  def index
    @repositories = Repositories::FetchOrList.new.call.map(&:decorate)
  end

  def show
    @repository = Repository.find(params[:id]).decorate
  end
end
