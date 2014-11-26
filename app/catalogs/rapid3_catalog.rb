module Rapid3Catalog
  extend ActiveSupport::Concern

  RAPID3_DEFINITION = {

    ### Over the last week were you able to.. ###
    ### Dress yourself, including tying shoelaces and doing buttons?
    dress_yourself: [{
      name: :dress_yourself,
      section: 0,
      kind: :select,
      inputs: [
        {value: 0, label: "no_difficulty", meta_label: "happy_face", helper: nil},
        {value: 1, label: "some_difficulty", meta_label: "neutral_face", helper: nil},
        {value: 2, label: "much_difficulty", meta_label: "frowny_face", helper: nil},
        {value: 3, label: "unable", meta_label: "sad_face", helper: nil},
      ]
    }],

    ### Get in and out of bed?
    get_in_out_of_bed: [{
      name: :get_in_out_of_bed,
      section: 1,
      kind: :select,
      inputs: [
        {value: 0, label: "no_difficulty", meta_label: "happy_face", helper: nil},
        {value: 1, label: "some_difficulty", meta_label: "neutral_face", helper: nil},
        {value: 2, label: "much_difficulty", meta_label: "frowny_face", helper: nil},
        {value: 3, label: "unable", meta_label: "sad_face", helper: nil},
      ]
    }],

    ### Lift a full glass of water to your mouth?
    lift_full_glass: [{
      name: :lift_full_glass,
      section: 2,
      kind: :select,
      inputs: [
        {value: 0, label: "no_difficulty", meta_label: "happy_face", helper: nil},
        {value: 1, label: "some_difficulty", meta_label: "neutral_face", helper: nil},
        {value: 2, label: "much_difficulty", meta_label: "frowny_face", helper: nil},
        {value: 3, label: "unable", meta_label: "sad_face", helper: nil},
      ]
    }],

    ### Walk outdoors on flat ground?
    walk_outdoors: [{
      name: :walk_outdoors,
      section: 3,
      kind: :select,
      inputs: [
        {value: 0, label: "no_difficulty", meta_label: "happy_face", helper: nil},
        {value: 1, label: "some_difficulty", meta_label: "neutral_face", helper: nil},
        {value: 2, label: "much_difficulty", meta_label: "frowny_face", helper: nil},
        {value: 3, label: "unable", meta_label: "sad_face", helper: nil},
      ]
    }],

    ### Wash and dry your entire body?
    wash_and_dry_yourself: [{
      name: :wash_and_dry_yourself,
      section: 4,
      kind: :select,
      inputs: [
        {value: 0, label: "no_difficulty", meta_label: "happy_face", helper: nil},
        {value: 1, label: "some_difficulty", meta_label: "neutral_face", helper: nil},
        {value: 2, label: "much_difficulty", meta_label: "frowny_face", helper: nil},
        {value: 3, label: "unable", meta_label: "sad_face", helper: nil},
      ]
    }],

    ### Bend down to pick up clothing from the floor?
    bend_down: [{
      name: :bend_down,
      section: 5,
      kind: :select,
      inputs: [
        {value: 0, label: "no_difficulty", meta_label: "happy_face", helper: nil},
        {value: 1, label: "some_difficulty", meta_label: "neutral_face", helper: nil},
        {value: 2, label: "much_difficulty", meta_label: "frowny_face", helper: nil},
        {value: 3, label: "unable", meta_label: "sad_face", helper: nil},
      ]
    }],

    ### Turn regular faucets on and off?
    turn_faucet: [{
      name: :turn_faucet,
      section: 6,
      kind: :select,
      inputs: [
        {value: 0, label: "no_difficulty", meta_label: "happy_face", helper: nil},
        {value: 1, label: "some_difficulty", meta_label: "neutral_face", helper: nil},
        {value: 2, label: "much_difficulty", meta_label: "frowny_face", helper: nil},
        {value: 3, label: "unable", meta_label: "sad_face", helper: nil},
      ]
    }],

    ### Get in and out of a car, bus, train, or airplane?
    enter_exit_vehicles: [{
      name: :enter_exit_vehicles,
      section: 7,
      kind: :select,
      inputs: [
        {value: 0, label: "no_difficulty", meta_label: "happy_face", helper: nil},
        {value: 1, label: "some_difficulty", meta_label: "neutral_face", helper: nil},
        {value: 2, label: "much_difficulty", meta_label: "frowny_face", helper: nil},
        {value: 3, label: "unable", meta_label: "sad_face", helper: nil},
      ]
    }],

    ### Walk two miles or three kilometers, if you wish?
    walk_two_miles: [{
      name: :walk_two_miles,
      section: 8,
      kind: :select,
      inputs: [
        {value: 0, label: "no_difficulty", meta_label: "happy_face", helper: nil},
        {value: 1, label: "some_difficulty", meta_label: "neutral_face", helper: nil},
        {value: 2, label: "much_difficulty", meta_label: "frowny_face", helper: nil},
        {value: 3, label: "unable", meta_label: "sad_face", helper: nil},
      ]
    }],

    ### Participate in recreational activities and sports as you would like, if you wish?
    play_sports: [{
      name: :play_sports,
      section: 9,
      kind: :select,
      inputs: [
        {value: 0, label: "no_difficulty", meta_label: "happy_face", helper: nil},
        {value: 1, label: "some_difficulty", meta_label: "neutral_face", helper: nil},
        {value: 2, label: "much_difficulty", meta_label: "frowny_face", helper: nil},
        {value: 3, label: "unable", meta_label: "sad_face", helper: nil},
      ]
    }],

    ### !!! RAPID3 FORM SAYS: questions K-M have been found to be informative, but are not scored formally
    ### !!! So they are commented out
    # ### Get a good night’s sleep?
    # sleep_well: [{
    #   name: :sleep_well,
    #   section: 10,
    #   kind: :select,
    #   inputs: [
    #     {value: 0, label: "no_difficulty", meta_label: "happy_face", helper: nil},
    #     {value: 1.1, label: "some_difficulty", meta_label: "neutral_face", helper: nil},
    #     {value: 2, label: "much_difficulty", meta_label: "frowny_face", helper: nil},
    #     {value: 3, label: "unable", meta_label: "sad_face", helper: nil},
    #   ]
    # }],
    #
    # ### Deal with feelings of anxiety or being nervous?
    # deal_with_anxiety: [{
    #   name: :deal_with_anxiety,
    #   section: 11,
    #   kind: :select,
    #   inputs: [
    #     {value: 0, label: "no_difficulty", meta_label: "happy_face", helper: nil},
    #     {value: 1, label: "some_difficulty", meta_label: "neutral_face", helper: nil},
    #     {value: 2, label: "much_difficulty", meta_label: "frowny_face", helper: nil},
    #     {value: 3, label: "unable", meta_label: "sad_face", helper: nil},
    #   ]
    # }],
    #
    # ### Deal with feelings of depression or feeling blue?
    # deal_with_depression: [{
    #   name: :deal_with_depression,
    #   section: 12,
    #   kind: :select,
    #   inputs: [
    #     {value: 0, label: "no_difficulty", meta_label: "happy_face", helper: nil},
    #     {value: 1, label: "some_difficulty", meta_label: "neutral_face", helper: nil},
    #     {value: 2, label: "much_difficulty", meta_label: "frowny_face", helper: nil},
    #     {value: 3, label: "unable", meta_label: "sad_face", helper: nil},
    #   ]
    # }],

    ### How much pain have you had because of your condition OVER THE PAST WEEK?
    pain_tolerance: [{
      name: :pain_tolerance,
      section: 10,
      kind: :range,
      step: 0.5,
      inputs: [
        {value: 0.0, label: "no_pain", meta_label: "happy_face", helper: nil},
        {value: 10.0, label: "maximum_pain", meta_label: "sad_face", helper: nil},
      ]
    }],

    ### Considering all the ways in which illness and health conditions may affect you at this time, please indicate below how you are doing:
    global_estimate: [{
      name: :global_estimate,
      section: 11,
      kind: :range,
      step: 0.5,
      inputs: [
        {value: 0.0, label: "very_well", meta_label: "happy_face", helper: nil},
        {value: 10.0, label: "very_poorly", meta_label: "sad_face", helper: nil},
      ]
    }],
  }

  RAPID3_SCORING_INDEX =  [0.3, 0.7, 1.0, 1.3, 1.7, 2.0, 2.3, 2.7, 3.0, 3.3, 3.7, 4.0, 4.3, 4.7, 5.0, 5.3, 5.7, 6.0, 6.3, 6.7, 7.0, 7.3, 7.7, 8.0, 8.3, 8.7, 9.0, 9.3, 9.7, 10]

  RAPID3_SCORE_COMPONENTS     = %i( functional_status pain_tolerance global_estimate )

  RAPID3_QUESTIONS            = RAPID3_DEFINITION.map{|k,v| v}.map{|questions| questions.map{|question| question[:name] }}.flatten
  RAPID3_FUNCTIONAL_QUESTIONS = (RAPID3_QUESTIONS - [:pain_tolerance, :global_estimate])

  included do |base_class|
    base_class.question_names = base_class.question_names | RAPID3_QUESTIONS

    validate :response_ranges
    def response_ranges
      ranges = [
        [:pain_tolerance, (0..10).step(0.5).to_a],
        [:global_estimate, (0..10).step(0.5).to_a],
      ]

      RAPID3_FUNCTIONAL_QUESTIONS.each{|q| ranges << [q, [*0..3] ]}

      ranges.each do |range|
        response = responses.select{|r| r.name.to_sym == range[0]}.first
        if response and not range[1].include?(response.value)
          # self.errors.add "responses.#{range[0]}", "Not within allowed values"
          self.errors.messages[:responses] ||= {}
          self.errors.messages[:responses][range[0]] = "Not within allowed values"
        end
      end

    end

  end

  def filled_rapid3_entry?
    (RAPID3_QUESTIONS - responses.reduce([]) {|accu, response| (accu << response.name.to_sym) if response.name}) == []
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
    score = RAPID3_FUNCTIONAL_QUESTIONS.reduce(0) do |sum, question_name|
      sum + self.send(question_name)
    end
    RAPID3_SCORING_INDEX[score-1]
  end

  def rapid3_pain_tolerance_score
    self.send(:pain_tolerance)
  end

  def rapid3_global_estimate_score
    self.send(:global_estimate)
  end


end