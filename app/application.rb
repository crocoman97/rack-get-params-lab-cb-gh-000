class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []
  
  def call(env)
    
    resp = Rack::Response.new 
    req = Rack::Request.new(env)
    
    if req.path.match("/items/")
      @@items.each { |i|
        resp.write "#{i}\n"
      }
    elsif req.path.match(/cart/)
      if @@cart.empty?
        resp.write "Your cart is empty"
      else
        @@cart.each do |item|
          resp.write "#{item}\n"
        end
      end
    elsif req.path.match(/add/)
      item_to_add = req.params["item"]
      if @@items.include? item_to_add 
        @@cart << item_to_add
        resp.write "added #{item_to_add}"
      else
        resp.write "We don't have that item!"
      end
    elsif req.path.match("/add/")
      add_item = req.params["item"]
      if @@items.include?(add_item)
        @@cart << add_item
        resp.write "added #{add_item}"
      else 
        resp.write "We don't have that item!"
      end
      
    elsif req.path.match("/search/")
      search_term = req.params["q"]
      if @@items.include?(search_term)
        resp.write "#{search_term} is one of our items"
      else 
        resp.write "Couldn't find #{search_term}"
      end
    else
      resp.write "Path Not Found"
    end
    resp.finish
  end
    
end




