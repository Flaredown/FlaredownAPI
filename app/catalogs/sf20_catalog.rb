module Sf20Catalog
  extend ActiveSupport::Concern

  DEFINITION = [

    ### SECTION A

    ### In general, would you say your health is:
    [{
      # 1 Excellent
      # 2 Very good
      # 3 Good
      # 4 Fair
      # 5 Poor

      name: :general_health,
      kind: :select,
      inputs: [
        {value: 1, label: "excellent", meta_label: "", helper: nil},
        {value: 2, label: "very_good", meta_label: "", helper: nil},
        {value: 3, label: "good", meta_label: "", helper: nil},
        {value: 4, label: "fair", meta_label: "", helper: nil},
        {value: 5, label: "poor", meta_label: "", helper: nil},
      ]
    }],


    ### SECTION B
    ### For how long (if at all) has your *health limited you* in *each* of the following activities?

    ### The kinds or amounts of *vigorous* activities you can do, like lifting heavy objects, running or participating in strenuous sports.
    [{
      # 1 Limited for more than 3 months
      # 2 Limited for 3 months or less
      # 3 Not limited at all

      name: :limit_vigorous_activity,
      kind: :select,
      inputs: [
        {value: 1, label: "limited_more_than_3_months", meta_label: "", helper: nil},
        {value: 2, label: "limited_3_months_or_less", meta_label: "", helper: nil},
        {value: 3, label: "not_limited_at_all", meta_label: "", helper: nil},
      ]
    }],

    ### The kinds or amounts of <strong>moderate</strong> activities you can do, like moving a table, carrying groceries or bowling.
    [{
      # 1 Limited for more than 3 months
      # 2 Limited for 3 months or less
      # 3 Not limited at all

      name: :limit_moderate_activity,
      kind: :select,
      inputs: [
        {value: 1, label: "limited_more_than_3_months", meta_label: "", helper: nil},
        {value: 2, label: "limited_3_months_or_less", meta_label: "", helper: nil},
        {value: 3, label: "not_limited_at_all", meta_label: "", helper: nil},
      ]
    }],


    ### Walking uphill or climbing a few flights of stairs.
    [{
      # 1 Limited for more than 3 months
      # 2 Limited for 3 months or less
      # 3 Not limited at all

      name: :limit_climbing_stairs,
      kind: :select,
      inputs: [
        {value: 1, label: "limited_more_than_3_months", meta_label: "", helper: nil},
        {value: 2, label: "limited_3_months_or_less", meta_label: "", helper: nil},
        {value: 3, label: "not_limited_at_all", meta_label: "", helper: nil},
      ]
    }],

    ### Bending, lifting, or stooping?
    [{
      # 1 Limited for more than 3 months
      # 2 Limited for 3 months or less
      # 3 Not limited at all

      name: :limit_bending,
      kind: :select,
      inputs: [
        {value: 1, label: "limited_more_than_3_months", meta_label: "", helper: nil},
        {value: 2, label: "limited_3_months_or_less", meta_label: "", helper: nil},
        {value: 3, label: "not_limited_at_all", meta_label: "", helper: nil},
      ]
    }],

    ### Walking one block?
    [{
      # 1 Limited for more than 3 months
      # 2 Limited for 3 months or less
      # 3 Not limited at all

      name: :limit_walking,
      kind: :select,
      inputs: [
        {value: 1, label: "limited_more_than_3_months", meta_label: "", helper: nil},
        {value: 2, label: "limited_3_months_or_less", meta_label: "", helper: nil},
        {value: 3, label: "not_limited_at_all", meta_label: "", helper: nil},
      ]
    }],

    ### Eating, dressing, bathing, or using the toilet?
    [{
      # 1 Limited for more than 3 months
      # 2 Limited for 3 months or less
      # 3 Not limited at all

      name: :limit_basic_activity,
      kind: :select,
      inputs: [
        {value: 1, label: "limited_more_than_3_months", meta_label: "", helper: nil},
        {value: 2, label: "limited_3_months_or_less", meta_label: "", helper: nil},
        {value: 3, label: "not_limited_at_all", meta_label: "", helper: nil},
      ]
    }],

    ### SECTION C
    ### How much *bodily* pain have you had *during the past 4 weeks*?

    [{
      # 1 None
      # 2 Very mild
      # 3 Mild
      # 4 Moderate
      # 5 Severe
      # 6 Very severe

      name: :bodily_pain,
      kind: :select,
      inputs: [
        {value: 1, label: "none", meta_label: "", helper: nil},
        {value: 2, label: "very_mild", meta_label: "", helper: nil},
        {value: 3, label: "mild", meta_label: "", helper: nil},
        {value: 4, label: "moderate", meta_label: "", helper: nil},
        {value: 5, label: "severe", meta_label: "", helper: nil},
        {value: 6, label: "very_severe", meta_label: "", helper: nil},
      ]
    }],

    ### SECTION D
    ### Does your health *keep* you from working at a job, doing work around the house, or going to school?
    [{
      # 1 Yes, for more than three months
      # 2 Yes, for three months or less
      # 3 No

      name: :prevent_working,
      kind: :select,
      inputs: [
        {value: 1, label: "yes_more_than_3_months", meta_label: "", helper: nil},
        {value: 2, label: "yes_3_months_or_less", meta_label: "", helper: nil},
        {value: 3, label: "no", meta_label: "", helper: nil},
      ]
    }],

    ### SECTION E
    ### Have you been unable to do *certain kinds or amounts* of work, housework, or schoolwork because of your health?
    [{
      # 1 Yes, for more than three months
      # 2 Yes, for three months or less
      # 3 No

      name: :prevent_certain_kinds_work,
      kind: :select,
      inputs: [
        {value: 1, label: "yes_more_than_3_months", meta_label: "", helper: nil},
        {value: 2, label: "yes_3_months_or_less", meta_label: "", helper: nil},
        {value: 3, label: "no", meta_label: "", helper: nil},
      ]
    }],

    ### SECTION F
    ### For *each* of the following questions, please mark the circle for the *one* answer that comes *closest* to the way you have been feeling *during the past month*.

    ### How much of the time, during the past month, has your *health limited your social activities* (like visiting with friends or close relatives)?
    [{
      # 1 All of the time
      # 2 Most of the time
      # 3 A good bit of the time
      # 4 Some of the time
      # 5 A little of the time
      # 6 None of the time

      name: :limit_social_activities,
      kind: :select,
      inputs: [
        {value: 1, label: "all_of_the_time", meta_label: "", helper: nil},
        {value: 2, label: "most_of_the_time", meta_label: "", helper: nil},
        {value: 3, label: "a_good_bit_of_the_time", meta_label: "", helper: nil},
        {value: 4, label: "some_of_the_time", meta_label: "", helper: nil},
        {value: 5, label: "a_little_of_the_time", meta_label: "", helper: nil},
        {value: 6, label: "none_of_the_time", meta_label: "", helper: nil},
      ]
    }],

    ### How much of the time, during the past month, have you been a <strong>very nervous person</strong>?
    [{
      # 1 All of the time
      # 2 Most of the time
      # 3 A good bit of the time
      # 4 Some of the time
      # 5 A little of the time
      # 6 None of the time

      name: :nervousness,
      kind: :select,
      inputs: [
        {value: 1, label: "all_of_the_time", meta_label: "", helper: nil},
        {value: 2, label: "most_of_the_time", meta_label: "", helper: nil},
        {value: 3, label: "a_good_bit_of_the_time", meta_label: "", helper: nil},
        {value: 4, label: "some_of_the_time", meta_label: "", helper: nil},
        {value: 5, label: "a_little_of_the_time", meta_label: "", helper: nil},
        {value: 6, label: "none_of_the_time", meta_label: "", helper: nil},
      ]
    }],

    ### During the past month, how much of the time have you felt <strong>calm and peaceful</strong>?
    [{
      # 1 All of the time
      # 2 Most of the time
      # 3 A good bit of the time
      # 4 Some of the time
      # 5 A little of the time
      # 6 None of the time

      name: :calmness,
      kind: :select,
      inputs: [
        {value: 1, label: "all_of_the_time", meta_label: "", helper: nil},
        {value: 2, label: "most_of_the_time", meta_label: "", helper: nil},
        {value: 3, label: "a_good_bit_of_the_time", meta_label: "", helper: nil},
        {value: 4, label: "some_of_the_time", meta_label: "", helper: nil},
        {value: 5, label: "a_little_of_the_time", meta_label: "", helper: nil},
        {value: 6, label: "none_of_the_time", meta_label: "", helper: nil},
      ]
    }],

    ### How much of the time, during the past month, have you felt <strong>downhearted and blue</strong>?
    [{
      # 1 All of the time
      # 2 Most of the time
      # 3 A good bit of the time
      # 4 Some of the time
      # 5 A little of the time
      # 6 None of the time

      name: :downheartedness,
      kind: :select,
      inputs: [
        {value: 1, label: "all_of_the_time", meta_label: "", helper: nil},
        {value: 2, label: "most_of_the_time", meta_label: "", helper: nil},
        {value: 3, label: "a_good_bit_of_the_time", meta_label: "", helper: nil},
        {value: 4, label: "some_of_the_time", meta_label: "", helper: nil},
        {value: 5, label: "a_little_of_the_time", meta_label: "", helper: nil},
        {value: 6, label: "none_of_the_time", meta_label: "", helper: nil},
      ]
    }],

    ### During the past month, how much of the time have you been a <strong>happy person</strong>?
    [{
      # 1 All of the time
      # 2 Most of the time
      # 3 A good bit of the time
      # 4 Some of the time
      # 5 A little of the time
      # 6 None of the time

      name: :happiness,
      kind: :select,
      inputs: [
        {value: 1, label: "all_of_the_time", meta_label: "", helper: nil},
        {value: 2, label: "most_of_the_time", meta_label: "", helper: nil},
        {value: 3, label: "a_good_bit_of_the_time", meta_label: "", helper: nil},
        {value: 4, label: "some_of_the_time", meta_label: "", helper: nil},
        {value: 5, label: "a_little_of_the_time", meta_label: "", helper: nil},
        {value: 6, label: "none_of_the_time", meta_label: "", helper: nil},
      ]
    }],

    ### How often, during the past month, have you felt so <strong>down in the dumps that nothing could cheer you up</strong>?
    [{
      # 1 All of the time
      # 2 Most of the time
      # 3 A good bit of the time
      # 4 Some of the time
      # 5 A little of the time
      # 6 None of the time

      name: :despair,
      kind: :select,
      inputs: [
        {value: 1, label: "all_of_the_time", meta_label: "", helper: nil},
        {value: 2, label: "most_of_the_time", meta_label: "", helper: nil},
        {value: 3, label: "a_good_bit_of_the_time", meta_label: "", helper: nil},
        {value: 4, label: "some_of_the_time", meta_label: "", helper: nil},
        {value: 5, label: "a_little_of_the_time", meta_label: "", helper: nil},
        {value: 6, label: "none_of_the_time", meta_label: "", helper: nil},
      ]
    }],

    ### SECTION G
    ### Please mark the circle that *best* describes whether *each* of the following statements is *true* or *false* for you.

    ### I am somewhat ill.
    [{
      # 1 Definitely true
      # 2 Mostly true
      # 3 Not sure
      # 4 Mostly false
      # 5 Definitely false

      name: :somewhat_ill,
      kind: :select,
      inputs: [
        {value: 1, label: "definitely_true", meta_label: "", helper: nil},
        {value: 2, label: "mostly_true", meta_label: "", helper: nil},
        {value: 3, label: "not_sure", meta_label: "", helper: nil},
        {value: 4, label: "mostly_false", meta_label: "", helper: nil},
        {value: 5, label: "definitely_false", meta_label: "", helper: nil},
      ]
    }],

    ### I am as healthy as anybody I know.
    [{
      # 1 Definitely true
      # 2 Mostly true
      # 3 Not sure
      # 4 Mostly false
      # 5 Definitely false

      name: :healthy_as_anybody,
      kind: :select,
      inputs: [
        {value: 1, label: "definitely_true", meta_label: "", helper: nil},
        {value: 2, label: "mostly_true", meta_label: "", helper: nil},
        {value: 3, label: "not_sure", meta_label: "", helper: nil},
        {value: 4, label: "mostly_false", meta_label: "", helper: nil},
        {value: 5, label: "definitely_false", meta_label: "", helper: nil},
      ]
    }],

    ### My health is excellent.
    [{
      # 1 Definitely true
      # 2 Mostly true
      # 3 Not sure
      # 4 Mostly false
      # 5 Definitely false

      name: :excellent_health,
      kind: :select,
      inputs: [
        {value: 1, label: "definitely_true", meta_label: "", helper: nil},
        {value: 2, label: "mostly_true", meta_label: "", helper: nil},
        {value: 3, label: "not_sure", meta_label: "", helper: nil},
        {value: 4, label: "mostly_false", meta_label: "", helper: nil},
        {value: 5, label: "definitely_false", meta_label: "", helper: nil},
      ]
    }],

    ### I have been feeling bad lately.
    [{
      # 1 Definitely true
      # 2 Mostly true
      # 3 Not sure
      # 4 Mostly false
      # 5 Definitely false

      name: :feeling_bad_lately,
      kind: :select,
      inputs: [
        {value: 1, label: "definitely_true", meta_label: "", helper: nil},
        {value: 2, label: "mostly_true", meta_label: "", helper: nil},
        {value: 3, label: "not_sure", meta_label: "", helper: nil},
        {value: 4, label: "mostly_false", meta_label: "", helper: nil},
        {value: 5, label: "definitely_false", meta_label: "", helper: nil},
      ]
    }],

  ]

  QUESTIONS  = %i( general_health limit_vigorous_activity limit_moderate_activity limit_climbing_stairs limit_bending limit_walking limit_basic_activity bodily_pain prevent_working prevent_certain_kinds_work limit_social_activities nervousness calmness downheartedness happiness despair somewhat_ill healthy_as_anybody excellent_health feeling_bad_lately )
  SCORE_COMPONENTS = %i( section_b )
  SCORE_COMPONENT_QUESTIONS = [1,6,3,3,3,3,3]
  QUESTIONS         = DEFINITION.map{|questions| questions.map{|question| question[:name] }}.flatten
  COMPLICATIONS     = DEFINITION[4].map{|question| question[:name] }.flatten

  included do |base_class|
    validate :sf20_response_ranges
    def sf20_response_ranges
      ranges = [
        [:general_health, [nil,*1..5]],
        [:limit_vigorous_activity, [nil,*1..3]],
        [:limit_moderate_activity, [nil,*1..3]],
        [:limit_climbing_stairs, [nil,*1..3]],
        [:limit_bending, [nil,*1..3]],
        [:limit_walking, [nil,*1..3]],
        [:limit_basic_activity, [nil,*1..3]],     
        [:bodily_pain, [nil,*1..6]],
        [:prevent_working, [nil,*1..3]],    
        [:prevent_certain_kinds_work, [nil,*1..3]],   
        [:limit_social_activities, [nil,*1..6]], 
        [:nervousness, [nil,*1..6]], 
        [:calmness, [nil,*1..6]], 
        [:downheartedness, [nil,*1..6]], 
        [:happiness, [nil,*1..6]], 
        [:despair, [nil,*1..6]], 
        [:somewhat_ill, [nil,*1..5]],
        [:healthy_as_anybody, [nil,*1..5]], 
        [:excellent_health, [nil,*1..5]], 
        [:feeling_bad_lately, [nil,*1..5]], 
      ]

      ranges.each do |range|
        response = sf20_responses.detect{|r| r.name.to_sym == range[0]}
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

  def sf20_responses
    responses.select{|r| r.catalog == "sf20"}
  end

  # def valid_hbi_entry?
  #   return false unless last_6_entries.count == 6
  #   !last_6_entries.map{|e| e.filled_hbi_entry?}.include?(false)
  # end
  def filled_sf20_entry?
    valid_responses = sf20_responses.reduce([]) do |accu, response|
      accu << response.name.to_sym if response.name and response.value.present?
      accu
    end
    (QUESTIONS-valid_responses) == []
  end

  def complete_sf20_entry?
    filled_sf20_entry?
  end

  # def setup_hbi_scoring
  # end

  def questions_for_section(section_name)
    questions = QUESTIONS
    SCORE_COMPONENT_QUESTIONS.reduce([]) do |memo,length|
      section = questions[0..length-1]
      memo << section
      questions = questions - section
      memo   
    end[('a'..'z').to_a.index(section_name)]
  end

  def sf20_section_b_score
    questions = questions_for_section("b")
    binding.pry
    avg = questions.reduce(0) do |sum, name|
      sum+self.send("sf20_#{name}")
    end / questions.length
    avg.round
  end

end