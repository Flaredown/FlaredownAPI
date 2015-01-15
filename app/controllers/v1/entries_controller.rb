class V1::EntriesController < V1::BaseController

  # def index
  #     start_date  = Date.parse(params[:start_date])
  #     end_date    = Date.parse(params[:end_date])
  #     @entries = Entry.by_date(startkey: start_date, endkey: end_date)
  #     render json: @entries, each_serializer: EntrySerializer, status: 200
  # end

  # Create an Entry
  #
  # date  - Date of the entry
  #
  # Examples
  #
  #   curl "<domain>/v1/entries" --data "date=Aug-13-2014&user_email=test@test.com&user_token=abc123"
  #
  #   POST entries
  #   data: {
  #     date: "Aug-13-2014"
  #   }
  #
  #   {
  #     "entry": {
  #       "id": "abc123",
  #       "date": "Aug-13-2014",
  #       "catalogs": ["hbi"],
  #       "catalog_definitions": {
  #         "hbi": [
  #           [
  #             {
  #                 "inputs": [
  #                     {
  #                         "helper": "stools_daily",
  #                         "label": null,
  #                         "meta_label": null,
  #                         "value": 0
  #                     }
  #                 ],
  #                 "kind": "number",
  #                 "name": "stools",
  #             }
  #           ]
  #           # ... catalog_definition snipped! ...
  #         }
  #       ]
  #     }
  #   }
  #
  # Returns 201 if successfully created
  # Returns 200 if Entry exists for that date along with Entry json
  # Returns 422 for errors along with errors json
	def create
    date = Date.parse(params[:date])

    if (existing = Entry.by_date(key: date).detect{|e| e.user_id == current_user.id.to_s})
      render json: EntrySerializer.new(existing, scope: :existing), status: 200
    else
      entry = Entry.new({user_id: current_user.id, date: date }).set_user_audit_version!
      render json: EntrySerializer.new(entry, scope: :new), status: 201
    end
	end

  # Update an Entry
  #
  # date  - Date of the entry
  # entry - json encoded entry payload
  #
  # Examples
  #   PATCH entries/Aug-13-2014
  #   data: {
  #     entry: '{\"responses\":[{\"name\":\"ab_pain\",\"value\":3,\"catalog\":\"hbi\"}'
  #   }
  #
  #   curl "<domain>/v1/entries/Aug-13-2014" -X PATCH --data "entry={\"responses\":[{\"name\":\"ab_pain\",\"value\":3,\"catalog\":\"hbi\"}]}&user_email=test@test.com&user_token=abc123"
  #
  # Returns 200 if successful
  # Returns 422 for errors along with errors json
	def update
    date = Date.parse(params[:id])
    @entry = Entry.by_user_id.key(current_user.id.to_s).detect{|e| e.date == date}

    if @entry.update_attributes(entry_params)
      render json: {success: true}, status: 200
    else
      render json: {errors: @entry.errors}, status: 422
    end
	end

  # Lookup an Entry
  #
  # date - Date of the entry to find
  #
  # Examples
  #
  #   curl "<domain>/v1/entries/Aug-13-2014?user_email=test@test.com&user_token=abc123"
  #
  #   GET entries/Aug-13-2014
  #
  #   {
  #       "entry": {
  #           "id": "abc123",
  #           "date": "Aug-13-2014",
  #           "catalogs": [
  #               "hbi"
  #           ],
  #           "responses": [
  #               {
  #                   "id": "hbi_general_wellbeing_abc123",
  #                   "name": "general_wellbeing",
  #                   "value": 2,
  #                   "catalog": "hbi"
  #               }
  #           ],
  #           "treatments": [
  #               {
  #                   "id": "dihydrogen-monoxide_1_liter_abc123",
  #                   "name": "Dihydrogen monoxide",
  #                   "quantity": "1",
  #                   "unit": "liter"
  #               }
  #           ],
  #           "notes": "Holy frijoles! I ate too many #beans... I'm going to try some #JumpingJacks and see what happens.",
  #           "triggers": [
  #               {
  #                   "id": "beans_abc123",
  #                   "name": "beans"
  #               },
  #               {
  #                   "id": "jumping-jacks_abc123",
  #                   "name": "jumping jacks"
  #               }
  #           ],
  #           "scores": [
  #               {
  #                   "id": "hbi_abc123",
  #                   "name": "hbi",
  #                   "value": 10
  #               }
  #           ]
  #       }
  #   }
  #
  # Returns 200 with an Entry
  # Returns 404 if Entry does not exist for that date and user
	def show
    date = Date.parse(params[:id])
    @entry = Entry.by_date(key: date).detect{|e| e.user_id == current_user.id.to_s}
    @entry ? render(json: EntrySerializer.new(@entry)) : four_oh_four
	end

  # Rescue any entry of invalid dates and render a json error
  #
  # Examples
  #   GET entry/Aug-1337-2014
  #
  #   {error: "Invalid date parameter entered."}
  #
  # Returns 400
  rescue_from ArgumentError, with: :invalid_entry_date
  def invalid_entry_date(e)
    raise e unless e.to_s == "invalid date"
    render json: {error: "Invalid date parameter entered."}, status: 400
  end

  private
  def entry_params
    json_params = ActionController::Parameters.new( JSON.parse(params[:entry]) )
    json_params.permit(
      :date,
      :notes,
      :triggers,
      catalogs: [],
      responses: [:name, :value, :catalog],
      treatments: [:name, :quantity, :unit]

    )
  end
end
