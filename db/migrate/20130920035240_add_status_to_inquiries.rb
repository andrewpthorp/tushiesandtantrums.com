class AddStatusToInquiries < ActiveRecord::Migration
  def change
    add_column :inquiries, :status, :string
    Inquiry.reset_column_information
    Inquiry.update_all(status: 'unread')
  end
end
