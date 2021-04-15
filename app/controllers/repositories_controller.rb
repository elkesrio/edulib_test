class RepositoriesController < ApplicationController
  def index
    @repositories = Repositories::FetchOrList.new.call.map(&:decorate)
  end

  def show
    @repository = Repository.find(params[:id]).decorate
  rescue ActiveRecord::RecordNotFound
    redirect_to repositories_path
  end
end
