class UserDatatable < AjaxDatatablesRails::Base

  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      id:         { source: "User.id" },
      username:   { source: "User.username" },
      email:      { source: "User.email" },
      first_name: { source: "User.first_name" },
      last_name:  { source: "User.last_name" }
    }
  end

  def data
    records.map do |record|
      {
        id:         record.id,
        username:   record.username,
        email:      record.email,
        first_name: record.first_name,
        last_name:  record.last_name
      }
    end
  end

  def get_raw_records
    # insert query here
    User.all
  end

end
