# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name = "clima_tempo"
  s.authors = ["Rogério Zambon"]
  s.email = ["rogeriozambon@gmail.com"]
  s.date = "2013-01-22"
  s.description = "Get brazilian weather values of the ClimaTempo"
  s.homepage = "http://github.com/rogeriozambon/clima_tempo"

  s.add_dependency "rest-client", ">= 1.6.7"
  s.add_dependency "nokogiri", ">= 1.5.6"
  s.add_development_dependency "fakeweb", ">= 1.3"

  s.files = `git ls-files`.split("\n")
  s.require_paths = ["lib"]

  s.required_rubygems_version = Gem::Requirement.new(">= 1.8.23")
  s.summary = s.description

  s.version = "1.0"
end
