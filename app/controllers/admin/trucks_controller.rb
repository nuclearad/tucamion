class Admin::TrucksController < ApplicationController
  before_action :authenticate_user!
  layout  'admin/layouts/application'
  add_breadcrumb 'Camiones', :admin_trucks_path, :options => { :title =>'Inicio' }

  before_action :checkTimes, only: [:edit,:update]

  def index
    @search             = Truck.includes(:type_truck, :brand_truck, :state).search(params[:q])
    @trucks             = @search.result.order(type_truck_id: :asc)
    @types              = TypeTruck.all
    @query_search_field = 'nombre_cont'
    @trucks_filter      = @search.result.page(params[:page]).per(Environment::LIMIT_SEARCH)
    respond_to do |format|
      format.html {}
      format.json { render json: @trucks_filter, :include =>[:state, :type_truck, :brand_truck, :customer] }
      format.pdf{build_pdf}
      format.js{ }
    end
  end

  def show

  end

  def new
    logger.info "********#{__method__}**********"
    logger.info "*****#{params}****"
    @truck = Truck.new
    @truck.type_truck_id= params['v']
    @capacidadcarga = Environment::CAPACIDAD_CARGA
    add_breadcrumb 'Agregar'
  end

  def create
    @truck = Truck.new(allowed_params)
    @truck.user_id = current_user.id
    if @truck.save
      flash[:notice] = 'Información agregada correctamente'
      redirect_to admin_trucks_path
    else
      flash[:notice] = 'Error Guardando en el registro'
      @capacidadcarga = Environment::CAPACIDAD_CARGA
      render 'new' , :v=>@truck.type_truck_id
      #redirect_to new_admin_truck_path(:v=>@truck.type_truck_id)
    end


  end

  def checkTimes
      truck = Truck.find(params[:id])
      @bandera= (truck.created_at >= Date.today - 10) #false indica que solo  puede editar telefono, precio y estado
  end

  def edit
    @truck = Truck.find(params[:id])
    @cities= City.where('state_id = ?', @truck.state_id)
    @placaCities= City.where('state_id =?', @truck.placa_state_id)
    @capacidadcarga = Environment::CAPACIDAD_CARGA

    add_breadcrumb 'Editar'
  end

  def update
    @truck = Truck.find(params[:id])
    if params[:picture1]=='1'
      logger.info 'entro en borrar'
      @truck.picture1.destroy
      @truck.picture1.clear
    end
    if @truck.update_attributes(allowed_params)
      flash[:notice] = 'Información actualizada correctamente'
      redirect_to admin_trucks_path
    else
      @cities= City.where('state_id = ?', @truck.state_id)
      @placaCities= City.where('state_id =?', @truck.placa_state_id)
      @capacidadcarga = Environment::CAPACIDAD_CARGA
      render :edit, :v=>@truck.type_truck_id
    end


  end

  def destroy
    @truck = Truck.find(params[:id])
    if @truck.destroy
      flash[:notice] = 'Información eliminada correctamente'
      redirect_to admin_trucks_path
    else
      render 'new'
    end
  end



  def removePicture
    logger.info "******* #{__method__} ******* #{params} *******"
    imagen =  params[:imagen]
    id =  params[:idAnuncio]
    type = params[:anuncioType]
    case type
      when '0'
        @truck = Truck.find(id)
      when '1'
        @truck = Truck.find(id)
      when '2'
        @truck = Extra.find(id)
      when '3'
        @truck = Extra.find(id)
      else
        @truck = Service.find(id)
    end
    @truck.instance_eval('picture'+imagen).destroy
    @truck.instance_eval('picture'+imagen).clear
    if @truck.save
      respuesta = [:respuesta=>true ]
    else
      respuesta = [:respuesta=>false ]
    end
    case type
      when '0'
       redirect_to micamionesedit_path(:id=> id) and return
      when '1'
       redirect_to edit_admin_truck_path(:id=> id) and return
      when '2'
        redirect_to edit_admin_extra_path(:id=> id) and return
      when '3'
       redirect_to mirepuestosedit_path(:id=> id) and return
      when '4'
        redirect_to edit_admin_service_path(:id=> id) and return  
      else
        redirect_to miserviciosedit_path(:id=> id) and return
    end
  end


  def permit!
    each_pair do |key, value|
      convert_hashes_to_parameters(key, value)
      self[key].permit! if self[key].respond_to? :permit!
    end

    @permitted = true
    self
  end


  private
  def allowed_params
    #params.require(:truck).permit(:nombre, :quintarueda)
      params.require(:truck).permit!
  end

  def build_pdf
      begin

         Dir.mkdir(Rails.root.join('trucks_pdf')) unless File.exists?(Rails.root.join('trucks_pdf'))

         pdf_name = "#{Time.now.strftime('%d%m%y%H%M%S')}"
        
         pdf_file = WickedPdf.new.pdf_from_string(
                           render_to_string("admin/trucks/export.pdf.haml", layout: "pdf.html"),
                           page_size: 'Letter',
                           orientation: 'Landscape',
                           header: { :spacing => 5 , content: render_to_string({template: 'layouts/header_trucks.pdf.haml'}) }, 
                           footer: { :spacing => 5 , content: render_to_string({template: 'layouts/footer_trucks.pdf.haml'}) }, 
                           margin: { :top=> 55, :bottom=> 35, :left=> 10, :right=> 10}, 
                           zoom:'1.3', 
                           dpi:'96',
                           no_pdf_compression: false
         )

          save_path = Rails.root.join('trucks_pdf', "#{pdf_name}.pdf")
          File.open(save_path, 'wb') do |file|
           file << pdf_file
          end

          send_file save_path, type: 'application/pdf', filename: pdf_name, disposition: 'inline', stream: false
      
      rescue Exception => e
         puts e.to_s
         return false
      end
  end

end
