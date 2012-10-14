require 'test_helper'
require 'evilspace'

describe Evilspace::Middleware do
  let(:source_dir) { 'app' }
  let(:source_filename) { 'app/newfile.rb' }

  def app
    Rack::Builder.new {
      use Evilspace::Middleware, ['app']
      run lambda { |env|
        [
          200,
          {'Content-Type' => 'text/html'},
          ['app page']
        ]
      }
    }.to_app
  end

  def http_get_request
    get '/', {}, {'HTTP_ACCEPT' => 'text/html'}
  end

  def create_file_with(string)
    File.open(source_filename, 'w+') do |f|
      f.print "foo\n"
      f.print string
      f.print "bar\n"
      f.print "\n"
    end
  end

  def remove_file
    FileUtils.rm(source_filename)
  end

  def self.it_should_respond_with_alert
    it 'should respond with evilspace alert' do
      http_get_request

      last_response.body.wont_equal 'app page'
      last_response.body.must_include 'Evilspace Alert'
    end
  end

  before do
    FileUtils.mkdir(source_dir)
  end

  after do
    remove_file
    FileUtils.rmdir(source_dir)
  end

  context 'good spaces' do
    before { create_file_with "  good spaces\n" }

    it 'shoudl respond with application page' do
      http_get_request
      last_response.body.must_equal 'app page'
    end
  end

  context 'trailing spaces' do
    before { create_file_with "trailing spaces  \n" }

    it_should_respond_with_alert
  end

  context 'tabs' do
    before { create_file_with "#{9.chr}tabs indentation\n" }

    it_should_respond_with_alert
  end
end
