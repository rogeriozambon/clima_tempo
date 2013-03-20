# -*- encoding: utf-8 -*-
require "rest_client"
require "nokogiri"

class ClimaTempo
  attr_reader :code

  def initialize(option = {})
    raise ArgumentError if option.empty?

    @code = option[:code]
  end

  def now
    html = request_page

    values = html.xpath "//li[@class='dados-momento-li list-style-none']"
    region = html.xpath "//a[@class='thumb-play-prev']"

    {
      :temperature => html.xpath("//span[@class='left temp-momento top10']").text,
      :wind => wind_direction(prepare_value(values[0].text)),
      :condition => prepare_value(values[1].text),
      :pressure => prepare_value(values[2].text),
      :intensity => prepare_value(values[3].text),
      :moisture => prepare_value(values[4].text),
      :video => "http://www.climatempo.com.br#{region.first.attribute('href').value}"
    }
  end

  private
  def request_page
    RestClient.proxy = ENV["http_proxy"]

    request = RestClient.get "http://www.climatempo.com.br/previsao-do-tempo/cidade/#{@code}/empty"

    Nokogiri::HTML request.body
  end

  def prepare_value(value)
    value.gsub! /^.+:\s*/, ""
  end

  def wind_direction(acronym)
    direction = {
      "N" => "Norte",
      "S" => "Sul",
      "E" => "Leste",
      "W" => "Oeste",
      "NE" => "Nordeste",
      "NW" => "Noroeste",
      "SE" => "Sudeste",
      "SW" => "Sudoeste",
      "ENE" => "Lés-nordeste",
      "ESE" => "Lés-sudeste",
      "SSE" => "Su-sudeste",
      "NNE" => "Nor-nordeste",
      "NNW" => "Nor-noroeste",
      "SSW" => "Su-sudoeste",
      "WSW" => "Oés-sudoeste",
      "WNW" => "Oés-noroeste"
    }

    direction[acronym]
  end
end
