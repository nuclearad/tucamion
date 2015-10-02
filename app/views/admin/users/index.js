/**
 * Created by mario on 17-09-2015.
 */
$('#tabla').html("<%= escape_javascript(render partial: 'tableResult', locals:{ objects: @admin_users_filter})%>");