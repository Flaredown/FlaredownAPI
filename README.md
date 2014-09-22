CDAI.me
==========

A web tool for tracking your CDAI.

### Status

[![Coverage Status](https://coveralls.io/repos/lmerriam/CDAI/badge.png)](https://coveralls.io/r/lmerriam/CDAI)
[![Build Status](https://travis-ci.org/lmerriam/CDAI.png)](https://travis-ci.org/lmerriam/CDAI)
[![Dependency Status](https://gemnasium.com/lmerriam/CDAI.png)](https://gemnasium.com/lmerriam/CDAI)


### API Examples

Authenticate with `user_email` and `user_token` as additional params: `user_email=test@test.com&user_token=abc123`

- Login, returns `User` with `authentication_token` for further API calls

		curl "<domain>/api/v1/users/sign_in?api_v1_user[email]=test@test.com&api_v1_user[password]=testing123"

- Current User (response subject to change)

		curl "<domain>/api/v1/current_user?user_email=test@test.com&user_token=abc123"

- Get entry

		curl "<domain>/api/v1/entries/xyz789?user_email=test@test.com&user_token=abc123"

- New entry, returns `Entry`

		curl "<domain>/api/v1/entries" --data "entry[catalogs][]=cdai&user_email=test@test.com&user_token=abc123"
			
- Update (PUT) entry with single response (JSON encoded), returns `Entry.id`

		curl "<domain>/api/v1/entries/xyz789" -X PUT --data "entry={\"responses\":[{\"name\":\"ab_pain\",\"value\":3}]}&user_email=test@test.com&user_token=abc123"
			
- Example entry response, for CDAI with response for "ab_pain"

		{
		    "entry": {
		        "date": "2014-09-22",
		        "id": "xyz789",
		        "questions": [
		            {
		                "catalog": "cdai",
		                "group": null,
		                "id": 57,
		                "input_ids": [
		                    65,
		                    66,
		                    67,
		                    68
		                ],
		                "kind": "select",
		                "localized_name": "What is your level of abdominal pain?",
		                "name": "ab_pain",
		                "section": 1
		            },
		            {
		                "catalog": "cdai",
		                "group": null,
		                "id": 58,
		                "input_ids": [
		                    69,
		                    70,
		                    71,
		                    72,
		                    73
		                ],
		                "kind": "select",
		                "localized_name": "What is your general level of pain?",
		                "name": "general",
		                "section": 2
		            },
		            {
		                "catalog": "cdai",
		                "group": null,
		                "id": 59,
		                "input_ids": [
		                    74,
		                    75,
		                    76
		                ],
		                "kind": "select",
		                "localized_name": "Do you have an abdominal mass?",
		                "name": "mass",
		                "section": 3
		            },
		            {
		                "catalog": "cdai",
		                "group": null,
		                "id": 60,
		                "input_ids": [
		                    77
		                ],
		                "kind": "number",
		                "localized_name": "How many soft/liquid stools did you pass today?",
		                "name": "stools",
		                "section": 4
		            },
		            {
		                "catalog": "cdai",
		                "group": null,
		                "id": 61,
		                "input_ids": [
		                    78
		                ],
		                "kind": "number",
		                "localized_name": "Hematocrit level (optional)",
		                "name": "hematocrit",
		                "section": 5
		            },
		            {
		                "catalog": "cdai",
		                "group": null,
		                "id": 62,
		                "input_ids": [
		                    79
		                ],
		                "kind": "number",
		                "localized_name": "What is your current weight?",
		                "name": "weight_current",
		                "section": 6
		            },
		            {
		                "catalog": "cdai",
		                "group": null,
		                "id": 63,
		                "input_ids": [
		                    80
		                ],
		                "kind": "number",
		                "localized_name": "What is your typical weight?",
		                "name": "weight_typical",
		                "section": 7
		            },
		            {
		                "catalog": "cdai",
		                "group": "complications",
		                "id": 64,
		                "input_ids": [],
		                "kind": "checkbox",
		                "localized_name": "Are you taking lomotil or opiates for diarrhea?",
		                "name": "opiates",
		                "section": 8
		            },
		            {
		                "catalog": "cdai",
		                "group": "complications",
		                "id": 65,
		                "input_ids": [],
		                "kind": "checkbox",
		                "localized_name": "Arthritis",
		                "name": "complication_arthritis",
		                "section": 8
		            },
		            {
		                "catalog": "cdai",
		                "group": "complications",
		                "id": 66,
		                "input_ids": [],
		                "kind": "checkbox",
		                "localized_name": "Iritis or uveitis",
		                "name": "complication_iritis",
		                "section": 8
		            },
		            {
		                "catalog": "cdai",
		                "group": "complications",
		                "id": 67,
		                "input_ids": [],
		                "kind": "checkbox",
		                "localized_name": "Erythema nodosum, pyoderma gangrenosum, or aphthous ulcers",
		                "name": "complication_erythema",
		                "section": 8
		            },
		            {
		                "catalog": "cdai",
		                "group": "complications",
		                "id": 68,
		                "input_ids": [],
		                "kind": "checkbox",
		                "localized_name": "Fever",
		                "name": "complication_fever",
		                "section": 8
		            },
		            {
		                "catalog": "cdai",
		                "group": "complications",
		                "id": 69,
		                "input_ids": [],
		                "kind": "checkbox",
		                "localized_name": "Anal fistula, fissure, or abcess",
		                "name": "complication_fistula",
		                "section": 8
		            },
		            {
		                "catalog": "cdai",
		                "group": "complications",
		                "id": 70,
		                "input_ids": [],
		                "kind": "checkbox",
		                "localized_name": "Other fistula",
		                "name": "complication_other_fistula",
		                "section": 8
		            }
		        ],
		        "responses": [
		            {
		                "id": "ab_pain_d07b851b0f241f707dafa7c3619ad12a",
		                "name": "ab_pain",
		                "value": 3
		            }
		        ],
		        "scores": [
		            {
		                "id": "cdai_d07b851b0f241f707dafa7c3619ad12a",
		                "name": "cdai",
		                "value": -1
		            }
		        ]
		    },
		    "inputs": [
		        {
		            "helper": null,
		            "id": 65,
		            "label": "none",
		            "meta_label": "happy_face",
		            "value": 0
		        },
		        {
		            "helper": null,
		            "id": 66,
		            "label": "mild",
		            "meta_label": "neutral_face",
		            "value": 1
		        },
		        {
		            "helper": null,
		            "id": 67,
		            "label": "moderate",
		            "meta_label": "frowny_face",
		            "value": 2
		        },
		        {
		            "helper": null,
		            "id": 68,
		            "label": "severe",
		            "meta_label": "sad_face",
		            "value": 3
		        },
		        {
		            "helper": null,
		            "id": 69,
		            "label": "well",
		            "meta_label": "happy_face",
		            "value": 0
		        },
		        {
		            "helper": null,
		            "id": 70,
		            "label": "below_par",
		            "meta_label": "neutral_face",
		            "value": 1
		        },
		        {
		            "helper": null,
		            "id": 71,
		            "label": "poor",
		            "meta_label": "frowny_face",
		            "value": 2
		        },
		        {
		            "helper": null,
		            "id": 72,
		            "label": "very_poor",
		            "meta_label": "sad_face",
		            "value": 3
		        },
		        {
		            "helper": null,
		            "id": 73,
		            "label": "terrible",
		            "meta_label": "terrible_face",
		            "value": 4
		        },
		        {
		            "helper": null,
		            "id": 74,
		            "label": "none",
		            "meta_label": null,
		            "value": 0
		        },
		        {
		            "helper": null,
		            "id": 75,
		            "label": "questionable",
		            "meta_label": null,
		            "value": 2
		        },
		        {
		            "helper": null,
		            "id": 76,
		            "label": "present",
		            "meta_label": null,
		            "value": 5
		        },
		        {
		            "helper": "stools_daily",
		            "id": 77,
		            "label": null,
		            "meta_label": null,
		            "value": 0
		        },
		        {
		            "helper": "hematocrit_without_decimal",
		            "id": 78,
		            "label": null,
		            "meta_label": null,
		            "value": 0
		        },
		        {
		            "helper": "current_weight",
		            "id": 79,
		            "label": null,
		            "meta_label": null,
		            "value": 0
		        },
		        {
		            "helper": "typical_weight",
		            "id": 80,
		            "label": null,
		            "meta_label": null,
		            "value": 0
		        }
		    ]
		}
		