# frozen_string_literal: true

require 'net/http'
require 'open-uri'

class RelationsController < ApplicationController
  authorize_resource class: false

  def index
    @profile1_id = params[:profile1_id]
    @profile2_id = params[:profile2_id]
    @content = if [@profile1_id, @profile2_id].any?(&:blank?)
                 I18n.t('relations.missing_input')
               else
                 api_output(api_call_result)
               end
  rescue StandardError => e
    @content = I18n.t('general_error')
    @error = e.message
  end

  private

  def api_output(response)
    puts_body_content
    if response.code == '200'
      format_output(JSON.parse(response.body)['choices'].first['message']['content'])
    else
      I18n.t('general_error')
    end
  end

  def format_output(output)
    output = output.gsub(profiles(@profile1_id).idh, profiles(@profile1_id).designation)
                   .gsub(profiles(@profile2_id).idh, profiles(@profile2_id).designation)
    MADE_UP_NAMES.each { |name| output.gsub!(name, 'someone') }
    output
  end

  def puts_body_content
    puts '------------------'
    puts '------------------'
    puts '------------------'
    puts 'START OF BODY CONTENT'
    puts body_content
    puts model
    puts 'END OF BODY CONTENT'
    puts '------------------'
    puts '------------------'
    puts '------------------'
  end

  def api_call_result
    uri = URI(openai_url)

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = (uri.scheme == 'https')

    request = Net::HTTP::Post.new(openai_url)
    request['Content-Type'] = 'application/json'
    request['Authorization'] = "Bearer #{ENV.fetch('OPENAI_API_KEY')}"
    request.body = { messages: [{ role: 'user', content: body_content }],
                     model: model }.to_json

    http.request(request)
  end

  def model
    ENV.fetch('OPENAI_API_MODEL', 'gpt-4')
  end

  def openai_url
    ENV.fetch('OPENAI_API_URL', 'https://api.openai.com/v1/chat/completions')
  end

  def profiles(id)
    @profiles ||= {}
    @profiles[id] ||= Profile.find_by(id: id)
  end

  def body_content
    # api_call: 'I will provide you with a hash structured like this:
    # {"Barabara D'Amore Dietrich"=>["is the father of Ahmad Reichel Gusikowski",
    #                                "is in a relationship with Almeda Leannon Hoppe V"],
    #  "Almeda Leannon Hoppe V"=>["is the mother of Ahmad Reichel Gusikowski",
    #                             "is in a relationship with Barabara D'Amore Dietrich"],
    #  "Ahmad Reichel Gusikowski"=>["is the son of Barabara D'Amore Dietrich and Almeda Leannon Hoppe V"]}.
    # The hash contains family tree information where each key represents a person,
    # and the corresponding value is an array of strings describing their relationships with others.
    # Given this hash and the names of two persons: %{profile1} and %{profile2},
    # Determine and describe the family connection between these two individuals in a single, accurate sentence,
    # without mentioning any other persons.
    # The family hash is as follows. %{family_text_description}'
    I18n.t('relations.api_call',
           profile1: profiles(@profile1_id).idh,
           profile2: profiles(@profile2_id).idh,
           family_text_description: profiles(@profile1_id).full_family_text_description)
        .squish
  end
end
