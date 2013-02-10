class FakeEventbriteClient
  attr_reader :eventbrite_event_id

  def initialize(eventbrite_event_id)
    @eventbrite_event_id = eventbrite_event_id
  end

  def event_new(attributes=nil)
    attributes = attributes || {}

    response({"process"=>{"status"=>"OK", "message"=>"event_new : Complete ", "id"=>eventbrite_event_id, "method"=>"(#{attributes[:status]})"}})
  end

  def response(parsed_response, options=nil)
    options = options || {}

    OpenStruct.new({
      parsed_response: parsed_response,
      body: parsed_response.to_json,
      headers: options[:headers] || {},
      code: options[:code] || 200,
    })
  end
end