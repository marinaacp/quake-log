This project was developed to parse log files from Quake 3 games. It does not support MISSIONPACK games.
Note that each game creates new players, as tracking players between games using names or IDs from the log file is not feasible.

Rails Version: 7.1

Ruby Version: 3.3.0

Database: PostgreSQL

Testing Framework: Minitest

# ENDPOINTS

## POST /api/games

Uploads a file to be parsed and save the data to the database.

In Postman, select "form-data" in the body, use the key "file", and upload the file. This endpoint supports text files (.log/.txt).

**Response**
```json
{
    "message": "File uploaded successfully. Processing in background."
}
```

## GET /api/games

Gets information from all games.

**Response**
```json
[
    {
        "id": 1, -- This is the game_id
        "gametype": "gt_ffa",
        "fraglimit": 20,
        "timelimit": 15,
        "capturelimit": 8,
        "game_data": {
            "total_kills": 0,
            "players": [
                "Isgalamido"
            ],
            "kills": {
                "Isgalamido": 0
            }
        }
    },
    {
        "id": 2,
        "gametype": "gt_ffa",
        "fraglimit": 20,
        "timelimit": 15,
        "capturelimit": 8,
        "game_data": {
            "total_kills": 11,
            "players": [
                "Isgalamido",
                "Mocinha"
            ],
            "kills": {
                "Isgalamido": 3,
                "Mocinha": 0
            }
        }
    },
    {
        "id": 3,
        "gametype": "gt_ffa",
        "fraglimit": 20,
        "timelimit": 15,
        "capturelimit": 8,
        "game_data": {
            "total_kills": 4,
            "players": [
                "Isgalamido",
                "Zeh",
                "Dono da Bola"
            ],
            "kills": {
                "Isgalamido": 1,
                "Zeh": 0,
                "Dono da Bola": 0
            }
        }
    }
]

```

## GET /api/games/:id

Gets information from a specific game.

**Response**
```json
{
    "id": 2,
    "gametype": "gt_ffa",
    "fraglimit": 20,
    "timelimit": 15,
    "capturelimit": 8,
    "game_data": {
        "total_kills": 11,
        "players": [
            "Isgalamido",
            "Mocinha"
        ],
        "kills": {
            "Isgalamido": 3,
            "Mocinha": 0
        }
    }
}
```

## GET /api/players

Gets information from all players.

**Response**
```json
[
    {
        "id": 1,
        "game_id": 1,
        "name": "Isgalamido",
        "model": "uriel",
        "submodel": "zael",
        "id_in_log": 2,
        "score": null,
        "created_at": "2024-08-19T10:58:01.139Z",
        "updated_at": "2024-08-19T10:58:01.156Z",
        "kills_data": {
            "kills": []
        }
    },
    {
        "id": 2,
        "game_id": 2,
        "name": "Isgalamido",
        "model": "uriel",
        "submodel": "zael",
        "id_in_log": 2,
        "score": null,
        "created_at": "2024-08-19T10:58:01.215Z",
        "updated_at": "2024-08-19T10:58:01.215Z",
        "kills_data": {
            "kills": [
                {
                    "id": 1,
                    "killer_id": null,
                    "victim_id": 2,
                    "type_death": "mod_trigger_hurt",
                    "is_world_death": true
                },
                {
                    "id": 2,
                    "killer_id": null,
                    "victim_id": 2,
                    "type_death": "mod_trigger_hurt",
                    "is_world_death": true
                },
                {
                    "id": 3,
                    "killer_id": null,
                    "victim_id": 2,
                    "type_death": "mod_trigger_hurt",
                    "is_world_death": true
                },
                {
                    "id": 5,
                    "killer_id": 2,
                    "victim_id": 2,
                    "type_death": "mod_rocket_splash",
                    "is_world_death": false
                },
                {
                    "id": 6,
                    "killer_id": 2,
                    "victim_id": 2,
                    "type_death": "mod_rocket_splash",
                    "is_world_death": false
                },
                {
                    "id": 7,
                    "killer_id": null,
                    "victim_id": 2,
                    "type_death": "mod_trigger_hurt",
                    "is_world_death": true
                },
                {
                    "id": 8,
                    "killer_id": null,
                    "victim_id": 2,
                    "type_death": "mod_trigger_hurt",
                    "is_world_death": true
                },
                {
                    "id": 9,
                    "killer_id": null,
                    "victim_id": 2,
                    "type_death": "mod_trigger_hurt",
                    "is_world_death": true
                },
                {
                    "id": 10,
                    "killer_id": null,
                    "victim_id": 2,
                    "type_death": "mod_falling",
                    "is_world_death": true
                },
                {
                    "id": 11,
                    "killer_id": null,
                    "victim_id": 2,
                    "type_death": "mod_trigger_hurt",
                    "is_world_death": true
                }
            ]
        }
    },
    {
        "id": 3,
        "game_id": 2,
        "name": "Mocinha",
        "model": "sarge",
        "submodel": null,
        "id_in_log": 3,
        "score": null,
        "created_at": "2024-08-19T10:58:01.353Z",
        "updated_at": "2024-08-19T10:58:01.362Z",
        "kills_data": {
            "kills": [
                {
                    "id": 4,
                    "killer_id": 2,
                    "victim_id": 3,
                    "type_death": "mod_rocket_splash",
                    "is_world_death": false
                }
            ]
        }
    }
]
```

## GET /api/players/:id

Gets information from a specific player.

**Response**
```json
{
    "id": 7,
    "game_id": 4,
    "name": "Dono da Bola",
    "model": "sarge",
    "submodel": null,
    "id_in_log": 2,
    "score": 5,
    "created_at": "2024-08-19T10:58:01.797Z",
    "updated_at": "2024-08-19T10:58:03.583Z",
    "kills_data": {
        "kills": [
            {
                "id": 17,
                "killer_id": null,
                "victim_id": 7,
                "type_death": "mod_falling",
                "is_world_death": true
            },
            {
                "id": 20,
                "killer_id": 8,
                "victim_id": 7,
                "type_death": "mod_railgun",
                "is_world_death": false
            },
            {
                "id": 22,
                "killer_id": 8,
                "victim_id": 7,
                "type_death": "mod_railgun",
                "is_world_death": false
            },
            {
                "id": 26,
                "killer_id": 8,
                "victim_id": 7,
                "type_death": "mod_rocket",
                "is_world_death": false
            },
            {
                "id": 28,
                "killer_id": 9,
                "victim_id": 7,
                "type_death": "mod_rocket",
                "is_world_death": false
            },
            {
                "id": 32,
                "killer_id": null,
                "victim_id": 7,
                "type_death": "mod_falling",
                "is_world_death": true
            },
            {
                "id": 34,
                "killer_id": 9,
                "victim_id": 7,
                "type_death": "mod_rocket",
                "is_world_death": false
            },
            {
                "id": 38,
                "killer_id": 9,
                "victim_id": 7,
                "type_death": "mod_rocket_splash",
                "is_world_death": false
            },
            {
                "id": 43,
                "killer_id": 7,
                "victim_id": 7,
                "type_death": "mod_rocket_splash",
                "is_world_death": false
            },
            {
                "id": 49,
                "killer_id": 9,
                "victim_id": 7,
                "type_death": "mod_rocket_splash",
                "is_world_death": false
            },
            {
                "id": 51,
                "killer_id": 8,
                "victim_id": 7,
                "type_death": "mod_rocket_splash",
                "is_world_death": false
            },
            {
                "id": 54,
                "killer_id": 10,
                "victim_id": 7,
                "type_death": "mod_rocket_splash",
                "is_world_death": false
            },
            {
                "id": 57,
                "killer_id": null,
                "victim_id": 7,
                "type_death": "mod_trigger_hurt",
                "is_world_death": true
            },
            {
                "id": 59,
                "killer_id": null,
                "victim_id": 7,
                "type_death": "mod_trigger_hurt",
                "is_world_death": true
            },
            {
                "id": 64,
                "killer_id": 7,
                "victim_id": 7,
                "type_death": "mod_rocket_splash",
                "is_world_death": false
            },
            {
                "id": 66,
                "killer_id": null,
                "victim_id": 7,
                "type_death": "mod_trigger_hurt",
                "is_world_death": true
            },
            {
                "id": 68,
                "killer_id": 9,
                "victim_id": 7,
                "type_death": "mod_rocket",
                "is_world_death": false
            },
            {
                "id": 70,
                "killer_id": 9,
                "victim_id": 7,
                "type_death": "mod_rocket_splash",
                "is_world_death": false
            },
            {
                "id": 71,
                "killer_id": 7,
                "victim_id": 7,
                "type_death": "mod_rocket_splash",
                "is_world_death": false
            },
            {
                "id": 74,
                "killer_id": null,
                "victim_id": 7,
                "type_death": "mod_falling",
                "is_world_death": true
            },
            {
                "id": 76,
                "killer_id": 10,
                "victim_id": 7,
                "type_death": "mod_rocket",
                "is_world_death": false
            },
            {
                "id": 82,
                "killer_id": 7,
                "victim_id": 7,
                "type_death": "mod_rocket_splash",
                "is_world_death": false
            },
            {
                "id": 88,
                "killer_id": 8,
                "victim_id": 7,
                "type_death": "mod_rocket_splash",
                "is_world_death": false
            },
            {
                "id": 92,
                "killer_id": null,
                "victim_id": 7,
                "type_death": "mod_falling",
                "is_world_death": true
            },
            {
                "id": 93,
                "killer_id": 8,
                "victim_id": 7,
                "type_death": "mod_machinegun",
                "is_world_death": false
            },
            {
                "id": 95,
                "killer_id": 8,
                "victim_id": 7,
                "type_death": "mod_shotgun",
                "is_world_death": false
            },
            {
                "id": 99,
                "killer_id": 10,
                "victim_id": 7,
                "type_death": "mod_rocket_splash",
                "is_world_death": false
            },
            {
                "id": 102,
                "killer_id": 8,
                "victim_id": 7,
                "type_death": "mod_rocket",
                "is_world_death": false
            },
            {
                "id": 110,
                "killer_id": 10,
                "victim_id": 7,
                "type_death": "mod_rocket_splash",
                "is_world_death": false
            },
            {
                "id": 115,
                "killer_id": 8,
                "victim_id": 7,
                "type_death": "mod_rocket_splash",
                "is_world_death": false
            },
            {
                "id": 118,
                "killer_id": 9,
                "victim_id": 7,
                "type_death": "mod_rocket_splash",
                "is_world_death": false
            }
        ]
    }
}
```

## GET /api/kills-by-means

Retrieves all deaths from all games and groups them by the mode of death.

**Response**
```json
{
    "game-1": {
        "kills_by_means": {}
    },
    "game-2": {
        "kills_by_means": {
            "mod_falling": 1,
            "mod_rocket_splash": 3,
            "mod_trigger_hurt": 7
        }
    },
    "game-3": {
        "kills_by_means": {
            "mod_falling": 1,
            "mod_rocket": 1,
            "mod_trigger_hurt": 2
        }
    },
    "game-4": {
        "kills_by_means": {
            "mod_trigger_hurt": 9,
            "mod_falling": 11,
            "mod_rocket_splash": 51,
            "mod_railgun": 8,
            "mod_shotgun": 2,
            "mod_rocket": 20,
            "mod_machinegun": 4
        }
    }
}
```
