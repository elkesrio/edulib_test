require 'rails_helper'

RSpec.describe Repositories::FetchOrList do
  subject { described_class.new.call }

  before do
    allow_any_instance_of(Repositories::FindOrCreate).to receive(:call).and_return Repository.new
  end

  context 'when GithubClient#repositories succeeds' do
    before do
      allow_any_instance_of(GithubClient).to receive(:repositories) do
        repos_list_mock
      end
    end

    let(:repos_list_mock) do
      [{
        'html_url' => 'http://github.com/test',
        'description' => 'description',
        'nb_of_stars' => 5
      }]
    end

    it 'returns a repositories array' do
      expect(subject).to be_a Array
      expect(subject).to all(be_a Repository)
    end

    it 'calls Repositories::FindOrCreate with valid parameters' do
      repos_list_mock.each do |repo|
        expect(Repositories::FindOrCreate).to receive(:new).with(url: repo['html_url'],
                                                                 description: repo['description'],
                                                                 nb_of_stars: repo['stargazers_count']).and_call_original
        expect_any_instance_of(Repositories::FindOrCreate).to receive(:call)
      end

      subject
    end
  end

  context 'when GithubClient#repositories throws an error' do
    let!(:repositories) do
      [1, 2].map do |idx|
        Repository.create! url: "http://examples.com/#{idx}"
      end
    end

    before do
      allow_any_instance_of(GithubClient).to receive(:repositories).and_raise Github::Error::GithubError
    end

    it 'returns the repositories stored in the database' do
      expect(subject).to eq repositories
    end
  end
end
