/**
 * Created by mario on 18-09-2015.
 */
$('#resultTable').html("<%= escape_javascript(render( partial: 'resultTable' ))%>");
$('#paginator').html("#{escape_javascript(paginate  @services , :remote => true)) }");