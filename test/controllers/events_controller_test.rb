require "minitest_helper"

describe EventsController do

  before do
    @event = create_event
  end

  it "must get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:events)
  end

  it "must get new" do
    get :new
    assert_response :success
  end

  it "must create event" do
    assert_difference('Event.count') do
      post :create, event: { title: "Party!", start_time: 3.days.from_now }
    end

    assert_redirected_to event_path(assigns(:event))
  end

  it "must show event" do
    get :show, id: @event
    assert_response :success
  end

  it "must get edit" do
    get :edit, id: @event
    assert_response :success
  end

  it "must update event" do
    put :update, id: @event, event: { title: "New Party!" }
    event = assigns(:event)
    assert_redirected_to event_path(event)
    event.title.must_equal "New Party!"
  end

  it "must destroy event" do
    assert_difference('Event.count', -1) do
      delete :destroy, id: @event
    end

    assert_redirected_to events_path
  end

end
