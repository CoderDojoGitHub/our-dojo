class FakeEventbriteClient
  attr_reader :options, :attributes

  def initialize(options=nil)
    @options = options || {}
  end

  def event_copy(attrs=nil)
    @attributes = attrs || {}

    build_response_object(processed_response)
  end

  def event_update(attrs=nil)
    @attributes = attrs || {}

    build_response_object(processed_response)
  end

  def event_get(attrs=nil)
    @attributes = attrs || {}

    build_response_object(event_response(attributes))
  end

  def ticket_update(attrs=nil)
    @attributes = attrs || {}

    build_response_object(processed_response)
  end

  def eventbrite_event_id
    attributes[:id] || options[:id]
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

  def processed_response
    {
      "process" => {
        "status" => "OK",
        "message" => "event_new : Complete ",
        "id" => eventbrite_event_id,
        "method" => "(live)"
      }
    }

  end

  def event_response
    {
      "event" => {
        "box_header_text_color" => "005580",
        "link_color" => "EE6600",
        "box_background_color" => "FFFFFF",
        "box_border_color" => "D5D5D3",
        "timezone" => "America/Los_Angeles",
        "organizer" => {
          "url" => "http://www.eventbrite.com/org/3257945086",
          "description" => "",
          "long_description" => "",
          "id" => 3257945086,
          "name" => ""
        },
        "background_color" => "FFFFFF",
        "id" => eventbrite_event_id,
        "category" => "",
        "box_header_background_color" => "EFEFEF",
        "capacity" => 0,
        "num_attendee_rows" => 0,
        "title" => "New Party",
        "start_date" => "2013-03-28 13:00:00",
        "status" => "Draft",
        "description" => "",
        "end_date" => "2013-03-28 16:00:00",
        "tags" => "",
        "timezone_offset" => "GMT-0700",
        "text_color" => "005580",
        "title_text_color" => "",
        "password" => "",
        "tickets" => [{
          "ticket" => {
            "description" => "",
            "end_date" => "2013-02-13 22:00:00",
            "min" => 0,
            "max" => 0,
            "price" => "0.00",
            "quantity_sold" => 0,
            "visible" => "true",
            "start_date" => "2013-02-10 16:00:00",
            "currency" => "USD",
            "quantity_available" => 20,
            "type" => 0,
            "id" => 17227630,
            "name" => "party ticket"
          }
        }],
        "created" => "2013-02-16 12:40:13",
        "url" => "http://www.eventbrite.com/event/5553199770",
        "box_text_color" => "000000",
        "privacy" => "Private",
        "modified" => "2013-02-16 12:40:14",
        "repeats" => "no"
      }
    }
  end
end