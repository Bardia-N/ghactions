#!/usr/bin/env ruby

require 'fileutils'
require 'yaml'

def getArgsNotification
  {
    "handle" => ENV["HANDLE_VAR"],
    "type" => ENV["TYPE_VAR"],
    "context_key" => ENV["CONTEXT_KEY_VAR"],
    "title_key" => ENV["TITLE_KEY_VAR"],
    "description_key" => ENV["DESCRIPTION_KEY_VAR"],
    "primary_cta_label_key" => ENV["PRIMARY_CTA_LABEL_KEY_VAR"],
    "primary_cta_url" => ENV["PRIMARY_CTA_URL_VAR"],
    "secondary_cta_label_key" => ENV["SECONDARY_CTA_LABEL_KEY_VAR"],
    "secondary_cta_url" => ENV["SECONDARY_CTA_URL_VAR"],
    "targeting" => ENV["TARGETING_VAR"],
    "published_at" => ENV["PUBLISHED_AT_VAR"],
    "expires_at" => ENV["EXPIRES_AT_VAR"],
    "deleted" => ENV["DELETED_VAR"],
    "roles" => ENV["ROLES_VAR"].split(" "),
    "permissions" => ENV["PERMISSIONS_VAR"].split(" "),
  }.delete_if { |key, value| value.to_s.strip == '' }
end

def getArgsTranslations
  {
    context: ENV["CONTEXT_VAL_VAR"],
    title: ENV["TITLE_VAL_VAR"],
    description: ENV["DESCRIPTION_VAL_VAR"],
    primary_cta_label: ENV["PRIMARY_CTA_LABEL_VAL_VAR"],
    secondary_cta_label: ENV["SECONDARY_CTA_LABEL_VAL_VAR"],
  }.delete_if { |key, value| value.to_s.strip == '' }
end

def translations_template()
  <<~EOF
  en:
    db:
      data:
        notifications:
          #{ENV["HANDLE_VAR"]}:
  EOF
end


File.open('test.yml', 'a') do |file|
  file.write([getArgsNotification].to_yaml())
end

FileUtils.mkdir_p("config/locales/notifications/#{ENV["HANDLE_VAR"]}")
File.open('en.yml', 'w') do |file|
  file.puts translations_template()
  getArgsTranslations.each do |arg, value|
    file.puts "          #{arg}: #{value}"
  end
end