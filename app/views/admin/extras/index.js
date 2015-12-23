/**
 * Created by mario on 18-09-2015.
 */
$('#tabla').html("<%= escape_javascript(render( partial: 'resultTable' ))%>");
$('#paginador').html("<%= escape_javascript(paginate(@extras, :remote => true))%>");