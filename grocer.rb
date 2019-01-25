require "pry"

def consolidate_cart(cart)
  # code here

  cart_hash = {}
  cart.each do |groceri|
    groceri.each do |name, info|

      cart_hash[name] ||= info
      cart_hash[name][:count] ||= 0
      cart_hash[name][:count] += 1

    end
  end
  cart_hash
end

def apply_coupons(cart, coupons = [])
  # code here
  new_cart = {}

    coupons.each do |coupon|
       cart.each do |name, info|
        if coupon[:item] == name
          if info[:count] >= coupon[:num]

            first_count, secound_count = info[:count].divmod(coupon[:num])

            coupon_name = "#{name} W/COUPON"

            new_cart[name] = info.clone
            new_cart[name][:count] = secound_count

            new_cart[coupon_name] = info.clone
            new_cart[coupon_name][:price] = coupon[:cost]
            new_cart[coupon_name][:count] = first_count

          else

            new_cart[name] ||= info.clone

          end


        else
          new_cart[name] ||= info.clone
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
  cart.each do |name, info|
    if info[:clearance] == true
      info[:price] = (info[:price] * 0.8).round(2)
    end
  end
end

def checkout(cart, coupons)
  # code here
  total_price = 0
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)

  cart.each do |name, info|
    total_price += (info[:price] * info[:count])

  end

  if total_price >= 100
    total_price = (total_price * 0.9).round(2)
  end

  total_price

end












#
