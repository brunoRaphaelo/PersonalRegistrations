class AddressesController < ApplicationController
  before_action :set_address, only: %i[show update destroy]

  # GET /addresses
  def index
    @addresses = ::Address.all

    @addresses = apply_filters(@addresses, :by_id)

    render_json_for(@addresses, status: :ok)
  end

  # POST /addresses/
  def create
    @address = ::Address.new(address_params)

    if @address.save
      render_json_for(@address, status: :created)
    else
      render_json_errors_for(@address.errors, status: :unprocessable_entity)
    end
  end

  # GET /addresses/:id
  def show
    render_json_for(@address, status: :ok)
  end

  # PATCH/PUT /addresses/:id
  def update
    if @address.update(address_params)
      render_json_for(@address, status: :ok)
    else
      render_json_errors_for(@address.errors, status: :unprocessable_entity)
    end
  end

  # DELETE /addresses/:id
  def destroy
    if @address.destroy
      render json: {}, status: :ok
    else
      render_json_errors_for(@address.errors, status: :unprocessable_entity)
    end
  end

  private

  def set_address
    @address = ::Address.find(params[:id])
  end

  def address_params
    params
      .require(:address)
      .permit(:person_id,
              :street,
              :city,
              :state,
              :country,
              :postal_code)
  end
end
