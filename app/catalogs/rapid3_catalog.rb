module Rapid3Catalog
  extend ActiveSupport::Concern

  DEFINITION = [

    ### Over the last week were you able to.. ###
    ### Dress yourself, including tying shoelaces and doing buttons?
    [{
      name: :dress_yourself,
      kind: :select,
      inputs: [
        {value: 0, label: "no_difficulty", meta_label: "", helper: nil},
        {value: 1, label: "some_difficulty", meta_label: "", helper: nil},
        {value: 2, label: "much_difficulty", meta_label: "", helper: nil},
        {value: 3, label: "unable", meta_label: "", helper: nil},
      ]
    }],

    ### Get in and out of bed?
    [{
      name: :get_in_out_of_bed,
      kind: :select,
      inputs: [
        {value: 0, label: "no_difficulty", meta_label: "", helper: nil},
        {value: 1, label: "some_difficulty", meta_label: "", helper: nil},
        {value: 2, label: "much_difficulty", meta_label: "", helper: nil},
        {value: 3, label: "unable", meta_label: "", helper: nil},
      ]
    }],

    ### Lift a full glass of water to your mouth?
    [{
      name: :lift_full_glass,
      kind: :select,
      inputs: [
        {value: 0, label: "no_difficulty", meta_label: "", helper: nil},
        {value: 1, label: "some_difficulty", meta_label: "", helper: nil},
        {value: 2, label: "much_difficulty", meta_label: "", helper: nil},
        {value: 3, label: "unable", meta_label: "", helper: nil},
      ]
    }],

    ### Walk outdoors on flat ground?
    [{
      name: :walk_outdoors,
      kind: :select,
      inputs: [
        {value: 0, label: "no_difficulty", meta_label: "", helper: nil},
        {value: 1, label: "some_difficulty", meta_label: "", helper: nil},
        {value: 2, label: "much_difficulty", meta_label: "", helper: nil},
        {value: 3, label: "unable", meta_label: "", helper: nil},
      ]
    }],

    ### Wash and dry your entire body?
    [{
      name: :wash_and_dry_yourself,
      kind: :select,
      inputs: [
        {value: 0, label: "no_difficulty", meta_label: "", helper: nil},
        {value: 1, label: "some_difficulty", meta_label: "", helper: nil},
        {value: 2, label: "much_difficulty", meta_label: "", helper: nil},
        {value: 3, label: "unable", meta_label: "", helper: nil},
      ]
    }],

    ### Bend down to pick up clothing from the floor?
    [{
      name: :bend_down,
      kind: :select,
      inputs: [
        {value: 0, label: "no_difficulty", meta_label: "", helper: nil},
        {value: 1, label: "some_difficulty", meta_label: "", helper: nil},
        {value: 2, label: "much_difficulty", meta_label: "", helper: nil},
        {value: 3, label: "unable", meta_label: "", helper: nil},
      ]
    }],

    ### Turn regular faucets on and off?
    [{
      name: :turn_faucet,
      kind: :select,
      inputs: [
        {value: 0, label: "no_difficulty", meta_label: "", helper: nil},
        {value: 1, label: "some_difficulty", meta_label: "", helper: nil},
        {value: 2, label: "much_difficulty", meta_label: "", helper: nil},
        {value: 3, label: "unable", meta_label: "", helper: nil},
      ]
    }],

    ### Get in and out of a car, bus, train, or airplane?
    [{
      name: :enter_exit_vehicles,
      kind: :select,
      inputs: [
        {value: 0, label: "no_difficulty", meta_label: "", helper: nil},
        {value: 1, label: "some_difficulty", meta_label: "", helper: nil},
        {value: 2, label: "much_difficulty", meta_label: "", helper: nil},
        {value: 3, label: "unable", meta_label: "", helper: nil},
      ]
    }],

    ### Walk two miles or three kilometers, if you wish?
    [{
      name: :walk_two_miles,
      kind: :select,
      inputs: [
        {value: 0, label: "no_difficulty", meta_label: "", helper: nil},
        {value: 1, label: "some_difficulty", meta_label: "", helper: nil},
        {value: 2, label: "much_difficulty", meta_label: "", helper: nil},
        {value: 3, label: "unable", meta_label: "", helper: nil},
      ]
    }],

    ### Participate in recreational activities and sports as you would like, if you wish?
    [{
      name: :play_sports,
      kind: :select,
      inputs: [
        {value: 0, label: "no_difficulty", meta_label: "", helper: nil},
        {value: 1, label: "some_difficulty", meta_label: "", helper: nil},
        {value: 2, label: "much_difficulty", meta_label: "", helper: nil},
        {value: 3, label: "unable", meta_label: "", helper: nil},
      ]
    }],

    ### !!! RAPID3 FORM SAYS: questions K-M have been found to be informative, but are not scored formally
    ### !!! So they are commented out
    # ### Get a good night’s sleep?
    # [{
    #   name: :sleep_well,
    #   section: 10,
    #   kind: :select,
    #   inputs: [
    #     {value: 0, label: "no_difficulty", meta_label: "", helper: nil},
    #     {value: 1.1, label: "some_difficulty", meta_label: "", helper: nil},
    #     {value: 2, label: "much_difficulty", meta_label: "", helper: nil},
    #     {value: 3, label: "unable", meta_label: "", helper: nil},
    #   ]
    # }],
    #
    # ### Deal with feelings of anxiety or being nervous?
    # [{
    #   name: :deal_with_anxiety,
    #   section: 11,
    #   kind: :select,
    #   inputs: [
    #     {value: 0, label: "no_difficulty", meta_label: "", helper: nil},
    #     {value: 1, label: "some_difficulty", meta_label: "", helper: nil},
    #     {value: 2, label: "much_difficulty", meta_label: "", helper: nil},
    #     {value: 3, label: "unable", meta_label: "", helper: nil},
    #   ]
    # }],
    #
    # ### Deal with feelings of depression or feeling blue?
    # [{
    #   name: :deal_with_depression,
    #   section: 12,
    #   kind: :select,
    #   inputs: [
    #     {value: 0, label: "no_difficulty", meta_label: "", helper: nil},
    #     {value: 1, label: "some_difficulty", meta_label: "", helper: nil},
    #     {value: 2, label: "much_difficulty", meta_label: "", helper: nil},
    #     {value: 3, label: "unable", meta_label: "", helper: nil},
    #   ]
    # }],

    ### How much pain have you had because of your condition OVER THE PAST WEEK?
    [{
      name: :pain_tolerance,
      kind: :range,
      step: 0.5,
      inputs: [
        {value: 0.0, label: "no_pain", meta_label: "", helper: nil},
        {value: 10.0, label: "maximum_pain", meta_label: "", helper: nil},
      ]
    }],

    ### Considering all the ways in which illness and health conditions may affect you at this time, please indicate below how you are doing:
    [{
      name: :global_estimate,
      kind: :range,
      step: 0.5,
      inputs: [
        {value: 0.0, label: "very_well", meta_label: "", helper: nil},
        {value: 10.0, label: "very_poorly", meta_label: "", helper: nil},
      ]
    }],
  ]

  SCORING_INDEX =  [0.3, 0.7, 1.0, 1.3, 1.7, 2.0, 2.3, 2.7, 3.0, 3.3, 3.7, 4.0, 4.3, 4.7, 5.0, 5.3, 5.7, 6.0, 6.3, 6.7, 7.0, 7.3, 7.7, 8.0, 8.3, 8.7, 9.0, 9.3, 9.7, 10]

  SCORE_COMPONENTS     = %i( functional_status pain_tolerance global_estimate )

  QUESTIONS            = DEFINITION.map{|questions| questions.map{|question| question[:name] }}.flatten
  FUNCTIONAL_QUESTIONS = (QUESTIONS - [:pain_tolerance, :global_estimate])

  included do |base_class|
    validate :response_ranges
    def response_ranges
      ten_range = (0..10).step(0.5).to_a
      ten_range << nil
      ranges = [
        [:pain_tolerance, ten_range],
        [:global_estimate, ten_range],
      ]

      FUNCTIONAL_QUESTIONS.each{|q| ranges << [q, [nil,*0..3] ]}

      ranges.each do |range|
        response = rapid3_responses.select{|r| r.name.to_sym == range[0]}.first
        if response and not range[1].include?(response.value)
          # self.errors.add "responses.#{range[0]}", "Not within allowed values"
          # self.errors.messages[:responses] ||= {}
          # self.errors.messages[:responses][range[0]] = "Not within allowed values"
          self.errors.add range[0], "not_within_allowed_values"
        end
      end

    end

  end

  def rapid3_responses
    responses.select{|r| r.catalog == "rapid3"}
  end

  def filled_rapid3_entry?
    valid_responses = rapid3_responses.reduce([]) do |accu, response|
      accu << response.name.to_sym if response.name and response.value.present?
      accu
    end
    (QUESTIONS-valid_responses) == []
  end

  def complete_rapid3_entry?
    filled_rapid3_entry?
  end

  # def setup_rapid3_scoring
  # end

  # def finalize_rapid3_scoring(score)
  #   RAPID3_SCORING_INDEX[score.round-1] # "weight" the final score
  # end

  def rapid3_functional_status_score
    score = FUNCTIONAL_QUESTIONS.reduce(0) do |sum, question_name|
      sum + self.send("rapid3_#{question_name}")
    end
    SCORING_INDEX[score-1]
  end

  def rapid3_pain_tolerance_score
    self.send(:rapid3_pain_tolerance)
  end

  def rapid3_global_estimate_score
    self.send(:rapid3_global_estimate)
  end


end