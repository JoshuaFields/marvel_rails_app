class Character < ActiveRecord::Base

  # Doctor Doom and Deadpool have no bio, but a link to a wiki about him is returned
  # towards the end of the JSON. Try to extract that info.
  # Also, fix the %20 formatting, possibly with gsub
    # might be easier to add the %20 in when a hero/villain is selected
  # Doctor%20Doom
  # Spider-Man

  HEROES = ["Wolverine", "Hulk", "Deadpool", "Spider-Man", "Doctor%20Doom"]

end
