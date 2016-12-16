class MessagesController < ApplicationController
	before_action :authenticate_user!
	before_action :set_message,only:[:show,:destroy]
  def show
  end
	def new
		@message=Message.new
	end
	def create
  	@message = Message.new(message_params)

  	respond_to do |format|
  		if @message.save
  			format.html { redirect_to :back, notice: "Message sent."}
  		else 
  			format.html {redirect_to :back,alert: "There was an error."}
  			end
  		end
  	end
  	def destroy

  		@message.destroy

  		respond_to do |format|
  			format.html { redirect_to user_path(id: current_user.id), notice: "Message Deleted."}
  		end
  	end
	private
	def set_message
  		@message = Message.find(params[:id])
  	end
	def message_params
  		params.require(:message).permit(:subject, :body, :user_id,:recipient_id,:status)
  	end
end