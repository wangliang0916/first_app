class Api::V1::WeixinController < Api::V1::BaseController
	def index
		render text: "index"
	end
		
	def show
		render text: "show"
	end
	
	def update
		@ems_datum = EmsDatum.find(params[:id])
		if @ems_datum.update_attributes(:value=>params[:value])
			#~ render text: @ems_datum.value
			render text: params
		else
			render text: "fault"
		end
	end
	
	def batch_update
		json_params = ActionController::Parameters.new( JSON.parse(request.body.read) )
		items = json_params[:data]
		begin
			items.each do |item|
				ems_data = EmsDatum.find(item[:id])
				ems_data.update_attributes(:value=>item[:value])
			end
			render text: "success update"
		rescue
			render text: "something wrong"
		end
	end
	
  private
    # Only allow a trusted parameter "white list" through.
    def ems_datum_params
      params.permit(:tagname, :value)
    end
end
