"""
This file contains the configuration for the event system.
"""

EVENT_TYPE_NAMES = [
    "steal",
    "kill",
    "spot",
    "save",
    "rescue",
    "defend",
    "attack",
    "destroy",
]


EVENT_TYPES = {
    "steal": {
        "text": "stole",
        "preposition": "from",
    },
    "kill": {
        "text": "killed",
        "preposition": "",
    },
    "spot": {
        "text": "spotted",
        "preposition": "",
    },
    "save": {
        "text": "saved",
        "preposition": "",
    },
    "rescue": {
        "text": "rescued",
        "preposition": "",
    },
    "defend": {
        "text": "defended",
        "preposition": "",
    },
    "attack": {
        "text": "attacked",
        "preposition": "",
    },
    "destroy": {
        "text": "destroyed",
        "preposition": "",
    },
    "start_game": {
        "text": "started",
        "preposition": "",
    },
}
