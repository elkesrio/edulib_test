require 'rails_helper'

RSpec.describe GithubClient do
  describe '#repositories' do
    subject { GithubClient.new.repositories user: user }

    let(:user) { 'user' }

    before do
      allow_any_instance_of(Github::Client::Repos).to receive(:list) do
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

    it 'returns the repos list' do
      expect(subject).to eq repos_list_mock
    end

    it 'calls Github::Client::Repos with valid parameters' do
      expect_any_instance_of(Github::Client::Repos).to(receive(:list)).with(user: user)
      subject
    end
  end
end
