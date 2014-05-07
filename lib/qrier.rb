require 'bundler'
Bundler.require

require 'erb'
require 'net/imap'
require 'net/smtp'
require 'qrier/version'
require 'qrier/config'
require 'qrier/helpers/imap_utils'
require 'qrier/services/fetch_emails'
require 'qrier/services/list_folders'
require 'qrier/services/send_email'
require 'qrier/models/email'
require 'qrier/models/folder'
require 'qrier/app'

Qrier::Config.load
