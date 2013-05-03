# -*- encoding: utf-8 -*-
require "net/http"
require "nokogiri"

class ClimaTempo
  attr_reader :code

  def initialize(option = {})
    raise ArgumentError if option.empty?

    @code = option[:code]
  end

  def now
    html = request

    values = html.xpath "//li[@class='dados-momento-li list-style-none']"
    region = html.xpath "//a[@class='thumb-play-prev']"

    now = {
      :temperature => html.xpath("//span[@class='left temp-momento top10']").text,
      :wind => wind_direction[prepare(values[0].text)],
      :condition => prepare(values[1].text),
      :pressure => prepare(values[2].text),
      :intensity => prepare(values[3].text),
      :moisture => prepare(values[4].text)
    }

    now.merge! :video => "http://www.climatempo.com.br#{region.first.attribute('href').value}" unless region.first.nil?

    now
  end

  private
  def request
    request = Net::HTTP.get URI.parse("http://www.climatempo.com.br/previsao-do-tempo/cidade/#{@code}/empty")

    Nokogiri::HTML request
  end

  def prepare(value)
    value.gsub! /^.+:\s*/, ""
  end

  def wind_direction
    {
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
  end
end
