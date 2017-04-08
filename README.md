# Elyium

_Elyium_ is an alternate reality game, and a platform for narrative experiences and storytelling.

[More information on this project can be found here.](http://v-os.ca/elyium)

## What is Elyium?

_Elyium_ is an experimental alternate reality game and narrative platform.

In _Elyium_, the player's phone is described as an artifact of the alternate reality; a conduit, or a sort of gateway to the world of _Elyium_, a limbo realm that exists in the void between realities. This world is filled with various entities (objects, locations, events, and people), each with their own sets of branching narrative adventures. For the player, each encounter with an entity presents an oportunity for exploration that grants them a snippet of understanding of the reality around them, and a chance to reach the resolution of a narrative conflict that acts as a reflection of them, as a decision-maker and person.

However, _Elyium_ is not exclusively a narrative game, but also a platform that allows writers to create their own sets of narrative content that is then implemented using the same entity mechanics. This means that narrators who wish to utilize this environment for their own stories are free to use the underlying feature set and narrative format of _Elyium_ with their own content.

## Why did you make Elyium?

The reason I made _Elyium_ is primarily to explore narrative as a concept, and to learn more about stories and world-building through designing a narrative-centric experience. I want to create a format of storytelling unique to the alternate reality capacity of mobile devices, and allow others to create their own content for this format, too. This project is an oportunity for me to create and learn about narratives that interest me, and a way for me to pursue one of my ultimate goals: creating a perfectly designed universe.

## How does Elyium work?

An array of pre-written entities are (more or less) randomly spawned at the player's location as the player navigates the physical realm. Each entity has a set of conflicts (which can be conditional, only presented to players once other conflicts (from either the same entity or others) have been resolved in specific ways), and each conflict has a set of choices that the player can make in order to resolve it. Choices either lead to a resolution, ending the conflict and letting the player continue roaming the world again, or they lead to another conflict, creating a chain of events that can technically last as long as the narrator wishes.

When a player first encounters an entity, they are forced into a narrative sequence. After they've completed this sequence, this entity is saved in their database (accessible through the small square on the bottom right). In this database view, they can see their current real-world coordinates, as well as all the entities they've encountered and their respective coordinates. If a player is close enough to a previously encountered entity, they simply need click/tap the entity in the database view to interact with it again and be presented with a new narrative sequence.

## How do I write stories on Elyium?

All entities are written in a `.json` format. Due to the parsing system being quite 'hard', it is important that writers stick to the appropriate format to avoid errors. A guide to writing for _Elyium_ can be found in this repository, as a file named `Writing.md`. It explains how to format the stories, suggested tools that make writing more seamless, and how to build your own version of _Elyium_.

## Plan

A breakdown of the remaining tasks to be completed for the production of this project, in (more or less) chronological order.

*NOTE*: _Elyium_ is now playable! Remaining tasks are related to user experience / interaction design, some minor fixes, and testing.

- Fix weird startup crash (drawcolor on null object).

- Add scrolling to menu interface.

- Change menu entity interface element to show it can be interacted with.

- Use timer to keep players from continuously getting narratives in the same entity by persistently interacting with it.

- Add vibration feedback for UI presses and entity encounters.

- Verify phone compatabilities.