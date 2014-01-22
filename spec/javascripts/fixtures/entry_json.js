window.entry_json = JSON.stringify({
inputs: [
{
id: 113,
value: 0,
label: "none",
meta_label: "happy_face",
helper: null
},
{
id: 114,
value: 1,
label: "mild",
meta_label: "neutral_face",
helper: null
},
{
id: 115,
value: 2,
label: "moderate",
meta_label: "frowny_face",
helper: null
},
{
id: 116,
value: 3,
label: "severe",
meta_label: "sad_face",
helper: null
},
{
id: 117,
value: 0,
label: "well",
meta_label: "happy_face",
helper: null
},
{
id: 118,
value: 1,
label: "below_par",
meta_label: "neutral_face",
helper: null
},
{
id: 119,
value: 2,
label: "poor",
meta_label: "frowny_face",
helper: null
},
{
id: 120,
value: 3,
label: "very_poor",
meta_label: "sad_face",
helper: null
},
{
id: 121,
value: 4,
label: "terrible",
meta_label: "terrible_face",
helper: null
},
{
id: 122,
value: 0,
label: "none",
meta_label: null,
helper: null
},
{
id: 123,
value: 3,
label: "questionable",
meta_label: null,
helper: null
},
{
id: 124,
value: 5,
label: "present",
meta_label: null,
helper: null
},
{
id: 125,
value: 0,
label: null,
meta_label: null,
helper: "stools_daily"
},
{
id: 126,
value: 0,
label: null,
meta_label: null,
helper: "hematocrit_without_decimal"
},
{
id: 127,
value: 0,
label: null,
meta_label: null,
helper: "current_weight"
},
{
id: 128,
value: 0,
label: null,
meta_label: null,
helper: "typical_weight"
}
],
entry: {
id: "706327d229a056f70603d9b1b67d5096",
date: "2014-01-22",
scores: [
{
id: "cdai_706327d229a056f70603d9b1b67d5096",
name: "cdai",
value: 364
}
],
questions: [
{
id: 96,
catalog: "cdai",
name: "ab_pain",
localized_name: "",
kind: "select",
group: null,
section: 1,
input_ids: [
113,
114,
115,
116
]
},
{
id: 97,
catalog: "cdai",
name: "general",
localized_name: "",
kind: "select",
group: null,
section: 2,
input_ids: [
117,
118,
119,
120,
121
]
},
{
id: 98,
catalog: "cdai",
name: "mass",
localized_name: "",
kind: "select",
group: null,
section: 3,
input_ids: [
122,
123,
124
]
},
{
id: 99,
catalog: "cdai",
name: "stools",
localized_name: "",
kind: "number",
group: null,
section: 4,
input_ids: [
125
]
},
{
id: 100,
catalog: "cdai",
name: "hematocrit",
localized_name: "Hematocrit level",
kind: "number",
group: null,
section: 5,
input_ids: [
126
]
},
{
id: 101,
catalog: "cdai",
name: "weight_current",
localized_name: "",
kind: "number",
group: null,
section: 6,
input_ids: [
127
]
},
{
id: 102,
catalog: "cdai",
name: "weight_typical",
localized_name: "",
kind: "number",
group: null,
section: 7,
input_ids: [
128
]
},
{
id: 103,
catalog: "cdai",
name: "opiates",
localized_name: "",
kind: "checkbox",
group: "complications",
section: 8,
input_ids: [ ]
},
{
id: 104,
catalog: "cdai",
name: "complication_arthritis",
localized_name: "",
kind: "checkbox",
group: "complications",
section: 8,
input_ids: [ ]
},
{
id: 105,
catalog: "cdai",
name: "complication_iritis",
localized_name: "",
kind: "checkbox",
group: "complications",
section: 8,
input_ids: [ ]
},
{
id: 106,
catalog: "cdai",
name: "complication_erythema",
localized_name: "",
kind: "checkbox",
group: "complications",
section: 8,
input_ids: [ ]
},
{
id: 107,
catalog: "cdai",
name: "complication_fever",
localized_name: "",
kind: "checkbox",
group: "complications",
section: 8,
input_ids: [ ]
},
{
id: 108,
catalog: "cdai",
name: "complication_fistula",
localized_name: "",
kind: "checkbox",
group: "complications",
section: 8,
input_ids: [ ]
},
{
id: 109,
catalog: "cdai",
name: "complication_other_fistula",
localized_name: "",
kind: "checkbox",
group: "complications",
section: 8,
input_ids: [ ]
}
],
responses: [
{
id: "weight_typical_706327d229a056f70603d9b1b67d5096",
name: "weight_typical",
value: 140
},
{
id: "stools_706327d229a056f70603d9b1b67d5096",
name: "stools",
value: 2
},
{
id: "ab_pain_706327d229a056f70603d9b1b67d5096",
name: "ab_pain",
value: 3
},
{
id: "general_706327d229a056f70603d9b1b67d5096",
name: "general",
value: 2
},
{
id: "complication_arthritis_706327d229a056f70603d9b1b67d5096",
name: "complication_arthritis",
value: 1
},
{
id: "complication_iritis_706327d229a056f70603d9b1b67d5096",
name: "complication_iritis",
value: 0
},
{
id: "complication_erythema_706327d229a056f70603d9b1b67d5096",
name: "complication_erythema",
value: 0
},
{
id: "complication_fistula_706327d229a056f70603d9b1b67d5096",
name: "complication_fistula",
value: 0
},
{
id: "complication_fever_706327d229a056f70603d9b1b67d5096",
name: "complication_fever",
value: 1
},
{
id: "complication_other_fistula_706327d229a056f70603d9b1b67d5096",
name: "complication_other_fistula",
value: 0
},
{
id: "opiates_706327d229a056f70603d9b1b67d5096",
name: "opiates",
value: 0
},
{
id: "mass_706327d229a056f70603d9b1b67d5096",
name: "mass",
value: 5
},
{
id: "hematocrit_706327d229a056f70603d9b1b67d5096",
name: "hematocrit",
value: 40
},
{
id: "weight_current_706327d229a056f70603d9b1b67d5096",
name: "weight_current",
value: 140
}
]
}
}
)