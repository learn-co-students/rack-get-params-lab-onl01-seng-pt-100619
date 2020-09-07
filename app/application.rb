class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(environment)
    response = Rack::Response.new
    request = Rack::Request.new(environment)

    if request.path.match(/items/)
      @@items.each do |item|
        response.write "#{item}\n"
      end
    elsif request.path.match(/search/)
      search_term = request.params["q"]
      response.write handle_search(search_term)
    elsif request.path.match(/cart/)
      if @@cart.empty?
        response.write "Your cart is empty"
      else
        @@cart.each do |item|
          response.write "#{item}\n"
        end
      end
    elsif request.path.match(/add/)
      new_item = request.params["item"]
      if @@items.include? new_item
        @@cart << new_item
        response.write "added #{new_item}"
      else
        response.write "We don't have that item"
      end
    else
      response.write "Path Not Found"
    end

    response.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
end
