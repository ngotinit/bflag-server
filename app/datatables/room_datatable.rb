class RoomDatatable < AjaxDatatablesRails::Base
  extend Forwardable

  def_delegator :@view, :link_to
  def_delegator :@view, :admin_room_path
  def_delegator :@view, :edit_admin_room_path

  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      id:         { source: "Room.id" },
      name:       { source: "Room.name" },
      show:       { source: "Room.show", searchable: false, orderable: false },
      edit:       { source: "Room.edit", searchable: false, orderable: false },
      delete:     { source: "Room.delete", searchable: false, orderable: false }
    }
  end

  def data
    records.map do |record|
      {
        id:         record.id,
        name:       record.name,
        show:       link_to('Show', admin_room_path(record), class: 'btn btn-primary'),
        edit:       link_to('Edit', edit_admin_room_path(record), class: 'btn btn-warning'),
        delete:     link_to('Delete', admin_room_path(record), method: :delete,
                            data: { confirm: 'Are you sure?' }, class: 'btn btn-danger')
      }
    end
  end

  def get_raw_records
    # insert query here
    Room.all
  end
end
