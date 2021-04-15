require 'rails_helper'

RSpec.describe Repository, type: :model do
  subject { Repository.create! url: url, description: description, nb_of_stars: nb_of_stars }

  let(:description) { 'description' }
  let(:nb_of_stars) { 100 }
  let(:url) { 'http://example.com' }

  context 'when the url does not exist' do
    it 'doesnt throw any error' do
      expect { subject }.not_to raise_error
    end
  end

  context 'when the url already exists' do
    before { Repository.create! url: url }

    it 'throws an error' do
      expect { subject }.to raise_error ActiveRecord::RecordInvalid, 'Validation failed: Url has already been taken'
    end
  end
end
