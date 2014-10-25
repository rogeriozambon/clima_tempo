class Request
  def initialize(code)
    @code = code
  end

  def now
    @now ||= Now.new(request).data
  end

  def today_forecast
    @today_forecast ||= TodayForecast.new(request).data
  end

  private
  def request
    @request ||= to_html(Net::HTTP.get(URI.parse(url)))
  end

  def to_html(request)
    Nokogiri::HTML(request)
  end

  def url
    "http://www.climatempo.com.br/previsao-do-tempo/cidade/#{@code}/empty"
  end
end
