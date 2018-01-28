class RsasController < ApplicationController
protect_from_forgery with: :null_session
  before_action :set_rsa, only: [:show, :edit, :update, :destroy]

  # GET /rsas
  # GET /rsas.json
  def index
    @rsas = Rsa.all
  end

  # GET /rsas/1
  # GET /rsas/1.json
  def show
  end

  # GET /rsas/new
  def new
    @rsa = Rsa.new
  end

  # GET /rsas/1/edit
  def edit
  end

  # POST /rsas
  # POST /rsas.json
	def is_prime number
	i = 1
	not_prime = 0
	loop do
		break if i == number / 2
		if number % i == 0
			not_prime = 1
		end
		break if not_prime == 1
		i = i + 1
	end
	not_prime
end 
	def coprime number
	i = 2;
	
	loop do 
		break if i.gcd(number) == 1	 
		i = i+1
	end
	return i;
	
end

def mmi e, b
	d = 0
	loop do
		break if (d * e)%b == 1 
		d = d + 1	
	end
	d
end

	def new_key
		#za n
		q = rand(5025)
		if is_prime(q) == 1
			loop do
				break if is_prime(q) != 1
				q = rand(5025)
			end	
		end	
		p = rand(5025)
		if is_prime(p) == 1
			loop do
				break if is_prime(p) != 1
				p = rand(5025)
			end	
		end	
		loop do
			break if p != q 
			p = rand(5025)
			if is_prime(p) == 1
				loop do
					break if is_prime(p) != 1
					p = rand(5025)
				end	
			end	
		end
		n = p*q
		b = (p - 1).lcm(q - 1)
		#za e
		e = coprime(b)
		#za d
		d = mmi(e,b);
		arr = [n, e, d]
		arr
   end
  def newKey
		if params.has_key?(:d) && params.has_key?(:e) && params.has_key?(:n)
			@rsa = Rsa.new({d:params[:d], e:params[:e], n:params[:n]})
		else 
			arr = new_key()
			@rsa = Rsa.new({n:arr[0], e:arr[1], d:arr[2]})
		end
		
		@rsa.save
		respond_to do |format| 
        		format.json {render json: {'id' => @rsa.id}}
      		end
		
	end
	def printKey
		@rsa = Rsa.find_by id:params[:id]
		
		respond_to do |format| 
        		format.json {render json: {'n' => @rsa.n, 'd' => @rsa.d, 'e' => @rsa.e}}
      		end
	end
  def create
    @rsa = Rsa.new(rsa_params)

    respond_to do |format|
      if @rsa.save
        format.html { redirect_to @rsa, notice: 'Rsa was successfully created.' }
        format.json { render :show, status: :created, location: @rsa }
      else
        format.html { render :new }
        format.json { render json: @rsa.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rsas/1
  # PATCH/PUT /rsas/1.json
  def update
    respond_to do |format|
      if @rsa.update(rsa_params)
        format.html { redirect_to @rsa, notice: 'Rsa was successfully updated.' }
        format.json { render :show, status: :ok, location: @rsa }
      else
        format.html { render :edit }
        format.json { render json: @rsa.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rsas/1
  # DELETE /rsas/1.json
  def destroy
    @rsa.destroy
    respond_to do |format|
      format.html { redirect_to rsas_url, notice: 'Rsa was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rsa
      @rsa = Rsa.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rsa_params
      params.permit(:n, :e, :d)
    end
end
