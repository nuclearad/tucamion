/**
 * Created by mario on 18-09-2015.
 */
$('#tabla').html("<%= escape_javascript(render partial:'shared/tableResult', locals:{objects:@marcas_filter, object_controller_name: controller_name}) %>");
$('#paginador').html("<%= escape_javascript(paginate(@marcas_filter, :remote => true))%>");