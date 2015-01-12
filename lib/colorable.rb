module Colorable
  PALETTES = {
    pastel: %w( #F7977A #F9AD81 #FDC68A #FFF79A #C4DF9B #A2D39C #82CA9D #7BCDC8 #6ECFF6 #7EA7D8 #8493CA #8882BE #A187BE #BC8DBF #F49AC2 #F6989D ),
    light: %w( #F26C4F #F68E55 #FBAF5C #FFF467 #ACD372 #7CC576 #3BB878 #1ABBB4 #00BFF3 #438CCA #5574B9 #605CA8 #855FA8 #A763A8 #F06EA9 #F26D7D )
  }

  # Generate a list of as-unique-as-possible colors
  #
  # palette     - name of color palette to be used
  # colorables  - array of colorable objects
  #
  # Each "colorable" has a unique "name", "created_at" date and "active" flag
  #
  # Examples
  #
  #   colors_for([{name: "symptom_droopy lips", date: DateTime.now, active: true}, {name: "symptom_slippery tongue", date: DateTime.now, active: true}])
  #
  #   => [ ["symptom_droopy lips", "#F7977A"], ["symptom_slippery tongue","#F9AD81"] ]
  #
  # Returns an array of active colorable names with hex colors
  def colors_for(colorables, palette: :pastel)
    palette       = PALETTES[palette]
    palette_size  = palette.length

    colorables
      .sort_by{|c| c[:date]}
      .map.with_index do |colorable, index|
        index = index - palette_size while index > palette_size-1 # loop around to beginning
        puts index
        [
          colorable[:name],
          palette[index]
        ] unless colorable[:active] == false
      end.compact # remove nils
  end

end