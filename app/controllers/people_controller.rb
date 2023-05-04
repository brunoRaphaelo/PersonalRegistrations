class PeopleController < ApplicationController
  before_action :set_person, only: %i[show update destroy]

  # GET /people
  def index
    @people = ::Person.all

    @people = apply_filters(@people, :by_id,
                            :by_name,
                            :by_email,
                            :by_phone,
                            :by_birth_date)

    render_json_for(@people, status: :ok)
  end

  # POST /people/
  def create
    @person = ::Person.new(person_params)

    if @person.save
      render_json_for(@person, status: :created)
    else
      render_json_errors_for(@person.errors, status: :unprocessable_entity)
    end
  end

  # GET /people/:id
  def show
    render_json_for(@person, status: :ok)
  end

  # PATCH/PUT /people/:id
  def update
    if @person.update(person_params)
      render_json_for(@person, status: :ok)
    else
      render_json_errors_for(@person.errors, status: :unprocessable_entity)
    end
  end

  # DELETE /people/:id
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
