#!/usr/bin/env ruby

require 'dotenv'
require 'gmail'

Dotenv.load

GMAIL_USERNAME = ENV['GMAIL_USERNAME']
GMAIL_PASSWORD = ENV['GMAIL_PASSWORD']

gmail = Gmail.connect(GMAIL_USERNAME, GMAIL_PASSWORD)

KEYWORDS_REGEX = /absent|aide|alternance/i

gmail.inbox.find(:unread, from: 'arthurjacquemin2@gmail.com').each do |email|
  if email.body[KEYWORDS_REGEX]
    # Send a message
    reply = create_reply(email.subject)
    gmail.deliver(reply)
  end
end

def create_reply(subject)
  gmail.compose do
    to 'arthurjacquemin2@gmail.com'
    subject "RE: #{subject}"
    body "Stop de m'emmerder !"
  end
end