import 'dart:convert';

var graphTestData = {
  "number_of_generations": "3",
  "max_steps": "10",
  "max_fitness": "10.0",
  "payloadData": {
    "gen_0": {
      "total_steps": "10",
      "total_fitness": "10.0",
      "fitness_by_step":
      [0.0,
        1.2,
        2.4,
        2.6,
        3.8,
        4.5,
        5.0,
        5.5,
        6]
    },
    "gen_1": {
      "total_steps": "10",
      "total_fitness": "10.0",
      "fitness_by_step":
      [0.6,
        1.6,
        3.4,
        4.6,
        4.8,
        5.5,
        6.0,
        6.5,
        6]
    },
    "gen_2": {
      "total_steps": "10",
      "total_fitness": "10.0",
      "fitness_by_step":
      [0.6,
        1.6,
        3.4,
        4.6,
        4.8,
        5.5,
        6.0,
        6.5,
        6]
    },
  },
};

var jsonGraphTestData = json.encode(graphTestData);