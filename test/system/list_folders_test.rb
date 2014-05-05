require 'test_helper'
require 'qrier/models/folder'
require 'qrier/helpers/imap_utils'
require 'qrier/services/list_folders'

module Qrier
  class ListFoldersTest < MiniTest::Test
    service = ListFolders.new
    service.execute
    @@folders = service.folders

    def test_lists_all_folders
      assert_kind_of Folder, @@folders.first
    end

    def test_folder_has_emails
      assert_kind_of Email, @@folders.first.emails.first
    end
  end
end
