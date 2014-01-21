App.Entry.FIXTURES = [
  id: "0fe7a3b3e3d8eaf063bd82f77502e649"
  date: "2014-01-08"
]

# App.QuestionOption.FIXTURES = [
#     value: 0
#     label: "well"
#     meta_label: "happy_face"
#     helper: null
#     id: "general_0"
#   ,
#     value: 1
#     label: "below_par"
#     meta_label: "neutral_face"
#     helper: null
#     id: "general_1"
#   ,
#     value: 2
#     label: "poor"
#     meta_label: "frowny_face"
#     helper: null
#     id: "general_2"
#   ,
#     value: 3
#     label: "very_poor"
#     meta_label: "sad_face"
#     helper: null
#     id: "general_3"
#   ,
#     value: 4
#     label: "terrible"
#     meta_label: "terrible_face"
#     helper: null
#     id: "general_4"
#   ,
#     value: 0
#     label: null
#     meta_label: null
#     helper: "typical_weight"
#     id: "weight_typical_0"
#   ]

App.Question.FIXTURES = [
  id: "1"
  catalog: "cdai"
  name: "ab_pain"
  localized_name: ""
  kind: "select"
  group: null
  section: 1
,
  id: "2"
  catalog: "cdai"
  name: "general"
  localized_name: ""
  kind: "select"
  group: null
  section: 2
  input_options: 
,
  id: "3"
  catalog: "cdai"
  name: "mass"
  localized_name: ""
  kind: "select"
  group: null
  section: 3
  input_options: [
    value: 0
    label: "none"
    meta_label: "happy_face"
    helper: null
    id: "mass_0"
  ,
    value: 3
    label: "questionable"
    meta_label: null
    helper: null
    id: "mass_3"
  ,
    value: 5
    label: "present"
    meta_label: null
    helper: null
    id: "mass_5"
  ]
,
  id: "4"
  catalog: "cdai"
  name: "stools"
  localized_name: ""
  kind: "number"
  group: null
  section: 4
  input_options: [
    value: 0
    label: null
    meta_label: null
    helper: "stools_weekly"
    id: "stools_0"
  ]
,
  id: "5"
  catalog: "cdai"
  name: "hematocrit"
  localized_name: "Hematocrit level"
  kind: "number"
  group: null
  section: 5
  input_options: [
    value: 0
    label: null
    meta_label: null
    helper: "hematocrit_without_decimal"
    id: "hematocrit_0"
  ]
,
  id: "6"
  catalog: "cdai"
  name: "weight_current"
  localized_name: ""
  kind: "number"
  group: null
  section: 6
  input_options: [
    value: 0
    label: null
    meta_label: null
    helper: "current_weight"
    id: "weight_current_0"
  ]
,
  id: "7"
  catalog: "cdai"
  name: "weight_typical"
  localized_name: ""
  kind: "number"
  group: null
  section: 7
  input_options: [
    
  ]
,
  id: "8"
  catalog: "cdai"
  name: "opiates"
  localized_name: ""
  kind: "checkbox"
  group: "complications"
  section: 8
  input_options: null
,
  id: "9"
  catalog: "cdai"
  name: "complication_arthritis"
  localized_name: ""
  kind: "checkbox"
  group: "complications"
  section: 8
  input_options: null
,
  id: "10"
  catalog: "cdai"
  name: "complication_iritis"
  localized_name: ""
  kind: "checkbox"
  group: "complications"
  section: 8
  input_options: null
,
  id: "11"
  catalog: "cdai"
  name: "complication_erythema"
  localized_name: ""
  kind: "checkbox"
  group: "complications"
  section: 8
  input_options: null
,
  id: "12"
  catalog: "cdai"
  name: "complication_fever"
  localized_name: ""
  kind: "checkbox"
  group: "complications"
  section: 8
  input_options: null
,
  id: "13"
  catalog: "cdai"
  name: "complication_fistula"
  localized_name: ""
  kind: "checkbox"
  group: "complications"
  section: 8
  input_options: null
,
  id: "14"
  catalog: "cdai"
  name: "complication_other_fistula"
  localized_name: ""
  kind: "checkbox"
  group: "complications"
  section: 8
  input_options: null
]
App.Response.FIXTURES = [
  id: "weight_typical_0fe7a3b3e3d8eaf063bd82f77502e649"
  name: "weight_typical"
  value: 140
,
  id: "stools_0fe7a3b3e3d8eaf063bd82f77502e649"
  name: "stools"
  value: 2
,
  id: "ab_pain_0fe7a3b3e3d8eaf063bd82f77502e649"
  name: "ab_pain"
  value: 2
,
  id: "general_0fe7a3b3e3d8eaf063bd82f77502e649"
  name: "general"
  value: 4
,
  id: "complication_arthritis_0fe7a3b3e3d8eaf063bd82f77502e649"
  name: "complication_arthritis"
  value: true
,
  id: "complication_iritis_0fe7a3b3e3d8eaf063bd82f77502e649"
  name: "complication_iritis"
  value: false
,
  id: "complication_erythema_0fe7a3b3e3d8eaf063bd82f77502e649"
  name: "complication_erythema"
  value: false
,
  id: "complication_fistula_0fe7a3b3e3d8eaf063bd82f77502e649"
  name: "complication_fistula"
  value: false
,
  id: "complication_fever_0fe7a3b3e3d8eaf063bd82f77502e649"
  name: "complication_fever"
  value: true
,
  id: "complication_other_fistula_0fe7a3b3e3d8eaf063bd82f77502e649"
  name: "complication_other_fistula"
  value: false
,
  id: "opiates_0fe7a3b3e3d8eaf063bd82f77502e649"
  name: "opiates"
  value: false
,
  id: "mass_0fe7a3b3e3d8eaf063bd82f77502e649"
  name: "mass"
  value: 0
,
  id: "hematocrit_0fe7a3b3e3d8eaf063bd82f77502e649"
  name: "hematocrit"
  value: 38
,
  id: "weight_current_0fe7a3b3e3d8eaf063bd82f77502e649"
  name: "weight_current"
  value: 140
]