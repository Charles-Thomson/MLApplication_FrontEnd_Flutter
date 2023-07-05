import 'dart:convert';

var graphTestData = {
  "number_of_generations": "3",
  "max_steps": "10",
  "max_fitness": "10.0",
  "payloadData": {
    "gen_0": {
      "total_steps": "10",
      "total_fitness": "10.0",
      "lowest_fitness": "1.5",
      "shortest_path": "2",
      "longest_path": "10",
      "path": [
        1,
        2,
        3,
        4,
        10,
        16,
        22,
        28
      ],
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
      "lowest_fitness": "2.5",
      "shortest_path": "3",
      "longest_path": "10",
      "path": [
        5,
        11,
        16,
        21,
        26,
        25,
        24,
        30
      ],
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
      "lowest_fitness": "3.5",
      "shortest_path": "4",
      "longest_path": "10",
      "path": [
        35,
        34,
        27,
        21,
        15,
        9,
        3,
        2
      ],
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