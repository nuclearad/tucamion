/**
 * Created by mario on 17-09-2015.
 */
$('#tabla').html("<%= escape_javascript(render partial: 'tableResult', locals:{ objects: @admin_users_filter})%>");
$('#paginator').html("#{escape_javascript(paginate(@admin_users_filter , :remote => true)) }");