module Gad7Catalog
  extend ActiveSupport::Concern

  ### Over the last two weeks, how often have you been bothered by any of the following problems?

  DEFINITION = [

    ### Feeling nervous, anxious or on edge?
    [{
      # 0 Not at all
      # 1 Several days
      # 2 More than half the days
      # 3 Nearly every day

      name: :anxiety,
      kind: :select,
      inputs: [
        {value: 0, label: "not_at_all", meta_label: "", helper: nil},
        {value: 1, label: "several_days", meta_label: "", helper: nil},
        {value: 2, label: "more_than_half_the_days", meta_label: "", helper: nil},
        {value: 3, label: "nearly_every_day", meta_label: "", helper: nil},
      ]
    }],

    ### Not being able to stop or control worrying?
    [{
      # 0 Not at all
      # 1 Several days
      # 2 More than half the days
      # 3 Nearly every day

      name: :uncontrollable_worry,
      kind: :select,
      inputs: [
        {value: 0, label: "not_at_all", meta_label: "", helper: nil},
        {value: 1, label: "several_days", meta_label: "", helper: nil},
        {value: 2, label: "more_than_half_the_days", meta_label: "", helper: nil},
        {value: 3, label: "nearly_every_day", meta_label: "", helper: nil},
      ]
    }],

    ### Worrying too much about different things?
    [{
      # 0 Not at all
      # 1 Several days
      # 2 More than half the days
      # 3 Nearly every day

      name: :excessive_worry,
      kind: :select,
      inputs: [
        {value: 0, label: "not_at_all", meta_label: "", helper: nil},
        {value: 1, label: "several_days", meta_label: "", helper: nil},
        {value: 2, label: "more_than_half_the_days", meta_label: "", helper: nil},
        {value: 3, label: "nearly_every_day", meta_label: "", helper: nil},
      ]
    }],

    ### Trouble relaxing?
    [{
      # 0 Not at all
      # 1 Several days
      # 2 More than half the days
      # 3 Nearly every day

      name: :trouble_relaxing,
      kind: :select,
      inputs: [
        {value: 0, label: "not_at_all", meta_label: "", helper: nil},
        {value: 1, label: "several_days", meta_label: "", helper: nil},
        {value: 2, label: "more_than_half_the_days", meta_label: "", helper: nil},
        {value: 3, label: "nearly_every_day", meta_label: "", helper: nil},
      ]
    }],

    ### Being so restless that it is hard to sit still?
    [{
      # 0 Not at all
      # 1 Several days
      # 2 More than half the days
      # 3 Nearly every day

      name: :restlessness,
      kind: :select,
      inputs: [
        {value: 0, label: "not_at_all", meta_label: "", helper: nil},
        {value: 1, label: "several_days", meta_label: "", helper: nil},
        {value: 2, label: "more_than_half_the_days", meta_label: "", helper: nil},
        {value: 3, label: "nearly_every_day", meta_label: "", helper: nil},
      ]
    }],

    ### Becoming easily annoyed or irritable?
    [{
      # 0 Not at all
      # 1 Several days
      # 2 More than half the days
      # 3 Nearly every day

      name: :irritability,
      kind: :select,
      inputs: [
        {value: 0, label: "not_at_all", meta_label: "", helper: nil},
        {value: 1, label: "several_days", meta_label: "", helper: nil},
        {value: 2, label: "more_than_half_the_days", meta_label: "", helper: nil},
        {value: 3, label: "nearly_every_day", meta_label: "", helper: nil},
      ]
    }],
 
    ### Feeling afraid as if something awful might happen?
    [{
      # 0 Not at all
      # 1 Several days
      # 2 More than half the days
      # 3 Nearly every day

      name: :impending_doom,
      kind: :select,
      inputs: [
        {value: 0, label: "not_at_all", meta_label: "", helper: nil},
        {value: 1, label: "several_days", meta_label: "", helper: nil},
        {value: 2, label: "more_than_half_the_days", meta_label: "", helper: nil},
        {value: 3, label: "nearly_every_day", meta_label: "", helper: nil},
      ]
    }],

  ]

  SCORE_COMPONENTS  = %i( anxiety uncontrollable_worry excessive_worry trouble_relaxing restlessness irritability impending_doom )
  QUESTIONS         = DEFINITION.map{|questions| questions.map{|question| question[:name] }}.flatten
  COMPLICATIONS     = DEFINITION[4].map{|question| question[:name] }.flatten

  included do |base_class|
    validate :gad7_response_ranges
    def gad7_response_ranges
      ranges = [
        [:anxiety, [nil,*0..3]],
        [:uncontrollable_worry, [nil,*0..3]],
        [:excessive_worry, [nil,*0..3]],
        [:trouble_relaxing, [nil,*0..3]],
        [:restlessness, [nil,*0..3]],
        [:irritability, [nil,*0..3]],
        [:impending_doom, [nil,*0..3]],     
      ]

      ranges.each do |range|
        response = gad7_responses.detect{|r| r.name.to_sym == range[0]}
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

  def gad7_responses
    responses.select{|r| r.catalog == "gad7"}
  end

  # def valid_hbi_entry?
  #   return false unless last_6_entries.count == 6
  #   !last_6_entries.map{|e| e.filled_hbi_entry?}.include?(false)
  # end
  def filled_gad7_entry?
    valid_responses = gad7_responses.reduce([]) do |accu, response|
      accu << response.name.to_sym if response.name and response.value.present?
      accu
    end
    (QUESTIONS-valid_responses) == []
  end

  def complete_gad7_entry?
    filled_gad7_entry?
  end

  # def setup_hbi_scoring
  # end

  def gad7_complications_score
    COMPLICATIONS.reduce(0) do |sum, question_name|
      sum + (self.send("gad7_#{question_name}").to_i)
    end.to_f
  end


end