



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
    elsif req.path.match("/cart/")
      if @@cart.empty?
        resp.write "Your cart is empty"
      else
        @@cart.each { |i|
          resp.write "#{i}\n"
        }
      end
      
    elsif req.path.match("/add/")
      add_item = req.params["item"]
      if @@items.include?(add_item)
        @@cart << add_item
        resp.write "#{add_item} is one of our cart"
      else 
        resp.write "Couldn't find #{add_item}"
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
