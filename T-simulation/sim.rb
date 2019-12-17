require 'active_support/core_ext/enumerable'

class Transit
  def initialize(lines)
    
    # initialize lines
    @lines = lines

    # get all stationss
    @stationsArrayRepeat=[]
    @lines.each_value { |value| 
          value.each do |i|
          @stationsArrayRepeat.push(i)
          end 
    }

    #Remove the duplicate stations
    @stationsArray = @stationsArrayRepeat & @stationsArrayRepeat
    
    # initialize stations object
    @stations = []
    @stationsArray.each do |i| 
      @stations.push(Station.new(i))
    end 
    
    # initialize trains object
    @trains=[]
    @lines.each_key do |k|
      @trains.push(Train.new(k))
    end

    # initialize start station
    @stations.each do |s|
      @trains.each do |t|
        if s.to_s == "Davis" and t.to_s == "red"
          s.settrain(t.to_s)
        elsif s.to_s == "Tufts" and t.to_s == "green"
          s.settrain(t.to_s)
        elsif s.to_s == "Bowdoin" and t.to_s == "blue"
          s.settrain(t.to_s)
        elsif s.to_s == "Ruggles" and t.to_s == "orange"
          s.settrain(t.to_s)
        end
      end
    end
  
  end






  def config_sim(paths)
    
    # initialize paths
    @paths = paths

    # initialize passengers object
    @passengers=[]
    @paths.each_key do |k|
      @passengers.push(Passenger.new(k))
    end

    # initialize passengers start station
    @stations.each do |s|
      @passengers.each do |p|
        @paths. each_value do |pt|
          if @paths.key(pt) == p.to_s and s.to_s == pt[0]
            s.addpassengers(p.to_s)
          end
        end
      end
    end

    #initialize the passengers real plan (with transfer)
    @pathtransplan = Hash.new 
      @paths.each_key do |key|
          pathplan = @paths[key]
          @pathtransplans = []   
          i = 0
          while pathplan[i+1] != nil
            @pathtransplans = @pathtransplans|(plan(pathplan[i],pathplan[i+1]))
            i += 1     
          end
          @pathtransplan.store(key,@pathtransplans)     
      end
  end






  def step(kind, name)
    #train step
    if kind == :train    
      currentstationname = ""
      nextstationname = ""
      @stations.each do |s| 
        #get train's currentstation and nextstation
        if s.train.to_s == name
          currentstationname = s.to_s
          @lines[name].each do |ls|
            if  s.to_s == ls
              @trains.each do |t|
                if t.to_s == name
                  if @lines[name].index(ls) == 0 
                    nextstationname = @lines[name][@lines[name].index(ls)+1]
                    t.setdirection(true)
                  elsif @lines[name].index(ls) == @lines[name].length-1
                    nextstationname = @lines[name][@lines[name].index(ls)-1]
                    t.setdirection(false)
                  elsif t.direction == true
                    nextstationname = @lines[name][@lines[name].index(ls)+1]
                    t.setdirection(true)
                  else  
                    nextstationname = @lines[name][@lines[name].index(ls)-1]
                    t.setdirection(false)
                  end 
                end  
              end             
            end
          end
        end
      end
      #determine if the train can move, if can, move the train
      @stations.each  do |s| 
        if s.to_s == nextstationname
          if s.train == nil
            s.settrain(name)
            Log.train_moves(s.train, currentstationname, nextstationname)
            @stations.each do |cs|
              if cs.to_s == currentstationname 
                cs.settrain(nil)
              end
            end
            true
          else
            false
          end
        end
      end
    #passenger step
    elsif kind == :passenger
          #determine if passenger get on the train
          if @pathtransplan[name] != nil
              @stations.each do |s|
                #determine if it is the correct station and passenger must at that station
                if s.passengers.include? name and s.to_s == @pathtransplan[name][0] and @pathtransplan[name].length > 1
                  #determine if it is the right train at the station
                  @trains.each do |t|
                      @lines.each_value do |value|
                        value.each do |s|
                          if s == @pathtransplan[name][1]
                            @righttrain = @lines.key(value)
                          end
                        end
                      end
                      #right train, get on!
                      if @righttrain == t.to_s and s.train == t.to_s 
                        #remove the first station at plan, because passenger already leave this station.
                        @pathtransplan[name].delete_at(0)
                        #make progress
                        s.removepassengers(name)
                        t.addpassengers(name)
                        Log.passenger_boards(name, t.to_s, s.to_s)
                        true
                      else 
                        false
                      end
                  end
                else
                    false
                end
              end
          end 

           #determine if passenger get off the train
            if @pathtransplan[name] != nil
              @stations.each do |s|
                #right get off station? train at roght station? passenger at this train?        
                if !s.passengers.include? name and s.to_s == @pathtransplan[name][0]
                  @trains.each do |t|
                    if t.to_s == s.train and t.passengers.include? name
                      #make progress
                      t.removepassengers(name)
                      s.addpassengers(name)
                      Log.passenger_exits(name, t.to_s, s.to_s)
                      #remove the last station at plan, we are done!
                      if @pathtransplan[name].length == 1
                        @pathtransplan[name].delete_at(0)
                      end
                      true
                    else 
                      false
                    end
                  end
                end
              end
            end             
    end   
  end
  





  def finished?
    #if all the passengers' plan is nil, we finished
    keys = @paths.keys
    @ret = true
      for i in 0..keys.length-1
          if @pathtransplan[keys[i]].length != 0
            @ret = false
          end
      end
      @ret

  end

  




  def stations
    @stations
  end

  




  def plan(s1, s2)


                    #use BFS can get the shortest path
                    @stationsArrayRepeat1=[]
                    @lines.each_value do |value| 
                          value.each do |i|
                          @stationsArrayRepeat1.push(i)
                          end 
                    end

                    @stationsArray1 = @stationsArrayRepeat1 & @stationsArrayRepeat1

            
                  

                    # get all stations' neighbor
                    @stationneighbor = Hash.new 
                    for i in 0.. @stationsArray1.length-1
                      @neibor = []
                      @lines.each_value do |value| 
                            value.each_with_index do |s, index|
                              if s == @stationsArray1[i]
                                if index == 0
                                  @neibor.push(value[index+1]) 
                                elsif index == s.length-1
                                  @neibor.push(value[index-1]) 
                                else
                                  @neibor.push(value[index+1])
                                  @neibor.push(value[index-1])
                                end
                              end 
                            end
                      end
                      @stationneighbor.store(@stationsArray1[i], @neibor)
                    end


                    # do BFS to get the shortest realpath
                    # 1.get @stationmarked and map of each station and their parent station
                    @stationlaststation = Hash.new 
                    @stationmarked = []
                    @queue = []
                    @queue.push(s1)
                    @stationmarked.push(s1)  
                    begin 
                      @stationneighbor.each_key do |k|      
                        if k == @queue[0]
                          @stationneighbor[k].each do |n|
                            if @stationmarked.exclude? n     #require 'active_support/core_ext/enumerable' to run
                              @queue.push(n)
                              @stationmarked.push(n)
                              @stationlaststation.store(n,k)
                            end
                          end        
                            @queue.delete_at(0)         
                        end 
                      end
                    end while @queue[@queue.length-1] == s2

                    #  2. get real visited stations(reversed)
                    @realreversepath = []
                    @realreversepath.push(s2)
                    begin 
                      @stationlaststation.each_key do |k|
                        if k == @realreversepath[@realreversepath.length-1]
                          @realreversepath.push(@stationlaststation[k])
                        end
                      end
                    end while @realreversepath[@realreversepath.length-1] == s1

                    #  3. get real visited stations
                    @realpath = @realreversepath.reverse







    #get all stations
    li = [] 
    @lines.each_value do |i| 
    li.push(i)
    end
    
    #get all transfer stations
    transtation = []
    for i in 0..li.length-1
      for j in i+1..li.length-1
           transtation.push(li[i]&li[j])
      end
    end

    #get all transfer stations and their line
    trans = Hash.new
    for i in 0..transtation.length-1
      for j in 0..transtation[i].length-1
      p=[]
      @lines.each_value do |k|
            k.each do |m|
              if m == transtation[i][j]
                p.push(@lines.key(k))
              end
            end
          end
      trans.store(transtation[i][j],p)
      end
    end

    #get the train of s1 s2
    s1key = ""
    s2key = ""
    @lines.each_value do |i| 
        i.each do |value|
         if value == s1 
            s1key =  @lines.key(i)
           end
        end
    end
    @lines.each_value do |i| 
        i.each do |value|
         if value == s2
            s2key =  @lines.key(i)
           end
        end
    end

    #get the plan
    @realplan = []
    # if station s1, s2 is at same line
    if  s1key == s2key
      @realplan.push(s1)
      @realplan.push(s2)
    # if station s1, s2 is "not" at same line
    else
      trans.each_value do |i|
        #transfer station need belong to both s1 line and s2 line
        i.each do |a|
          if a == s1key 
                i.each do |b|
                  if b == s2key 
                    # one of s1, s2 is transfer station, they still at same line
                    if trans.key(i) == s1 or trans.key(i) == s2
                      @realplan.push(s1)
                      @realplan.push(s2)
                    # add transfer station into plan
                    else                     
                      @realplan.push(s1)
                      @realplan.push(trans.key(i))
                      @realplan.push(s2)
                    end 
                  end
                end    
          end
        end
      end
      #need transfer twice
      if @realplan == []
        trans.each_value do |j|
          j.each do |c|
            if c == s1key and @realplan == []
              @realplan.push(s1)
              @realplan.push(trans.key(j))
            end   
          end
        end
        trans.each_value do |j|
          j.each do |c|        
            if c == s2key and @realplan[@realplan.length-1] != s2
              @realplan.push(trans.key(j))
              @realplan.push(s2)
            end
          end
        end
      end
    end

    #return the plan
    @realplan

  end


end












class Station
  
  def initialize(name)
    @name = name
    @passengers = []
    @train = nil
  end

  def addpassengers(p)
    @passengers.push(p)
  end

  def removepassengers(p)
    @passengers.delete(p) 
  end

  def settrain(t)
    @train = t
  end

  def train
    @train
  end
  
  def passengers
    @passengers
  end

  def to_s
    @name
  end
  
end














class Train 

  def initialize(name)
    @name = name
    @passengers = []
    @direction = true
  end

  def addpassengers(p)
    @passengers.push(p)
  end

  def removepassengers(p)
    @passengers.delete(p) 
  end

  def passengers
    @passengers
  end

  def to_s
    @name    
  end

  def direction
    @direction   
  end

  def setdirection(bool)
    @direction = bool   
  end

end











class Passenger

  def initialize(name)
    @name = name
  end

  def to_s
    @name
  end 
  
end












class Log
  def self.train_moves(t, s1, s2)
    puts "Train #{t} moves from #{s1} to #{s2}"
  end

  def self.passenger_boards(p, t, s)
    puts "Passenger #{p} boarding train #{t} at #{s}"
  end

  def self.passenger_exits(p, t, s)
    puts "Passenger #{p} exiting train #{t} at #{s}"
  end
end
