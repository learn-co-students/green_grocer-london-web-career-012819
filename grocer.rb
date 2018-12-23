require "pry"


def consolidate_cart(cart)
  cons_cart = {}
  cart.each do |product|
    if(cons_cart[product.keys[0]])
      cons_cart[product.keys[0]][:count] += 1
    else
      cons_cart[product.keys[0]] = product.values[0]
      cons_cart[product.keys[0]][:count] = 1
    end
  end
  cons_cart
end

def apply_coupons(cart, coupons)
  couponed = cart
  coupons.each do |coupon|
    prod_name = coupon[:item]
    if cart.key?(prod_name) && couponed[prod_name][:count] >= coupon[:num]
        couponed[prod_name][:count] -=  coupon[:num]
        if couponed["#{prod_name} W/COUPON"]
          couponed["#{prod_name} W/COUPON"][:count] += 1
        else
          couponed["#{prod_name} W/COUPON"] = {:price => coupon[:cost],
                                                   :clearance => cart[prod_name][:clearance],
                                                   :count => 1}
        end
      end
    end
    couponed
  end

  def apply_clearance(cart)
    cart_new = cart
    cart_new.each do |item, values|
      if values[:clearance]
        values[:price] *= 0.8
        values[:price] = values[:price].round(2)
      end
    end
    cart_new
  end

  def total_cart_price cart
    total = 0
    cart.each do |item, values|
      total += values[:price] * values[:count]
    end
    total
  end

  def checkout(cart = [], coupons = [])
    cart_consolidated = consolidate_cart(cart)
    new_cart = apply_coupons(cart_consolidated, coupons)
    new_new_cart = apply_clearance(new_cart)
    cart_total = total_cart_price(new_new_cart)
    if cart_total > 100
      cart_total *= 0.9
    end
    cart_total
  end
