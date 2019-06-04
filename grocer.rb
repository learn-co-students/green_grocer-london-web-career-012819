def consolidate_cart(cart)
  new_hash = {}
  cart.each do |hash|
    hash.each do |key, value_hash|
      if new_hash[key] 
       value_hash[:count] += 1
     else
        value_hash[:count] = 1
        new_hash[key] = value_hash
     end
    end 
  end 
  new_hash
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    product = coupon[:item]
    if cart[product] && cart[product][:count] >= coupon[:num]
      if cart["#{product} W/COUPON"]
        cart["#{product} W/COUPON"][:count] += 1
      else 
        cart["#{product} W/COUPON"] = {count: 1, price: coupon[:cost], clearance: cart[product][:clearance]}
      end
      cart[product][:count] -= coupon[:num]
    end
  end 
  cart
end

def apply_clearance(cart)
  cart.each do |key, value_hash| 
    if value_hash[:clearance]
      value_hash[:price] = (value_hash[:price] * 0.8).round(2)
    end 
  end 
  cart
end

def checkout(cart, coupons)
  base_case = consolidate_cart(cart)
  coupons_applied = apply_coupons(base_case, coupons)
  clearance = apply_clearance(coupons_applied)

  total = 0

  clearance.each do |key, value|
    total += value[:price] * value[:count]
  end 

  if total > 100 
    total = total * (1-0.1)
  end 
  total
end
