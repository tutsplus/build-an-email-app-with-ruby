# encoding: utf-8
require "test_helper"
require 'net/imap'
require "qrier/services/fetch_emails"

module Qrier
  class FetchEmailsTest < Minitest::Test
    service = FetchEmails.new
    service.execute
    @@emails = service.emails

    def test_fetches_emails
      assert_kind_of Email, @@emails.first
    end

    def test_has_correct_time
      assert_kind_of Time, @@emails.first.sent_at
    end

    def test_has_subject
      assert_equal "First email ever!", @@emails.first.subject
    end

    def test_has_correct_encoding
      assert_includes @@emails.first.body, "José Mota"
    end

    def test_it_is_new
      assert @@emails.first.new?, "Expected email to be new."
    end
  end
end
