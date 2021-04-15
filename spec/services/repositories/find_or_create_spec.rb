require 'rails_helper'

RSpec.describe Repositories::FindOrCreate, type: :request do
  let(:subject) do
    described_class.new(url: url, description: description, nb_of_stars: nb_of_stars).call
  end

  let(:description) { 'description' }
  let(:nb_of_stars) { 10 }
  let(:url) { 'http://example.com' }

  context 'when the url already exists' do
    let!(:old_repo) { Repository.create! url: url, description: description, nb_of_stars: nb_of_stars }

    it 'doesnt create a new repository' do
      expect { subject }.not_to change(Repository, :count)
    end

    it 'returns the old repository' do
      expect(subject).to eq old_repo
    end
  end

  context 'when the url doesnt exist' do
    it 'creates a new repository' do
      expect { subject }.to change(Repository, :count).by 1
    end

    it 'returns a repository' do
      expect(subject).to be_a Repository
    end
  end
end
