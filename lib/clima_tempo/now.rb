class Now
  def initialize(request)
    @request = request
  end

  def data
    {
      temperature: temperature,
      wind: wind,
      condition: condition,
      pressure: pressure,
      intensity: intensity,
      moisture: moisture
    }
  end

  private
  def temperature
    @request.xpath("//span[@class='left left10 top10 temp-momento']").text
  end

  def wind
    Wind.new(prepared_data[0].text)
  end

  def condition
    prepared_data[1].text.gsub!(/^.+:\s*/, "")
  end

  def pressure
    prepared_data[2].text.gsub!(/^.+:\s*/, "")
  end

  def intensity
    prepared_data[3].text.gsub!(/^.+:\s*/, "")
  end

  def moisture
    prepared_data[4].text.gsub!(/^.+:\s*/, "")
  end

  def prepared_data
    @prepared_data ||= @request.xpath("//li[@class='dados-momento-li list-style-none']")
  end
end
