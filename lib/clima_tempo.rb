require "net/http"
require "nokogiri"
require "clima_tempo/request"
require "clima_tempo/wind"
require "clima_tempo/now"
require "clima_tempo/today_forecast"

class ClimaTempo
  def initialize(code)
    @code = code
  end

  def now
    request.now
  end

  def today_forecast
    request.today_forecast
  end

  private
  def request
    @request ||= Request.new(@code)
  end
end
