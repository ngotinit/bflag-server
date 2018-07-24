class UserDatatable < AjaxDatatablesRails::Base
  extend Forwardable

  def_delegator :@view, :link_to
  def_delegator :@view, :admin_user_path
  def_delegator :@view, :edit_admin_user_path

  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      id:         { source: "User.id" },
      username:   { source: "User.username" },
      email:      { source: "User.email" },
      first_name: { source: "User.first_name" },
      last_name:  { source: "User.last_name" },
      show:       { source: "User.show", searchable: false, orderable: false },
      edit:       { source: "User.edit", searchable: false, orderable: false },
      delete:     { source: "User.delete", searchable: false, orderable: false }
    }
  end

  def data
    records.map do |record|
      {
        id:         record.id,
        username:   record.username,
        email:      record.email,
        first_name: record.first_name,
        last_name:  record.last_name,
        show:       link_to('Show', admin_user_path(record), class: 'btn btn-primary'),
        edit:       link_to('Edit', edit_admin_user_path(record), class: 'btn btn-warning'),
        delete:     link_to('Delete', admin_user_path(record), method: :delete,
                            data: { confirm: true }, class: 'btn btn-danger')
      }
    end
  end

  def get_raw_records
    # insert query here
    User.all
  end

end
