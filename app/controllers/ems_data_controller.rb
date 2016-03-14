# encoding: utf-8
require 'digest/sha1' 
require 'json'

class EmsDataController < ApplicationController
  @@token = "laas"
  skip_before_filter :verify_authenticity_token

  before_action :set_ems_datum, only: [:show, :edit, :update, :destroy]

  # GET /ems_data
  def index
    @ems_data = EmsDatum.all
    	#~ group_id = '4'
	#~ @datas = ""
	#~ if ['1', '2', '3'].include?(group_id) then
		#~ @ems_data = EmsDatum.where(group: group_id).order(:id)
	#~ else
		#~ @datas << "回复1，查看水用量\n"
		#~ @datas << "回复2，查看电用量\n"
		#~ @datas << "回复3，查看煤用量\n"
		#~ @datas << "回复其他，查看所有介质用量\n"
		#~ @ems_data = EmsDatum.all.order(:id)
	#~ end
	#~ @ems_data.each do |item| 
		#~ @datas << "#{item.tagname}:#{item.value}\n"
	#~ end 	
	#~ render text: @datas
  end

  # GET /ems_data/1
  def show
  end

  # GET /ems_data/new
  def new
    @ems_datum = EmsDatum.new
  end

  # GET /ems_data/1/edit
  def edit
  end

  # POST /ems_data
  def create
    @ems_datum = EmsDatum.new(ems_datum_params)

    if @ems_datum.save
      redirect_to @ems_datum, notice: 'Ems datum was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /ems_data/1
  def update
   #~ render text: 'hi'
   #~ json_params = ActionController::Parameters.new( JSON.parse(request.body.read) )
   #~ render text: json_params
   #~ render text: params
   #~ render text: "{'data':#{params[:data]}}"  
    if @ems_datum.update(ems_datum_params)
      redirect_to @ems_datum, notice: 'Ems datum was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /ems_data/1
  def destroy
    @ems_datum.destroy
    redirect_to ems_data_url, notice: 'Ems datum was successfully destroyed.'
  end
  
  def weixin_auth
     if check_signature?(params[:signature],params[:timestamp],params[:nonce])  
	return render text: params[:echostr]
     else
        return render text: "wrong weixin auth"	     
     end
  end
  
  def weixin_process
     if check_signature?(params[:signature],params[:timestamp],params[:nonce])  
	group_id = params[:xml][:Content]
	@datas = ""
	if ['1', '2', '3','4'].include?(group_id) then
		ems_data = EmsDatum.where(group: group_id).order(:id)
		ems_data.each do |item| 
			@datas << "#{item.tagname}: #{item.value}\n"
		end 	
	else
		@datas << "回复1，查看联合工房各区域温湿度\n"
		@datas << "回复2，查看能源供应实时数据\n"
		@datas << "回复3，查看联合工房1-9号机组运行状态\n"
		@datas << "回复4，查看联合工房10-19号机组运行状态"
	end
	render :weixin, layout: false, :formats => :xml  
     else
       render text: ""
     end
   end

  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ems_datum
      @ems_datum = EmsDatum.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def ems_datum_params
      params.require(:ems_datum).permit(:tagname, :value, :group)
    end
    
    def check_signature?(signature,timestamp,nonce)
	begin
		Digest::SHA1.hexdigest([timestamp,nonce,@@token].sort.join) == signature 
	rescue
		false
	end
    end  
 
end
