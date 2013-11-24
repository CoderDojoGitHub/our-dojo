class EmailList

  # Public: The announcements email list.
  #
  # Returns an EmailList.
  def self.announcements
    @announcements ||= new(ENV["ANNOUNCEMENTS_LIST_ID"])
  end

  # Public: Called by new with list_id.
  #
  # list_id - Integer
  def initialize(list_id)
    @list_id = list_id
  end

  # Public: The id of the email list on Mailchimp.
  #
  # Returns an Integer.
  attr_reader :list_id

  # Public: Subscribe user to list by their email.
  #
  # email - String email address
  #
  # Returns NilClass or String.
  def subscribe(email)
    self.class.mailchimp.lists.subscribe(list_id, {'email' => email})
    nil
  rescue Mailchimp::ListAlreadySubscribedError
    "Looks like #{email} is already subscribed to the list!"
  rescue Mailchimp::ListDoesNotExistError
    "We're having an issue adding your email. Try it again."
  rescue Mailchimp::Error => ex
    "We're having an issue adding your email. Try it again."
  end

  private

  # Internal: Mailchimp::API instance for subscribing to email lists.
  #
  # Returns a Mailchimp::API.
  def self.mailchimp
    @mailchimp ||= Mailchimp::API.new(mailchimp_api_key)
  end

  # Internal: Mailchimp api key needed for authenticating against their API.
  #
  # Returns a String.
  def self.mailchimp_api_key
    ENV["MAILCHIMP_API_KEY"]
  end
end
