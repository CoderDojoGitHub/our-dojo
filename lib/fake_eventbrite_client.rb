class FakeEventbriteClient
  attr_reader :options

  def initialize(options=nil)
    @options = options || {}
  end

  def event_new(attributes=nil)
    attributes = attributes || {}

    parsed_response = {"process"=>{"status"=>"OK", "message"=>"event_new : Complete ", "id"=>eventbrite_event_id, "method"=>"(#{attributes[:status]})"}}

    build_response_object(parsed_response)
  end

  def event_get(attributes)
    parsed_response = {
      "event" => {
        "box_header_text_color"=>"005580",
        "link_color" => "EE6600",
        "box_background_color" => "FFFFFF",
        "box_border_color" => "D5D5D3",
        "timezone" => "America/Los_Angeles",
        "background_color" => "FFFFFF",
        "id" => attributes[:id],
        "category" => "",
        "box_header_background_color" => "EFEFEF",
        "capacity" => 0,
        "num_attendee_rows" => 0,
        "title" => eventbrite_event_title,
        "start_date" => "2013-02-14 17:00:00",
        "status" => "Draft",
        "description" => "",
        "end_date" => "2013-02-14 19:00:00",
        "tags" => "",
        "timezone_offset" => "GMT-0800",
        "text_color" => "005580",
        "title_text_color" => "",
        "password" => "",
        "created" => "2013-02-10 12:45:59",
        "url" => "http://www.eventbrite.com/event/5489368850",
        "box_text_color" => "000000",
        "privacy" => "Private",
        "modified" => "2013-02-10 12:45:59",
        "repeats" => "no"
      }
    }

    build_response_object(parsed_response)
  end

  def eventbrite_event_id
    options[:id] || 5489368850
  end

  def eventbrite_event_title
    options[:title] || "party time!"
  end

  def build_response_object(parsed_response, options=nil)
    options = options || {}

    OpenStruct.new({
      parsed_response: parsed_response,
      body: parsed_response.to_json,
      headers: options[:headers] || {},
      code: options[:code] || 200,
    })
  end
end