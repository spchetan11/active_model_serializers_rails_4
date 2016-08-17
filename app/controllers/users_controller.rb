class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token  

  # GET /users
  # GET /users.json
  def index
    @users = User.all
    render json: @users
  end

  # GET /users/1
  # GET /users/1.json
  def show
    #below line is default with selected attributes
    #render json: @user, :only => [:id, :name, :email, :age, :company]

    render json: @user
  end

  # GET /users/new
  def new
    @user = User.new
    render json: @user
  end

  # GET /users/1/edit
  def edit
    render json: @user
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        #format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
       # format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  # def update
  #   respond_to do |format|
  #     if @user.update(user_params)
  #       #format.html { redirect_to @user, notice: 'User was successfully updated.' }
  #      format.json { render json: @user, status: :ok, location: @user }
  #     else
  #       #format.html { render :edit }
  #      format.json { render json: @user.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  def update
    respond_to do |format|
      if @user.update(custom_parameters)
        #format.html { redirect_to @user, notice: 'User was successfully updated.' }
       format.json { render json: @user, status: :ok, location: @user }
      else
        #format.html { render :edit }
       format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :company, :email, :age)
    end

    def custom_parameters
      params.require(:user).permit(:name, :company, :email, :age ,:orders_attributes => [:user_id, :order_number, :quantity, :id, :_destroy])
    end
end


#pass this json for patch request in postman

#id should be present other wise it will create a new record.

# {
#     "user": {
#         "name": "chetan.s.p",
#         "email": "s.p.chetan11@gmail.com",
#         "age": 26,
#         "company": "self employeed for now",
#         "orders_attributes": [
#             {
#                 "id": 1,
#                 "order_number": 999,
#                 "quantity": 99
#             }
         
#         ]
#     }
# }