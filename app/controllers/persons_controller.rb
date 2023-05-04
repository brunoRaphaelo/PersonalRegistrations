class PersonsController < ApplicationController
  before_action :set_person, only: %i[show update destroy]

  # GET /persons
  def index
    @persons = ::Person.all

    @persons = apply_filters(@persons, :by_id)

    render_json_for(@persons, status: :ok)
  end

  # POST /persons/
  def create
    @person = ::Person.new(person_params)

    if @person.save
      render_json_for(@person, status: :created)
    else
      render_json_errors_for(@person.errors, status: :unprocessable_entity)
    end
  end

  # GET /persons/:id
  def show
    render_json_for(@person, status: :ok)
  end

  # PATCH/PUT /persons/:id
  def update
    if @person.update(person_params)
      render_json_for(@person, status: :ok)
    else
      render_json_errors_for(@person.errors, status: :unprocessable_entity)
    end
  end

  # DELETE /persons/:id
  def destroy
    if @person.destroy
      render json: {}, status: :ok
    else
      render_json_errors_for(@person.errors, status: :unprocessable_entity)
    end
  end

  private

  def set_person
    @person = ::Person.find(params[:id])
  end

  def person_params
    params
      .require(:person)
      .permit(:name,
              :email,
              :phone,
              :birth_date)
  end
end
