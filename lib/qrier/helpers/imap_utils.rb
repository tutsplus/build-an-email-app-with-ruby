module Qrier::IMAPUtils
  def address field
    field ? [ field.first.mailbox, '@', field.first.host ].join : nil
  end
end
