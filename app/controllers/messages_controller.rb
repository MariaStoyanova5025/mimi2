class MessagesController < ApplicationController
protect_from_forgery with: :null_session
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  # GET /messages
  # GET /messages.json
  def index
    @messages = Message.all
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end
  def encrypt message a
	rsa = Rsa.find_by id:a
	
	i = 0
	c = []
	loop do
		break if i == message.length
		c[i] = (message[i].ord ** rsa.e) % rsa.n 
		i = i+1
	end
	c = c.join(",")
	c
   end

	def encryptMessages
		ogmsg = encrypt(params[:message], :params[:id])
		@msg = Message.new({message:ogmsg,ind:params[:id]})
		@msg.save 
		respond_to do |format| 
        		format.json {render json: {'id' => @msg.id}}
      		end
	end
	def printEncryptMessages
		@msg = Message.find_by id:params[:id]
		respond_to do |format| 
        		format.json {render json: {'message' => @msg.message}}
      		end
	end
	def decrypt message a
	rsa = Rsa.find_by id:a
    i = 0
	c = message.split(",")
	mg = []
	loop do
		break if i == c.length
		mg[i] = ((c[i].to_i**rsa.d) % rsa.n).chr
		i = i+1
	end
	mg = mg.join("")
	mg
   end 
	def decryptMessages
		enmsg = decrypt(params[:message], :params[:id])
		respond_to do |format| 
        		format.json {render json: {'message' => enmsg}}
      		end

	end
  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(message_params)

    respond_to do |format|
      if @message.save
        format.html { redirect_to @message, notice: 'Message was successfully created.' }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:ind, :message)
    end
end
