Weekend Warriors
Primarily an experiment in game architecture, as I had been doing some reading on entity-component systems (ECS). I learned that it’s an extremely versatile framework that is great at decoupling data from code. However, not everything fits so neatly within this structure.

{picture of map screen 1}

## What I learned

### C# is extremely friendly

One of the most pleasant surprises of this project was that it took me little to no time to get up and running with C#. I had used the language a little before, but that was several years ago. I expected to hate Visual Studio coming from Vim and I can hardly believe how productive I felt using it. I just installed vim bindings and I was off. Building other projects usually “just worked,” which is practically a miracle.

### Entity-component systems are amazing, but not a panacea

As I said before, one of my main motivations behind working on this project was to see how a turn-based game using entity-component systems would turn out. Overall, I found the framework an excellent way to structure my ideas efficiently. The process of adding a feature was approximately this:

1. figure out what you want to accomplish,
2. put the necessary data into components,
3. and write or modify a system to process those components.

However, several concepts did not fit so neatly into this. Mainly, having an entity for every tile on a map is too costly, using components for commands is messy and wasteful, and having a system to deal with in-game time scheduling ended up being more of a pain in the neck than it was worth. Although, the last one was largely because of the ECS library I was using.

{picture of map screen 2}

### Keeping input logic separate from game logic is more difficult than it seems

One of the largest mistake I made in this project is not having a clear way to deal with user input from the beginning.

{picture of “read more” screen}

### Having a static “game state” object is not ideal
I even knew having a global, static “god object” was a mistake when I created it, but at the time I just wanted to move on and get things done. It ended up not being such an issue for my relatively small project, but by the end, I feel like it has just too many public properties for me to be comfortable.

```c#
public class GameState
{
    public int Seed;
    public IRandom Random { get; private set; }
    public EntityWorld EntityWorld;
    public TimeManager TimeManager;
    public MessageLog MessageLog;
    public Dungeon Dungeon;
    public Entity Player;
    public IScreen CurrentScreen;

    public enum InputMode
    {
        Standard,
        DropCommand
    }
    public InputMode CurrentInputMode;

    // ...
}
```

If I were to continue working on this project, I’m certain the class would only continue to grow. Most notably, having to include the `TimeManager`, `MessageLog`, and `Dungeon` objects could cause so many headaches down the line.

{picture of inventory screen}


## What I would do differently next time

### Write my own game loop (to have more control over the render/update threads)
According to performance analytics, rendering the screen made up a significant amount of the thread time. This is absolutely unacceptable, especially considering that the graphics could theoretically be run in a terminal.
### Enforce an ECS-VP (as in Model-View-Presenter) structure
This is a possible solution to keeping game logic separate from input logic. In this structure, the entity-component systems would form most of the models, while presenters act as the intermediary between them and the views, receiving events from either.
### Test more, and pick an ECS framework that makes testing easy
While I did test some of the systems I wrote, the ECS library I used caused some difficult to find errors when used this way.

