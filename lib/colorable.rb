module Colorable
  PALETTES = {
    flaredown: (1..34).to_a
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
  #   => [ ["symptom_droopy lips", 1], ["symptom_slippery tongue", 2] ]
  #
  # Returns an array of active colorable names with their matching palette values
  def colors_for(colorables, palette: nil)
    raise "Color palette not found" unless PALETTES.keys.include?(palette)
    palette       = PALETTES[palette.to_sym]
    palette_size  = palette.length

    colorables
      .sort_by{|c| c[:date]}
      .map.with_index do |colorable, index|
        index = index - palette_size while index > palette_size-1 # loop around to beginning
        [
          colorable[:name],
          palette[index]
        ] unless colorable[:active] == false
      end.compact # remove nils
  end

end