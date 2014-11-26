module HbiCatalog
  extend ActiveSupport::Concern

  HBI_DEFINITION = {

    ### General Well-Being
    general_wellbeing: [{
      # 0 Very Well
      # 1 Slightly below par
      # 2 Poor
      # 3 Very poor
      # 4 Terrible

      name: :general_wellbeing,
      section: 0,
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
    ab_pain: [{
      # 0 None
      # 1 Mild
      # 2 Moderate
      # 3 Severe

      name: :ab_pain,
      section: 1,
      kind: :select,
      inputs: [
        {value: 0, label: "none", meta_label: "happy_face", helper: nil},
        {value: 1, label: "mild", meta_label: "neutral_face", helper: nil},
        {value: 2, label: "moderate", meta_label: "frowny_face", helper: nil},
        {value: 3, label: "severe", meta_label: "sad_face", helper: nil},
      ]
    }],

    ### Number of Liquid/Soft Stools for the Day
    stools: [{
      name: :stools,
      section: 2,
      kind: :number,
      inputs: [
        {value: 0, label: nil, meta_label: nil, helper: "stools_daily"}
      ]
    }],

    ### Abdominal Mass
    ab_mass: [{
      # 0 None
      # 1 Dubious
      # 2 Definite
      # 3 Definite and Tender

      name: :ab_mass,
      section: 3,
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

    complications: [
      {
        name: :complication_arthralgia,
        section: 4,
        kind: :checkbox
      },
      {
        name: :complication_uveitis,
        section: 4,
        kind: :checkbox
      },
      {
        name: :complication_erythema_nodosum,
        section: 4,
        kind: :checkbox
      },
      {
        name: :complication_aphthous_ulcers,
        section: 4,
        kind: :checkbox
      },
      {
        name: :complication_anal_fissure,
        section: 4,
        kind: :checkbox
      },
      {
        name: :complication_fistula,
        section: 4,
        kind: :checkbox
      },
      {
        name: :complication_abscess,
        section: 4,
        kind: :checkbox
      }
    ]
  }

  HBI_SCORE_COMPONENTS  = HBI_DEFINITION.map{|key,value| key }
  HBI_QUESTIONS         = HBI_DEFINITION.map{|k,v| v}.map{|questions| questions.map{|question| question[:name] }}.flatten
  HBI_COMPLICATIONS     = HBI_DEFINITION[:complications].map{|question| question[:name] }.flatten

  included do |base_class|
    base_class.question_names = base_class.question_names | HBI_QUESTIONS

    validate :response_ranges
    def response_ranges
      ranges = [
        [:general_wellbeing, [*0..4]],
        [:ab_pain, [*0..3]],
        [:stools, [*0..50]],
        [:ab_mass, [*0..3]],
      ]

      ranges.each do |range|
        response = responses.select{|r| r.name.to_sym == range[0]}.first
        if response and not range[1].include?(response.value)
          # self.errors.add "responses.#{range[0]}", "Not within allowed values"
          self.errors.messages[:responses] ||= {}
          self.errors.messages[:responses][range[0]] = "Not within allowed values"
        end
      end

    end

    validate :response_booleans
    def response_booleans
      HbiCatalog::HBI_COMPLICATIONS.each do |name|
        response = responses.select{|r| r.name == name}.first
        if response and not [0,1].include? response.value
          self.errors.messages[:responses] ||= {}
          self.errors.messages[:responses][name.to_sym] = "Must be true or false"
        end
      end
    end

  end

  # def valid_hbi_entry?
  #   return false unless last_6_entries.count == 6
  #   !last_6_entries.map{|e| e.filled_hbi_entry?}.include?(false)
  # end
  def filled_hbi_entry?
    (HBI_QUESTIONS - responses.reduce([]) {|accu, response| (accu << response.name.to_sym) if response.name}) == []
  end

  def complete_hbi_entry?
    filled_hbi_entry?
  end

  # def setup_hbi_scoring
  # end

  def hbi_complications_score
    HBI_COMPLICATIONS.reduce(0) do |sum, question_name|
      sum + (self.send(question_name).zero? ? 1 : 0)
    end
  end


end