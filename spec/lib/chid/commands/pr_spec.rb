require 'spec_helper'

describe ::Chid::Commands::Pr, '#run', :github, mock: true  do
  let(:invoke_run) do
    argv = ['pr']
    argv.concat(arguments)
    argv.compact!
    Chid::Command.run(argv)
  end

  context 'when given an user as arguments' do
    let(:user)      { 'ricmarinovic' }
    let(:arguments) { ['-user', user] }

    before do |example|
      allow_github_prs if example.metadata[:mock]

      invoke_run
    end

    let(:allow_github_prs) do
      response_prs = [
        {
          'number' => 41,
          'title'  => 'Update README',
          'state'  => 'open',
          'labels' => [],
          'user'   => { 'login' => 'rachidcalazans'}
        },
        {
          'number' => 42,
          'title'  => 'A new PR arrived',
          'state'  => 'open',
          'labels' => [{'name' => 'in progress'}, {'name' => 'question'}],
          'user'   => { 'login' => user}
        },
        {
          'number' => 43,
          'title'  => 'One more PR',
          'state'  => 'open',
          'labels' => [{'name' => 'in progress'}],
          'user'   => { 'login' => user}
        }
      ]
      allow(GitHubApi).to receive(:prs)
        .with(by: user)
        .and_return(response_prs)
    end

    it 'lists all open pull requests' do
      expected_msg = <<~STR
      #42 - A new PR arrived
      By #{user}
      Status: open
      Labels: in progress, question

      ---
      
      #43 - One more PR
      By #{user}
      Status: open
      Labels: in progress
      STR

      expect(invoke_run).to eql(expected_msg)
    end
  end
end
