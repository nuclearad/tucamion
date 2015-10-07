/**
 * Created by mario on 18-09-2015.
 */
$('#tabla').html("<%= escape_javascript(render partial:'shared/tableResult', locals:{objects:@colors_filter, object_controller_name: controller_name}) %>");
$('#paginator').html("#{escape_javascript(paginate(@colors_filter , :remote => true)) }");