require 'pry'

def consolidate_cart(cart)
  # code here
  new_cart = {}
  cart.each do |x|
    x.each do |item, data|
      new_cart[item] ||= data
      new_cart[item][:count] ||= 0
      new_cart[item][:count] += 1
    end
  end
  new_cart
end

def apply_coupons(cart, coupons = [])
  # code herex
  new_cart = {}
  coupons.each do |coupon|
    cart.each do |name, data|
      if name == coupon[:item]
        if data[:count] >= coupon[:num]
          a,b = data[:count].divmod(coupon[:num])
          s = "#{name} W/COUPON"
          new_cart[name] = data.clone
          new_cart[name][:count] = b
          new_cart[s] = data.clone
          new_cart[s][:price] = coupon[:cost]
          new_cart[s][:count] = a
        else
          new_cart[name] ||= data.clone
        end
      else
        new_cart[name] ||= data.clone
      end
    end
  end
  if new_cart.length > 0
    new_cart
  else
    cart
  end
end

def apply_clearance(cart)
  # code here
  cart.each do |item, hash|
    if hash[:clearance] == true
      hash[:price] = (hash[:price] * 0.8).round(2)
    end
  end
end

def checkout(cart, coupons)
  # code here
  price = 0
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  cart.each do |item, hash|
    price += hash[:price] * hash[:count]
  end
  if price > 100
    price = (price*0.9).round(2)
  end
  price
end

# cart =
# {
#   "AVOCADO" => {:price => 3.0, :clearance => true, :count => 3},
#   "KALE"    => {:price => 3.0, :clearance => false, :count => 3}
# }
#
# coupons = [
#     {:item => "AVOCADO", :num => 2, :cost => 5.00},
#     {:item => "KALE", :num => 2, :cost => 2.00},
#     {:item => "CHEESE", :num => 3, :cost => 15.00}
#   ]
# binding.pry
