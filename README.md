# Train-Simulation
It's a class project, written with ruby. It can simulate the T at Boston.

Rules of the Simulation
The simulation is initially configured with
A set of lines (e.g., Red, Green, Blue, Orange), each of which has an ordered list of stations (e.g., Davis, Porter, Harvard, Central, Kendall). Stations are identified by names, and if the same station name is on two lines, that's considered just one station.
A set of passengers, each of whom has a path they want to take (e.g., Alice wants to go from Kendall to Davis).
(You can assume all lines, stations, and passengers are named uniquely.)
There is exactly one train on each line.
At the start of the simulation,
Each train starts at the first station for that line.
Each passenger starts at the initial station on their path.
Trains move along their path until they reach the end of the line, then they change direction and follow the line in reverse until they reach the beginning of the line, etc.
The simulation is divided into discrete steps. At each step, exactly one thing happens: Either a train moves from one station to another (instantaneously), a passenger boards a train, or a passenger exits a train.
At most one train can be at a station at a time. Trains and stations can hold an unbounded number of passengers. You can assume the initial configuration does not place two trains at the same station.
A passenger can only board a train that is at the same station as the passenger; they can only exit a train at the station it is currently at.
A passenger boards a train if doing so will make progress on their path. A passenger exits from a train if either they have arrived at the next station on their path or if they need to change trains to continue along their path. (Note that the path for each passenger does not tell you the exact route; you have to compute that. Sometimes there may be more than one valid route, in which case the passenger can take either.)
The simulation ends when all passengers have arrived at their final stops.
Your simulation must call the following methods to print messages as trains and passengers move. Your simulation must produce no other output.
Log.train_moves(t, s1, s2) when train t leaves station s1 and enters station s2.
Log.passenger_boards(p, t, s) when passenger p boards train t at station s.
Log.passenger_exits(p, t, s) when passenger p exits train t at station s.

Here is an example:
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

For this example, it will have following simulation:

Passenger Alice boarding train red at Davis
Passenger Dan boarding train orange at Ruggles
Train red moves from Davis to Harvard
Train green moves from Tufts to Magoun
Train blue moves from Bowdoin to Government Center
Train orange moves from Ruggles to Back Bay
Train red moves from Harvard to Kendall
Train green moves from Magoun to East Sommerville
Train blue moves from Government Center to State
Train orange moves from Back Bay to Tufts Medical Center
Passenger Alice exiting train red at Kendall
Train red moves from Kendall to Park
Train green moves from East Sommerville to Lechmere
Train blue moves from State to Aquarium
Train orange moves from Tufts Medical Center to Chinatown
Train red moves from Park to Downtown Crossing
Train green moves from Lechmere to North Station
Train blue moves from Aquarium to Maverick
Passenger Carol boarding train blue at Maverick
Train red moves from Downtown Crossing to South Station
Train green moves from North Station to Government Center
Train blue moves from Maverick to Airport
Train orange moves from Chinatown to Downtown Crossing
Train red moves from South Station to Broadway
Train green moves from Government Center to Park
Train blue moves from Airport to Maverick
Train orange moves from Downtown Crossing to State
Passenger Bob boarding train green at Park
Passenger Dan exiting train orange at State
Train red moves from Broadway to Andrew
Train green moves from Park to Boylston
Train blue moves from Maverick to Aquarium
Train orange moves from State to North Station
Train red moves from Andrew to JFK
Train green moves from Boylston to Arlington
Train blue moves from Aquarium to State
Train orange moves from North Station to Community College
Passenger Dan boarding train blue at State
Train red moves from JFK to Andrew
Train green moves from Arlington to Copley
Train blue moves from State to Government Center
Train orange moves from Community College to Sullivan
Passenger Carol exiting train blue at Government Center
Train red moves from Andrew to Broadway
Train green moves from Copley to Arlington
Train blue moves from Government Center to Bowdoin
Train orange moves from Sullivan to Community College
Train red moves from Broadway to South Station
Train green moves from Arlington to Boylston
Train blue moves from Bowdoin to Government Center
Train orange moves from Community College to North Station
Train red moves from South Station to Downtown Crossing
Train green moves from Boylston to Park
Train blue moves from Government Center to State
Train green moves from Park to Government Center
Train blue moves from State to Aquarium
Train orange moves from North Station to State
Passenger Carol boarding train green at Government Center
Passenger Dan exiting train blue at Aquarium
Train red moves from Downtown Crossing to Park
Train green moves from Government Center to North Station
Train blue moves from Aquarium to Maverick
Train orange moves from State to Downtown Crossing
Train red moves from Park to Kendall
Train green moves from North Station to Lechmere
Train blue moves from Maverick to Airport
Train orange moves from Downtown Crossing to Chinatown
Train red moves from Kendall to Harvard
Train green moves from Lechmere to East Sommerville
Train blue moves from Airport to Maverick
Train orange moves from Chinatown to Tufts Medical Center
Train red moves from Harvard to Davis
Train green moves from East Sommerville to Magoun
Train blue moves from Maverick to Aquarium
Train orange moves from Tufts Medical Center to Back Bay
Passenger Dan boarding train blue at Aquarium
Train red moves from Davis to Harvard
Train green moves from Magoun to Tufts
Train blue moves from Aquarium to State
Train orange moves from Back Bay to Ruggles
Passenger Bob exiting train green at Tufts
Train red moves from Harvard to Kendall
Train green moves from Tufts to Magoun
Train blue moves from State to Government Center
Train orange moves from Ruggles to Back Bay
Passenger Dan exiting train blue at Government Center
Train red moves from Kendall to Park
Train green moves from Magoun to East Sommerville
Train blue moves from Government Center to Bowdoin
Train orange moves from Back Bay to Tufts Medical Center
Train red moves from Park to Downtown Crossing
Train green moves from East Sommerville to Lechmere
Train blue moves from Bowdoin to Government Center
Train orange moves from Tufts Medical Center to Chinatown
Train red moves from Downtown Crossing to South Station
Train green moves from Lechmere to North Station
Train blue moves from Government Center to State
Train orange moves from Chinatown to Downtown Crossing
Train red moves from South Station to Broadway
Train green moves from North Station to Government Center
Train blue moves from State to Aquarium
Train orange moves from Downtown Crossing to State
Passenger Dan boarding train green at Government Center
Train red moves from Broadway to Andrew
Train green moves from Government Center to Park
Train blue moves from Aquarium to Maverick
Train orange moves from State to North Station
Passenger Carol exiting train green at Park
Train red moves from Andrew to JFK
Train green moves from Park to Boylston
Train blue moves from Maverick to Airport
Train orange moves from North Station to Community College
Train red moves from JFK to Andrew
Train green moves from Boylston to Arlington
Train blue moves from Airport to Maverick
Train orange moves from Community College to Sullivan
Train red moves from Andrew to Broadway
Train green moves from Arlington to Copley
Train blue moves from Maverick to Aquarium
Train orange moves from Sullivan to Community College
Train red moves from Broadway to South Station
Train green moves from Copley to Arlington
Train blue moves from Aquarium to State
Train orange moves from Community College to North Station
Train red moves from South Station to Downtown Crossing
Train green moves from Arlington to Boylston
Train blue moves from State to Government Center
Train orange moves from North Station to State
Train red moves from Downtown Crossing to Park
Train blue moves from Government Center to Bowdoin
Train orange moves from State to Downtown Crossing
Passenger Carol boarding train red at Park
Train red moves from Park to Kendall
Train green moves from Boylston to Park
Train blue moves from Bowdoin to Government Center
Train orange moves from Downtown Crossing to Chinatown
Train red moves from Kendall to Harvard
Train blue moves from Government Center to State
Train orange moves from Chinatown to Tufts Medical Center
Train red moves from Harvard to Davis
Train green moves from Park to Government Center
Train blue moves from State to Aquarium
Train orange moves from Tufts Medical Center to Back Bay
Passenger Carol exiting train red at Davis
Train red moves from Davis to Harvard
Train green moves from Government Center to North Station
Train blue moves from Aquarium to Maverick
Train orange moves from Back Bay to Ruggles
Train red moves from Harvard to Kendall
Train green moves from North Station to Lechmere
Train blue moves from Maverick to Airport
Train orange moves from Ruggles to Back Bay
Train red moves from Kendall to Park
Train green moves from Lechmere to East Sommerville
Train blue moves from Airport to Maverick
Train orange moves from Back Bay to Tufts Medical Center
Passenger Dan exiting train green at East Sommerville
Train red moves from Park to Downtown Crossing
Train green moves from East Sommerville to Magoun
Train blue moves from Maverick to Aquarium
Train orange moves from Tufts Medical Center to Chinatown
