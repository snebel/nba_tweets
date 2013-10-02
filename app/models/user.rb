class User
  attr_reader :client, :id

  def initialize(client)
    @client = client
    user = client.user
    @id = user.id
  end
end