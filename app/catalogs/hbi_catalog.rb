module HbiCatalog
  extend ActiveSupport::Concern

  DEFINITION = [

    ### General Well-Being
    [{
      # 0 Very Well
      # 1 Slightly below par
      # 2 Poor
      # 3 Very poor
      # 4 Terrible

      name: :general_wellbeing,
      kind: :select,
      inputs: [
        {value: 0, label: "very_well", meta_label: "happy_face", helper: nil},
        {value: 1, label: "slightly_below_par", meta_label: "neutral_face", helper: nil},
        {value: 2, label: "poor", meta_label: "frowny_face", helper: nil},
        {value: 3, label: "very_poor", meta_label: "sad_face", helper: nil},
        {value: 4, label: "terrible", meta_label: "sad_face", helper: nil},
      ]
    }],

    ### Abdominal Pain
    [{
      # 0 None
      # 1 Mild
      # 2 Moderate
      # 3 Severe

      name: :ab_pain,
      kind: :select,
      inputs: [
        {value: 0, label: "none", meta_label: "happy_face", helper: nil},
        {value: 1, label: "mild", meta_label: "neutral_face", helper: nil},
        {value: 2, label: "moderate", meta_label: "frowny_face", helper: nil},
        {value: 3, label: "severe", meta_label: "sad_face", helper: nil},
      ]
    }],

    ### Number of Liquid/Soft Stools for the Day
    [{
      name: :stools,
      kind: :number,
      inputs: [
        {value: 0, label: nil, meta_label: nil, helper: "stools_daily"}
      ]
    }],

    ### Abdominal Mass
    [{
      # 0 None
      # 1 Dubious
      # 2 Definite
      # 3 Definite and Tender

      name: :ab_mass,
      kind: :select,
      inputs: [
        {value: 0, label: "none", meta_label: "happy_face", helper: nil},
        {value: 1, label: "dubious", meta_label: "neutral_face", helper: nil},
        {value: 2, label: "definite", meta_label: "frowny_face", helper: nil},
        {value: 3, label: "definite_and_tender", meta_label: "sad_face", helper: nil},
      ]
    }],

    ### Complications (1 point each)
    # Arthralgia
    # Uveitis
    # Erythema nodosum
    # Aphthous ulcers
    # Pyoderma gangrenosum
    # Anal fissure
    # New fistula
    # Abscess

    [
      {
        name: :complication_arthralgia,
        kind: :checkbox
      },
      {
        name: :complication_uveitis,
        kind: :checkbox
      },
      {
        name: :complication_erythema_nodosum,
        kind: :checkbox
      },
      {
        name: :complication_aphthous_ulcers,
        kind: :checkbox
      },
      {
        name: :complication_anal_fissure,
        kind: :checkbox
      },
      {
        name: :complication_fistula,
        kind: :checkbox
      },
      {
        name: :complication_abscess,
        kind: :checkbox
      }
    ]
  ]

  SCORE_COMPONENTS  = %i( general_wellbeing ab_pain stools ab_mass complications )
  QUESTIONS         = DEFINITION.map{|questions| questions.map{|question| question[:name] }}.flatten
  COMPLICATIONS     = DEFINITION[4].map{|question| question[:name] }.flatten

  included do |base_class|
    validate :hbi_response_ranges
    def hbi_response_ranges
      ranges = [
        [:general_wellbeing, [*0..4]],
        [:ab_pain, [*0..3]],
        [:stools, [*0..50]],
        [:ab_mass, [*0..3]],
      ]

      ranges.each do |range|
        response = hbi_responses.detect{|r| r.name.to_sym == range[0]}
        if response and not range[1].include?(response.value)
          # TODO add catalog namespace here
          self.errors.messages[:responses] ||= {}
          self.errors.messages[:responses][range[0]] = "Not within allowed values"
        end
      end

    end

    validate :hbi_response_booleans
    def hbi_response_booleans
      HbiCatalog::COMPLICATIONS.each do |name|
        response = hbi_responses.detect{|r| r.name.to_sym == name}

        if response and not [0,1].include? response.value.to_i
          self.errors.messages[:responses] ||= {}
          self.errors.messages[:responses][name.to_sym] = "Must be true or false"
        end
      end
    end

  end

  def hbi_responses
    responses.select{|r| r.catalog == "hbi"}
  end

  # def valid_hbi_entry?
  #   return false unless last_6_entries.count == 6
  #   !last_6_entries.map{|e| e.filled_hbi_entry?}.include?(false)
  # end
  def filled_hbi_entry?
    (QUESTIONS - hbi_responses.reduce([]) {|accu, response| (accu << response.name.to_sym) if response.name}) == []
  end

  def complete_hbi_entry?
    filled_hbi_entry?
  end

  # def setup_hbi_scoring
  # end

  def hbi_complications_score
    COMPLICATIONS.reduce(0) do |sum, question_name|
      sum + (self.send("hbi_#{question_name}").to_i)
    end.to_f
  end


end