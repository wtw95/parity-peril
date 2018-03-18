# parity-peril
_Parity Peril_ is a game designed for the second project of one CS108/Art108 course. It is a digital recreation of the first project, a board game of the same name.
## Design Document
### Description
This is a two player (or one with AI) game where players control military units of opposing sides on a grid (tile-based game). The goal is to either capture a majority (5) of bases (called holdings) or to remove all the opponent's units from the grid.

### Game Objects
There is the grid, which is filled with tiled art (terrain) and establishes discrete movement. There are also (initially neutral) holdings on the grid. These may be changed to player-controlled holdings by conquest, and changed back by respawning (levying) units. Finally, there are both player-controlled units and opponent-controlled units, which move, battle, capture holdings.

### Sounds
There may be a couple different themes, some sound effects, and voicing for unit actions.

### Controls
The player controls a grid cursor to select objects on tiles of the grid. Units will have the option to move, attack, and capture. Bases have the option of levying troops.

### Game Flow
The game begins with one particular side's turn (always). S/he may move the cursor to use any number of actions among his/her units in any order. Then the player will press an end of turn button to pass the turn to the opponent.

### Levels
Currently, there is only one level planned, but players may find replayability by selecting the other side or trying to achieve the other victory. Future levels could be possible.
