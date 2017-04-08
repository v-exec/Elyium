# Elyium

_Elyium_ is an experimental mobile alternate reality game, and a platform for narrative experiences and storytelling.

[More information on this project can be found here.](http://v-os.ca/elyium)

## What is Elyium?

_Elyium_ is an experimental mobile alternate reality game and narrative platform. The player is put inside a world filled with 'entities' from various realms, each with their own sets of branching stories to tell. Within the in-world narrative, the player's phone acts as a conduit to _Elyium_, the limbo world, granting them access to the infinite planes. As they walk around in the physical realm, they come accross new entities, which are saved in the player's database. Using their real-world coordinats, as well as those of recorded entities, players can revisit old places to find new experiences.

Aside from being a story-centered game, _Elyium_ is also a storytelling format. The experience described above works regardless of the content of each entity's branching stories, meaning that anyone can create content for their own instance of _Elyium_. All content (entities, their stories, each story's choices, the ties between different stories, and custom real-world locations for entities) is written within a few `.json` files, making writing for this format relatively user friendly.

## Why did you make Elyium?

The reason I made _Elyium_ is primarily to explore narrative as a concept, and to learn more about stories and world-building through the process of designing a narrative-centric experience. I wanted to create a format of storytelling unique to the alternate reality capacity of mobile devices and location tracking, and allow others to create their own content for this format, too. This project was an oportunity for me to create and learn about narratives that interest me, and a way for me to pursue one of my ultimate goals: creating a perfectly designed universe.

## How does Elyium work?

An array of pre-written entities are (more or less) randomly spawned (unless they have a custom location written into them) at the player's location as the player navigates the physical realm. Each entity has a set of conflicts (which can be conditional, only presented to players once other conflicts (from either the same entity or others) have been resolved in specific ways), and each conflict has a set of choices that the player can make in order to resolve it. Choices either lead to a resolution, ending the conflict and letting the player continue roaming the world again, or they lead to another conflict, creating a chain of events that can technically last as long as the narrator wishes.

When a player first encounters an entity, they are forced into a narrative sequence. After they've completed this sequence, this entity is saved in their database (accessible through the small square on the bottom right). In this database view, they can see their current real-world coordinates, as well as all the entities they've encountered and their respective coordinates. If a player is close enough to a previously encountered entity, they simply need click/tap the entity in the database view to interact with it again and be presented with a new narrative sequence.

## How do I write stories on Elyium?

All entities are written in a `.json` format. Due to the parsing system being quite 'hard', it is important that writers stick to the appropriate format to avoid errors. A guide to writing for _Elyium_ can be found in this repository, as a file named `Writing.md`. It explains how to format your stories, suggested tools that make writing more seamless, and instructions on how to build your own version of _Elyium_.

## Plan

A breakdown of the remaining tasks to be completed for the production of this project, in (more or less) chronological order.

*NOTE*: _Elyium_ is now playable! Remaining tasks are related to user experience / interaction design, some minor fixes, and testing.

- Fix weird startup crash (drawcolor on null object).

- Add scrolling to menu interface.

- Change menu entity interface element to show it can be interacted with.

- Use timer to keep players from continuously getting narratives in the same entity by persistently interacting with it.

- Add vibration feedback for UI presses and entity encounters.

- Verify phone compatabilities.