module Phq9Catalog
  extend ActiveSupport::Concern

  ### Over the last two weeks, how often have you been bothered by any of the following problems?

  DEFINITION = [

    ### Little interest or pleasure in doing things?
    [{
      # 0 Not at all
      # 1 Several days
      # 2 More than half the days
      # 3 Nearly every day

      name: :low_interest,
      kind: :select,
      inputs: [
        {value: 0, label: "not_at_all", meta_label: "", helper: nil},
        {value: 1, label: "several_days", meta_label: "", helper: nil},
        {value: 2, label: "more_than_half_the_days", meta_label: "", helper: nil},
        {value: 3, label: "nearly_every_day", meta_label: "", helper: nil},
      ]
    }],

    ### Feeling down, depressed, or hopeless?
    [{
      # 0 Not at all
      # 1 Several days
      # 2 More than half the days
      # 3 Nearly every day

      name: :depressed_mood,
      kind: :select,
      inputs: [
        {value: 0, label: "not_at_all", meta_label: "", helper: nil},
        {value: 1, label: "several_days", meta_label: "", helper: nil},
        {value: 2, label: "more_than_half_the_days", meta_label: "", helper: nil},
        {value: 3, label: "nearly_every_day", meta_label: "", helper: nil},
      ]
    }],

    ### Trouble falling or staying asleep, or sleeping too much?
    [{
      # 0 Not at all
      # 1 Several days
      # 2 More than half the days
      # 3 Nearly every day

      name: :sleep_dysfunction,
      kind: :select,
      inputs: [
        {value: 0, label: "not_at_all", meta_label: "", helper: nil},
        {value: 1, label: "several_days", meta_label: "", helper: nil},
        {value: 2, label: "more_than_half_the_days", meta_label: "", helper: nil},
        {value: 3, label: "nearly_every_day", meta_label: "", helper: nil},
      ]
    }],

    ### Feeling tired or having little energy?
    [{
      # 0 Not at all
      # 1 Several days
      # 2 More than half the days
      # 3 Nearly every day

      name: :fatigue,
      kind: :select,
      inputs: [
        {value: 0, label: "not_at_all", meta_label: "", helper: nil},
        {value: 1, label: "several_days", meta_label: "", helper: nil},
        {value: 2, label: "more_than_half_the_days", meta_label: "", helper: nil},
        {value: 3, label: "nearly_every_day", meta_label: "", helper: nil},
      ]
    }],

    ### Poor appetite or overeating?
    [{
      # 0 Not at all
      # 1 Several days
      # 2 More than half the days
      # 3 Nearly every day

      name: :appetite_problems,
      kind: :select,
      inputs: [
        {value: 0, label: "not_at_all", meta_label: "", helper: nil},
        {value: 1, label: "several_days", meta_label: "", helper: nil},
        {value: 2, label: "more_than_half_the_days", meta_label: "", helper: nil},
        {value: 3, label: "nearly_every_day", meta_label: "", helper: nil},
      ]
    }],

    ### Feeling bad about yourself - or that you are a failure or have let yourself or your family down?
    [{
      # 0 Not at all
      # 1 Several days
      # 2 More than half the days
      # 3 Nearly every day

      name: :feeling_of_failure,
      kind: :select,
      inputs: [
        {value: 0, label: "not_at_all", meta_label: "", helper: nil},
        {value: 1, label: "several_days", meta_label: "", helper: nil},
        {value: 2, label: "more_than_half_the_days", meta_label: "", helper: nil},
        {value: 3, label: "nearly_every_day", meta_label: "", helper: nil},
      ]
    }],
 
    ### Trouble concentrating on things, such as reading the newspaper or watching television?
    [{
      # 0 Not at all
      # 1 Several days
      # 2 More than half the days
      # 3 Nearly every day

      name: :poor_concentration,
      kind: :select,
      inputs: [
        {value: 0, label: "not_at_all", meta_label: "", helper: nil},
        {value: 1, label: "several_days", meta_label: "", helper: nil},
        {value: 2, label: "more_than_half_the_days", meta_label: "", helper: nil},
        {value: 3, label: "nearly_every_day", meta_label: "", helper: nil},
      ]
    }],

    ### Moving or speaking so slowly that other people could have noticed? Or the opposite - being so fidgety or restless that you have been moving around a lot more than usual?
    [{
      # 0 Not at all
      # 1 Several days
      # 2 More than half the days
      # 3 Nearly every day

      name: :movement_dysfunction,
      kind: :select,
      inputs: [
        {value: 0, label: "not_at_all", meta_label: "", helper: nil},
        {value: 1, label: "several_days", meta_label: "", helper: nil},
        {value: 2, label: "more_than_half_the_days", meta_label: "", helper: nil},
        {value: 3, label: "nearly_every_day", meta_label: "", helper: nil},
      ]
    }],

    ### Thoughts that you would be better off dead, or of hurting yourself in some way?
    [{
      # 0 Not at all
      # 1 Several days
      # 2 More than half the days
      # 3 Nearly every day

      name: :thoughts_of_self_harm,
      kind: :select,
      inputs: [
        {value: 0, label: "not_at_all", meta_label: "", helper: nil},
        {value: 1, label: "several_days", meta_label: "", helper: nil},
        {value: 2, label: "more_than_half_the_days", meta_label: "", helper: nil},
        {value: 3, label: "nearly_every_day", meta_label: "", helper: nil},
      ]
    }],

  ]

  SCORE_COMPONENTS  = %i( low_interest depressed_mood sleep_dysfunction fatigue appetite_problems feeling_of_failure poor_concentration movement_dysfunction thoughts_of_self_harm )
  QUESTIONS         = DEFINITION.map{|questions| questions.map{|question| question[:name] }}.flatten
  COMPLICATIONS     = DEFINITION[4].map{|question| question[:name] }.flatten

  included do |base_class|
    validate :phq9_response_ranges
    def phq9_response_ranges
      ranges = [
        [:low_interest, [nil,*0..3]],
        [:depressed_mood, [nil,*0..3]],
        [:sleep_dysfunction, [nil,*0..3]],
        [:fatigue, [nil,*0..3]],
        [:appetite_problems, [nil,*0..3]],
        [:feeling_of_failure, [nil,*0..3]],
        [:poor_concentration, [nil,*0..3]],
        [:movement_dysfunction, [nil,*0..3]],
        [:thoughts_of_self_harm, [nil,*0..3]],        
      ]

      ranges.each do |range|
        response = phq9_responses.detect{|r| r.name.to_sym == range[0]}
        if response and not range[1].include?(response.value)
          # TODO add catalog namespace here
          # self.errors.messages ||= {}
          # self.errors.messages[range[0]] = "no_within_allowed_values"
          self.errors.add range[0], "not_within_allowed_values"
        end
      end

    end

    # validate :hbi_response_booleans
    # def hbi_response_booleans
    #   HbiCatalog::COMPLICATIONS.each do |name|
    #     response = hbi_responses.detect{|r| r.name.to_sym == name}

    #     if response and not [0,1].include? response.value.to_i
    #       # self.errors.messages ||= {}
    #       # self.errors.messages[name.to_sym] = "must_be_boolean"
    #       self.errors.add name.to_sym, "must_be_boolean"
    #     end
    #   end
    # end

  end

  def phq9_responses
    responses.select{|r| r.catalog == "phq9"}
  end

  # def valid_hbi_entry?
  #   return false unless last_6_entries.count == 6
  #   !last_6_entries.map{|e| e.filled_hbi_entry?}.include?(false)
  # end
  def filled_phq9_entry?
    valid_responses = phq9_responses.reduce([]) do |accu, response|
      accu << response.name.to_sym if response.name and response.value.present?
      accu
    end
    (QUESTIONS-valid_responses) == []
  end

  def complete_phq9_entry?
    filled_phq9_entry?
  end

  # def setup_hbi_scoring
  # end

  def phq9_complications_score
    COMPLICATIONS.reduce(0) do |sum, question_name|
      sum + (self.send("phq9_#{question_name}").to_i)
    end.to_f
  end


end