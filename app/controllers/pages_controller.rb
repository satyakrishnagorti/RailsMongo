class PagesController < ApplicationController
  def home
    @cuisines = ['Chinese', 'North Indian', 'South Indian', 'Fast Food', 'Ice Cream', 'Bakery', 'Drinks Only']
  end

  def index

  end

  def top_restaurants

    @cuisines = ['Chinese', 'North Indian', 'South Indian', 'Fast Food', 'Ice Cream', 'Bakery', 'Drinks Only']
    @selected_cuisine = ""
    @cuisines.each do |x|
      if x == params[x]
        @selected_cuisine = x
        break
      end
    end

    @locations = []
    @r_names = []
    Location.all.each do |a|
      if a.loc_name == params[a.loc_name]
        @locations.append a.loc_name

      end
    end
    @res = algorithm(@locations,@selected_cuisine)

  end

  def results
    @cuisines = ['Chinese', 'North Indian', 'South Indian', 'Fast Food', 'Ice Cream', 'Bakery', 'Drinks Only']
    @selected_cuisine = ""
    @cuisines.each do |x|
      if x == params[x]
        @selected_cuisine = x
        break
      end
    end
    @locations = []
    @r_names = []
    Location.all.each do |a|
      if a.loc_name == params[a.loc_name]
        @locations.append a.loc_name
      end
    end
    @res = algorithm(@locations,@selected_cuisine)
    @location_costs = {}
    @location_popularity = {}
    @location_popularity = algo2(@locations,@selected_cuisine)
    @res.each do |key, arr|
      sum = 0
      counter = 0
      arr.each do |a|

        a = a.gsub(/[']/,"''")
        #cost = Restaurant.where("location == '"+key+"' and name == '"+a+"'").first.cost_for_two.to_i
        cx = Restaurant.where(location: key)
        cx.all.each do |incx|
          if incx.name == a
            cost = incx.cost_for_two.to_i
            sum+=cost
            counter+=1
          end
        end
        #sum += cost
      end

      avg = sum/counter
      @location_costs[key] = avg
      #rand(40) + 50




    end
    end   #results ends here

  def algorithm(locations,cuisine)
    # returning a hash with each key as selected location and value as an array of restaurants matching the cuisine in that location
    rests = {}
    locations.each do |each_loc|
      rest_in_loc = []
      #selected_rest = Restaurant.where("location == '"+each_loc+ "' and cuisines like '%"+cuisine+"%'").limit(8).each do |x|
      x=Restaurant.where(location:each_loc)
      x.all.each do |inx|
        if inx.cuisines.include? cuisine
          rest_in_loc.append inx.name
        end
      end
        #rest_in_loc.append x.name
      rests[each_loc] = rest_in_loc
      end



    return rests
  end

  def algo2(locations,cuisine)

    #returns a hash rests whose key is each location selected and value is the rating of each location.

    rests = {}
    max_val = 0.0
    locations.each do |each_loc|
      tot_rating = 0.0
      count = 0
      # selected_rest = Restaurant.where("location == '"+each_loc+ "' and cuisines like '%"+cuisine+"%'").limit(8).each do |x|
      #
      #   tot_rating += x.rating.to_i
      # end
      x=Restaurant.where(location:each_loc)
      x.all.each do |inx|
        if inx.cuisines.include? cuisine
          tot_rating += inx.rating.to_i
        end
      end


      rests[each_loc] = (tot_rating/8)
      if rests[each_loc] > max_val
        max_val = rests[each_loc]
      end

      puts each_loc + " ---> " + rests[each_loc].to_s
    end

    rests.each do |key, val|
      rests[key] = ( rests[key] / max_val ) * 100
    end
    return rests
  end


end

