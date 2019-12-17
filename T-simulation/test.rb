require "minitest/autorun"
require "./sim.rb"



class TestSim < MiniTest::Test

  # def test_true
  #   assert_equal 2, 1+1
  # end

  # def test_false
  #   assert false
  # end



# rule3.At the start of the simulation,
# Each train starts at the first station for that line.
# Each passenger starts at the initial station on their path.
	
	#test train
	def test_rule3_1
		the_T = Transit.new({
                      "red" => ["Davis",
                                "Harvard",
                                "Kendall",
                                "Park",
                                "Downtown Crossing",
                                "South Station",
                                "Broadway",
                                "Andrew",
                                "JFK"],
                      "green" => ["Tufts",
                                  "Magoun",
                                  "East Sommerville",
                                  "Lechmere",
                                  "North Station",
                                  "Government Center",
                                  "Park",
                                  "Boylston",
                                  "Arlington",
                                  "Copley"],
                      "blue" => ["Bowdoin",
                                 "Government Center",
                                 "State",
                                 "Aquarium",
                                 "Maverick",
                                 "Airport"],
                      "orange" => ["Ruggles",
                                   "Back Bay",
                                   "Tufts Medical Center",
                                   "Chinatown",
                                   "Downtown Crossing",
                                   "State",
                                   "North Station",
                                   "Community College",
                                   "Sullivan"]
                    })

		the_T.config_sim({"Alice" => ["Davis", "Kendall"],
                  "Bob" => ["Park", "Tufts"],
                  "Carol" => ["Maverick", "Davis"],
                  "Dan" => ["Ruggles", "Aquarium", "East Sommerville"]
                 })

		#test "red" train at first station "Davis"
		expectedtrain = "red"
		starttrain = ""
		startstation = "Davis"
 		the_T.stations.each do |s|
			if s.to_s == startstation
				starttrain = s.train.to_s
			end
		end
		assert_equal starttrain, expectedtrain
	end


    #test passenger
	def test_rule3_2
		the_T = Transit.new({
                      "red" => ["Davis",
                                "Harvard",
                                "Kendall",
                                "Park",
                                "Downtown Crossing",
                                "South Station",
                                "Broadway",
                                "Andrew",
                                "JFK"],
                      "green" => ["Tufts",
                                  "Magoun",
                                  "East Sommerville",
                                  "Lechmere",
                                  "North Station",
                                  "Government Center",
                                  "Park",
                                  "Boylston",
                                  "Arlington",
                                  "Copley"],
                      "blue" => ["Bowdoin",
                                 "Government Center",
                                 "State",
                                 "Aquarium",
                                 "Maverick",
                                 "Airport"],
                      "orange" => ["Ruggles",
                                   "Back Bay",
                                   "Tufts Medical Center",
                                   "Chinatown",
                                   "Downtown Crossing",
                                   "State",
                                   "North Station",
                                   "Community College",
                                   "Sullivan"]
                    })

		the_T.config_sim({"Alice" => ["Davis", "Kendall"],
                  "Bob" => ["Park", "Tufts"],
                  "Carol" => ["Maverick", "Davis"],
                  "Dan" => ["Ruggles", "Aquarium", "East Sommerville"]
                 })

		#test "Bob" at first station "Park"
		expectedpassenger = "Bob"
		passenger = []
		startstation = "Park"
 		the_T.stations.each do |s|
			if s.to_s == startstation
				passenger = s.passengers
			end
		end
		assert passenger.include?expectedpassenger
	end


#rule4
#Trains move along their path until they reach the end of the line, 
#then they change direction and follow the line in reverse until they reach the beginning of the line, etc.

		def test_rule4
			the_T = Transit.new({
                      "orange" => ["Ruggles",
                                   "Back Bay",
                                   "Tufts Medical Center",
                                   "Chinatown",
                                   "Downtown Crossing",
                                   "State",
                                   "North Station",
                                   "Community College",
                                   "Sullivan"]
                    })

			["orange"].each { |t|
	    		the_T.step(:train, t)
	  		}
	  		#test "orange" train move to next station "Back Bay"
			expectedtrain = "orange"
			starttrain = ""
			startstation = "Back Bay"
	 		the_T.stations.each do |s|
				if s.to_s == startstation
					starttrain = s.train.to_s
				end
			end
			assert_equal starttrain, expectedtrain

			["orange"].each { |t|
	    		the_T.step(:train, t)
	  		}
	  		["orange"].each { |t|
	    		the_T.step(:train, t)
	  		}
	  		["orange"].each { |t|
	    		the_T.step(:train, t)
	  		}
	  		["orange"].each { |t|
	    		the_T.step(:train, t)
	  		}
	  		["orange"].each { |t|
	    		the_T.step(:train, t)
	  		}
	  		["orange"].each { |t|
	    		the_T.step(:train, t)
	  		}
	  		["orange"].each { |t|
	    		the_T.step(:train, t)
	  		}
	  		["orange"].each { |t|
	    		the_T.step(:train, t)
	  		}

	  		#test "orange" train reverse move to next station "Community College"
			expectedtrain1 = "orange"
			starttrain1 = ""
			startstation1 = "Community College"
	 		the_T.stations.each do |s|
				if s.to_s == startstation1
					starttrain1 = s.train.to_s
				end
			end
			assert_equal starttrain1, expectedtrain1
	  		
		end



#rule6
#At most one train can be at a station at a time. Trains and stations can hold an unbounded number of passengers. 
#You can assume the initial configuration does not place two trains at the same station.

		def test_rule6
			the_T = Transit.new({
                      "red" => ["Davis",
                                "Harvard",
                                "Kendall",
                                "Park",
                                "Downtown Crossing",
                                "South Station",
                                "Broadway",
                                "Andrew",
                                "JFK"],
                      "green" => ["Tufts",
                                  "Magoun",
                                  "East Sommerville",
                                  "Lechmere",
                                  "North Station",
                                  "Government Center",
                                  "Park",
                                  "Boylston",
                                  "Arlington",
                                  "Copley"],
                      "blue" => ["Bowdoin",
                                 "Government Center",
                                 "State",
                                 "Aquarium",
                                 "Maverick",
                                 "Airport"],
                      "orange" => ["Ruggles",
                                   "Back Bay",
                                   "Tufts Medical Center",
                                   "Chinatown",
                                   "Downtown Crossing",
                                   "State",
                                   "North Station",
                                   "Community College",
                                   "Sullivan"]
                    })

			the_T.config_sim({"Alice" => ["Davis", "Kendall"],
	                  "Bob" => ["Park", "Tufts"],
	                  "Carol" => ["Maverick", "Davis"],
	                  "Dan" => ["Ruggles", "Aquarium", "East Sommerville"]
                 	})
			["orange"].each { |t|
	    		the_T.step(:train, t)
	  		}
	  		["orange"].each { |t|
	    		the_T.step(:train, t)
	  		}
	  		["orange"].each { |t|
	    		the_T.step(:train, t)
	  		}
	  		["orange"].each { |t|
	    		the_T.step(:train, t)
	  		}

	  		["red"].each { |t|
	    		the_T.step(:train, t)
	  		}
	  		["red"].each { |t|
	    		the_T.step(:train, t)
	  		}
	  		["red"].each { |t|
	    		the_T.step(:train, t)
	  		}
	  		["red"].each { |t|
	    		the_T.step(:train, t)
	  		}
	  		# "orange already at "Downtown Crossing", "red" can't move

	  		expectedtrain = "orange"
			starttrain = ""
			startstation = "Downtown Crossing"
	 		the_T.stations.each do |s|
				if s.to_s == startstation
					starttrain = s.train.to_s
				end
			end
			assert_equal starttrain, expectedtrain
		end


#rule7
#A passenger can only board a train that is at the same station as the passenger; 
#they can only exit a train at the station it is currently at.
	
	def test_rule7
			the_T = Transit.new({
                      "red" => ["Davis",
                                "Harvard",
                                "Kendall",
                                "Park",
                                "Downtown Crossing",
                                "South Station",
                                "Broadway",
                                "Andrew",
                                "JFK"],
                      "green" => ["Tufts",
                                  "Magoun",
                                  "East Sommerville",
                                  "Lechmere",
                                  "North Station",
                                  "Government Center",
                                  "Park",
                                  "Boylston",
                                  "Arlington",
                                  "Copley"],
                      "blue" => ["Bowdoin",
                                 "Government Center",
                                 "State",
                                 "Aquarium",
                                 "Maverick",
                                 "Airport"],
                      "orange" => ["Ruggles",
                                   "Back Bay",
                                   "Tufts Medical Center",
                                   "Chinatown",
                                   "Downtown Crossing",
                                   "State",
                                   "North Station",
                                   "Community College",
                                   "Sullivan"]
                    })

			the_T.config_sim({"Alice" => ["Davis", "Kendall"],
	                  "Bob" => ["Park", "Tufts"],
	                  "Carol" => ["Maverick", "Davis"],
	                  "Dan" => ["Ruggles", "Aquarium", "East Sommerville"]
                 	})

			#"Alice" at "Davis", can get on train
			["Alice"
   				].each { |p|
     			the_T.step(:passenger, p)}
     		["red"].each { |t|
	    		the_T.step(:train, t)
	  		}


			#"Alice" at "Harvard", can't get off train

			["Alice"
   				].each { |p|
     			the_T.step(:passenger, p)}
	  		["red"].each { |t|
	    		the_T.step(:train, t)
	  		}


	  		#"Alice" at "Kendall", can get off train
			["Alice"
   				].each { |p|
     			the_T.step(:passenger, p)}
	  		["red"].each { |t|
	    		the_T.step(:train, t)
	  		}

	  		expectedpassenger2 = "Alice"
			passenger2 = []
			startstation2 = "Kendall"
	 		the_T.stations.each do |s|
				if s.to_s == startstation2
					passenger2 = s.passengers
				end
			end
			assert passenger2.include?expectedpassenger2
		end


#rule8
#A passenger boards a train if doing so will make progress on their path. 
#A passenger exits from a train if either they have arrived at the next station 
#on their path or if they need to change trains to continue along their path. 

	def test_rule8
		the_T = Transit.new({
                      "red" => ["Davis",
                                "Harvard",
                                "Kendall",
                                "Park",
                                "Downtown Crossing",
                                "South Station",
                                "Broadway",
                                "Andrew",
                                "JFK"],
                      "green" => ["Tufts",
                                  "Magoun",
                                  "East Sommerville",
                                  "Lechmere",
                                  "North Station",
                                  "Government Center",
                                  "Park",
                                  "Boylston",
                                  "Arlington",
                                  "Copley"],
                      "blue" => ["Bowdoin",
                                 "Government Center",
                                 "State",
                                 "Aquarium",
                                 "Maverick",
                                 "Airport"],
                      "orange" => ["Ruggles",
                                   "Back Bay",
                                   "Tufts Medical Center",
                                   "Chinatown",
                                   "Downtown Crossing",
                                   "State",
                                   "North Station",
                                   "Community College",
                                   "Sullivan"]
                    })

			the_T.config_sim({
	                  "Dan" => ["Ruggles", "Aquarium"]
                 	})
			["Dan"].each { |p|
     			the_T.step(:passenger, p)}
	  		["orange"].each { |t|
	    		the_T.step(:train, t)
	  		}

	  		["Dan"].each { |p|
     			the_T.step(:passenger, p)}
	  		["orange"].each { |t|
	    		the_T.step(:train, t)
	  		}

	  		["Dan"].each { |p|
     			the_T.step(:passenger, p)}
	  		["orange"].each { |t|
	    		the_T.step(:train, t)
	  		}

	  		["Dan"].each { |p|
     			the_T.step(:passenger, p)}
	  		["orange"].each { |t|
	    		the_T.step(:train, t)
	  		}

	  		["Dan"].each { |p|
     			the_T.step(:passenger, p)}
	  		["orange"].each { |t|
	    		the_T.step(:train, t)
	  		}
	  		["Dan"].each { |p|
     			the_T.step(:passenger, p)}


	  		# "dan" should get off at transfer station "state"
	  		expectedpassenger2 = "Dan"
			passenger2 = []
			startstation2 = "State"
	 		the_T.stations.each do |s|
				if s.to_s == startstation2
					passenger2 = s.passengers
				end
			end
			assert passenger2.include?expectedpassenger2
		end



# rule9
#The simulation ends when all passengers have arrived at their final stops.
	def test_rule9
		the_T = Transit.new({
                      "red" => ["Davis",
                                "Harvard",
                                "Kendall",
                                "Park",
                                "Downtown Crossing",
                                "South Station",
                                "Broadway",
                                "Andrew",
                                "JFK"],
                      "green" => ["Tufts",
                                  "Magoun",
                                  "East Sommerville",
                                  "Lechmere",
                                  "North Station",
                                  "Government Center",
                                  "Park",
                                  "Boylston",
                                  "Arlington",
                                  "Copley"],
                      "blue" => ["Bowdoin",
                                 "Government Center",
                                 "State",
                                 "Aquarium",
                                 "Maverick",
                                 "Airport"],
                      "orange" => ["Ruggles",
                                   "Back Bay",
                                   "Tufts Medical Center",
                                   "Chinatown",
                                   "Downtown Crossing",
                                   "State",
                                   "North Station",
                                   "Community College",
                                   "Sullivan"]
                    })

		the_T.config_sim({"Alice" => ["Davis", "Kendall"],
	                  "Bob" => ["Park", "Tufts"],
	                  "Carol" => ["Maverick", "Davis"],
	                  "Dan" => ["Ruggles", "Aquarium", "East Sommerville"]
	                 })

		until the_T.finished?
		   ["Alice", "Bob","Carol","Dan"
		   ].each { |p|
		     the_T.step(:passenger, p)
		    
		  }
		  ["red",  "green", "blue", "orange"
		  ].each { |t|
		    the_T.step(:train, t)
		  }
		end

		# "dan" should at final station "East Sommerville"
	  		expectedpassenger2 = "Dan"
			passenger2 = []
			startstation2 = "East Sommerville"
	 		the_T.stations.each do |s|
				if s.to_s == startstation2
					passenger2 = s.passengers
				end
			end
			assert passenger2.include?expectedpassenger2
		end



end
