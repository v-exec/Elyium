# Guide to writing for Elyium

All entities are written in a `.json` format. If you aren't familiar with this format, it's best to learn its syntax (it's insanely simple, I promise you).

## Structure & Formatting

Entities contain a few key components: An array of `master conflicts`, with each conflict containing an array of `choices`, with each choice containing either a `sub-conflict` (and the chain continues), or a `resolution` to the master conflict. Master conflicts can also contain `conditions`, which only allow the master conflict to be presented if all conditions have been met (more on that below).

I realize that this abstract description of entities' structure is likely confusing, so I urge you to go inside `/parsing/data` in this repository and open one of the .json files to see how an entity is constructed. This should help put all of this information into context, and help you use an existing entity as a visual support.

Each entity is written in its own .json file, and is then put together into a single file to be used in _Elyium_ with a simple script. So, to make your life easier, write your entities in separate files, it'll be much easier to manage.

Below are a list of instructional segments describing how entities and their components are to be formatted. Missing any of the components of these parts *will prevent the game from building*, so be sure that everything is as it should be. Also, don't be afraid to use a JSON Validator online (links found below, in the Resources section).

### Entity

```
"name": "entity name",
"cover": "entity image.fileformat",
"animate": true,
"context": "description of entity",
"conflicts": []
```

The `name` is visible in the database/menu view.

The `cover` image must be 500px x 500px, preferably in .png format.

The `animate` boolean determines whether the image will have the animated flickering ASCII bits. Due to Processing's inefficient text rendering, bright images create a lot of text and end up causing some lag, in which case it's best to leave `animate` to `false`. Also, some images simply don't look good animated, so feel free to turn off animation for those, as well. *NOTE*: `animate` takes a boolean value, therefore it must not have quotes `"` around it.

The `context` is the piece of text that players will always see when they begin a narrative sequence. It's best to make it something to set the mood, but vague enough to allow for each master conflict to take over the narrative seamlessly.

The `conflicts` is an object holding an array of master conflicts (more on that below).

### Master Conflict

```
"name": "K0",
"def": "Master conflict description.",
"choices": [],
"conditions": []
```

The `name`'s format itself isn't important, "K0", "K1"... is my own naming convention. This is never visible to players.

The `def` is what the players will see when they are presented with this conflict. This is visible to players.

The `choices` is an object containing an array of choice objects (more on that below).

The `conditions` are objects containing an array of condition objects (more on that below).

### Choice

Choices can be formatted in two different ways, depending on whether they contain a sub-conflict, of if they are choices marking the resolution to a master conflict.

If the choice contains a conflict, it is formatted like this:

```
"def": "Choice description.",
"con": {}
```

The `con` is a sub-conflict.

The `def` is the description attributed to the choice. This is visible to players.

If the choice is one marking the conflict resolution, it is formatted like this:

```
"name": "R0",
"def": "Choice description.",
"res": "Conflict resolution."
```

Much like the master conflict, the `name` format is not integral. It is never visible to players.

The `res` is what players will see as a resolution to the conflict before being taken out of the narrative sequence. This is visible to players.

Additionally, if a `res` starts with `START-`, followed by some text, it will reset the master conflcit to the beginning and show whatever follows the dash of `START-`. This is useful for narratives that loop back to the beginning, or involve some form of trial and error, or are centered around solving a puzzle.

### Sub-Conflict

```
"def": "Subconflict description.",
"choices": []
```

The `def` is what players will see when they are presented with this sub-conflict. This is visible to players.

The `choices` is an object containing an array of choice objects.

### Conditions

```
"entity": "entity name",
"con": "K0",
"res": "R0"
```

Conditions are used to create narrative chains, only allowing a master conflict to be presented to the player if all conditions for the master conflict are met. Conditions look inside the given `entity` (referred to by name), and look at its master conflict (`con`, referred to by name), and the expected resolution of said master conflict (`res`, referred to by name).

The condition above essentially says:

```
if entity "entity name"'s master conflict "K0" has been resolved by reaching its resolution "R0", then you may present this master conflict
```

This way, one entity can have conflicts only accessible if the player has reached certain conclusions in entirely different entities. This creates a narrative connection between entities, and allows for huge, elaborate narrative chains.

### Example Entity

```
{
  "name": "synthetic cavern",
  "cover": "synthetic cavern.png",
  "animate": true,
  "context": "The clouds gather, night sets, all sky light burns out from the surface of the planes. A small, cyan light marks the entrance of a large cavern composed of cables and hardware. As you carefully enter the cave, the entrance closes behind you. Faint lights guide the path.",
  "conflicts": [{
    "name": "K0",
    "def": "As you walk along the reverberating corridors, clicks and chirps echo through the inner-walls of the cavern. In the overwhelming darkness, you notice one of the lights near you has begun to flicker.",
    "choices": [{
      "def": "Investigate the flickering light.",
      "con": {
        "def": "You approach the light and notice a small chip, centimeters away from the glowing hot wire.",
        "choices": [{
          "def": "Grab the chip.",
          "con": {
            "def": "You slowly reach for the tiny bit of hardware. Out of anxiety, you flinch and burn yourself on the wire, but manage to grab on to the component. The cave is sharply illuminated in a dark red.",
            "choices": [{
              "name": "R2",
              "def": "Try to run and find the cave exit as quickly as possible.",
              "res": "You make a run for it. The wires composing the cave walls organically begin to close in, slowly wrapping themselves around you and tethering themselves to your clothes. As the cavern closes, you manage make it out of the web of cables and exit the cavern. You seem to have lost the chip in the panic."
            }, {
              "name": "R3",
              "def": "Stay calm, stand still, be quiet.",
              "res": "The wires composing the cave walls organically begin to close. They wrap themselves around you, but don't seem to consider you a threat. As they investigate your body, the lights slowly shift to the soft blue they were previously. You begin walking again, and find the exit. You've acquired [a mysterious hardware chip]."
            }]
          }
        }, {
          "name": "R1",
          "def": "Avoid the hot wire and the chip, and keep walking.",
          "res": "You continue walking and eventually notice light down the corridor marking an exit to the cave. Upon exiting, you notice it is now day time. The cavern slowly sinks into the dust, a small neon text above the entrance illuminates. 'Thank you.'"
        }]
      }
    }, {
      "name": "R0",
      "def": "Ignore the light and keep walking.",
      "res": "RESET-You keep walking, keeping your hand steadily planted on the metallic walls so as to keep yourself coordinated. Despite your efforts, you see another flickering light. Maybe you've been going in loops?"
    }]
  }, {
    "name": "K1",
    "def": "The cave doesn't lead to anywhere. The end of the single corridor is decorated with ornamental lights. There's a well-lit pedistal on top of which sits a strange, foreign device. It exudes an aura of extreme attraction and curiosity.",
    "choices": [{
      "name": "R0",
      "def": "Pick up the device.",
      "res": "You pick up the object. Harsh corridor lights come on, revealing the almost organic texture of the metallic walls. A neon sign above the pedistal lights up. 'Good Choice'. The cavern rises above the ground, opening an exit to the planes. You've acquired [an alien key]."
    }],
    "conditions": [{
      "entity": "synthetic cavern",
      "con": "K0",
      "res": "R0"
    }]
  }]
}
```

## Custom Save Files

Besides being able to write your own narratives, you can also create custom save files. What does this mean? The save file contains all encountered entities, their real-world coordinates, and all conflicts that have been resolved, with their respective resolutions.

By simply modifying what's inside the save file, you can subvert the random entity spawning system by giving each entity a set of coordinates (you can find latitude and longitude coordinates on Google Maps, if you want to put entities in real-world locations). If multiple players install the same build of _Elyium_, they would all encounter the same entities in the same locations, making this a community-centered game as players must get together to share their findings. Or perhaps, you can make certain entities visible in the database/menu view from the very beginning, encouraging players to go to the entity locations they already see, essentially making entities act as map markers.

The formatting for a save file is very simple.

```
[
  {
    "name": "entity name",
    "longitude": 24.502,
    "latitude": 185.200,
    "K0": "R0"
  }
]
```

That right there is the entirey of the `save.json` file.

The `name` is the entity in question's name.

The `longitude` and `latitude` are its real-world coordinates. *NOTE*: these two values are floats, and so they must not be surrounded by quotes `"`.

Finally, `"K0": "R0"` is an example of what a saved master conflict with its respective resolution would look like. `K0` is the master conflict name, and `R0` is the name of the resolution that was reached in this master conflict.

In order for an entity to be visible in the database, it must have at least one resolved master conflict.

If you're making a custom save file, keep in mind these three things: First of all, each object *must* have `name`, `longitude`, and `latitude` keys. Conflicts and their resolutions are optional. Second of all, this file will be updated over the course of the player's game, meaning that more fancy fooling around with this file (things not covered in this guide) can cause unexpected results. Finally, putting entities very close to one another (anything closer than 0.007 degrees) whilst still leaving some entities to be randomly spawned can cause issues in the spawning system.

## Building Elyium

Now that you have your narratives, images, and perhaps a custom save file, it's time to put it together to create your own version of Elyium.

First, you need to download and install [Processing](https://processing.org/), and get its [Android Mode](http://android.processing.org/). You might also need the [Android SDK](https://developer.android.com/studio/index.html#downloads).

### Narrative file

Inside `/parsing` in this repository, you will find a Processing sketch called `parsing.pde`, as well as a folder called `/data`. After you're sure all of your .json files are well formatted, put them inside the `/data` folder inside `/parsing`. Then, open `parsing.pde` and run it. You should now have a file called `narrative.json` inside the `/parsing` folder. Put this file inside the `/data` folder of _Elyium_, and you're done with this part.

### Save file

If you have a custom save file, simply make sure that it's situated inside the `/data` folder of _Elyium_.

### Building

After you've arranged all of your files, you just need to build the application. This is covered in Processing for Android's section on [distributing apps](http://android.processing.org/tutorials/distributing/index.html). If you'd like to simply install the package on your phone without making a distributable APK, you can just follow Processing for Android's [setup tutorial](http://android.processing.org/tutorials/getting_started/index.html).

## Resources

Here are some resources that may help you with writing for _Elyium_.

### JSON validators and formatters.

http://jsonlint.com/

https://jsonformatter.curiousconcept.com/

### Online JSON editors.

http://www.jsoneditoronline.org/

http://www.cleancss.com/json-editor/

http://codebeautify.org/online-json-editor

### Local JSON editor.

I personally use [Sublime](https://www.sublimetext.com/) for any text editing, including writing for _Elyium_. Though technically, any editor that has syntax highlighting (which helps significantly in keeping track of things) will work great.