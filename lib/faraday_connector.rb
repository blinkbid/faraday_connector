# frozen_string_literal: true

require_relative "faraday_connector/version"
require "concurrent"
require "faraday"
require "faraday_curl"
require "oj"

module FaradayConnector
  def request
    return @_request if defined?(@_request)

    # creating a Promise for async approach
    @_request = Concurrent::Promises.future { do_request }
  end

  def process
    return @_process if defined?(@_process)

    request
    @_process = do_process
  end

  protected

  def do_request
    # implement the real request in Child
    raise NotImplementedError
  end

  def do_process
    # implement additional response decorations in Child
    raise NotImplementedError
  end

  def url
    raise NotImplementedError
  end

  def auth
    raise NotImplementedError
  end

  def additional_headers
    {}
  end

  def get(path, params = {})
    handle_request { connection.get(path, params) }
  end

  def post(path, body = {})
    handle_request { connection.post(path, body) }
  end

  def delete(path, params = {})
    handle_request { connection.delete(path, params) }
  end

  def put(path, body = {})
    handle_request { connection.put(path, body) }
  end

  def connection
    @connection ||= Faraday.new(url: url) do |connection|
      connection.headers = connection.headers.merge(additional_headers) if additional_headers
      connection.response :raise_error
      connection.response :logger
      connection.response :json, parser_options: { decoder: Oj }
    end
  end

  def handle_request
    yield
  end
end
