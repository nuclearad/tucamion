/**
 * Created by mario on 18-09-2015.
 */
$('#tabla').html("<%= escape_javascript(render( partial: 'shared/tableResult', locals:{objects:@subs_filter, object_controller_name: controller_name} ))%>");
$('#paginator').html("#{escape_javascript(paginate @subs_filter , :remote => true)) }");