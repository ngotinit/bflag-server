$(document).ready(function() {
    $("table[role='datatable']").each(function(){
    var table = $(this).DataTable({
        ordering: true,
        bLengthChange: false,
        iDisplayLength: 20,
        bFilter: true,
        pagingType: "full",
        bInfo: false,
        dom: "Bfrtip",
        buttons: [{
            extend: 'pdf',
            text: 'Exportar PDF',
            title: 'Nuse'
        }, {
            extend: 'excel',
            text: 'Exportar Excel',
            title: 'Nuse'
        }],
        language: {
            emptyTable: "<span class='text-danger' align='center'> <h3>No data</h3></span>",
            paginate: {
                previous: "<button type='button' style='margin:3px'> < </button>",
                next: "<button type='button' style='margin:3px'> > </button>",
                first: "<button type='button' style='margin:3px'> |< </button>",
                last: "<button type='button' style='margin:3px'> >| </button>"
            }
          }

    });
  });
});
