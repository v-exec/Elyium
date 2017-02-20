#Elyium

###What it is

_Elyium_ is a *work in progress* mobile game with a text-only interface that motivates users to investigate an alternative 'fantasy science' universe synchronized with our own.

The user is granted access to the world of _Elyium_ through their phone, a world parallel to our own. Through physical mobilization, users are met with objects, people, or entities. Each of these encounters presents a narrative sequence in which the player has a variety of choices to make.

Visually, the game is exclusively text based, inspired by the aesthetic of a computer terminal, with regular use of ASCII art.

###Resources & Inspiration

[Processing for Android](http://android.processing.org/index.html) - Tool

A great tool developed in part by The Processing Foundation themselves, allowing PDE applications to make use of device sensors, and to be run on Android with little to no changes to the code.

[Pokemon Go](https://lh3.googleusercontent.com/dq_t7Is81-gkHYxKfAQ7PuLQBR-Qrte-7S1DsKFZnhaZATpibMSiw3aCrJzYik1x3IV5=h900) - Maps

The utilization of physical markers in the real world, I feel, is a great way to tie a fictional world to a real-world environment.

[No Man's Sky](https://cdn0.vox-cdn.com/uploads/chorus_asset/file/6952189/Atlas1a.jpg) - Landmark Narratives

I always found the stories told in these landmarks to be super interesting, but was always disappointed that they didn't impact my experience in any way beyond a trivial reward if I chose the 'right' answer, and a small loss of health if I chose the 'wrong' one. I'd like to elaborate on this mechanic.

[Devine - Nataniev App](https://www.youtube.com/watch?v=DBZCLjsI1bs) - Atmosphere

_Nataniev_ captures a certain solitude of the atmosphere that I'd like to create. Additionally, it also is a 'walking game', one that I feel inspired this idea heavily in its early stages.

[Alternate Reality Game](https://en.wikipedia.org/wiki/Alternate_reality_game) - Concept

I'm inspired by the concept behind ARG (alternate reality games), though with a smaller scope, less of a focus on developing a community of enthusiasts, and more of a focus on expressing a lonely atmosphere and inciting a sense of exploration.

[The World Is Yours](https://preview.c9users.io/sarahlauzon/final-project/final_project/index.html?_c9_id=livepreview3&_c9_host=https%3A%2F%2Fide.c9.io) - Narrative

_The World Is Yours_ is a non-linear interactive text experience that has a peculiar way of telling a story that I find especially appealing. It is a bit too ambiguous for my taste, and I do not see _Elyium_ adopting this storytelling method entirely, but the content matter and phrasing is something I'd very much like to experiment with.

[Jon Hopkins - We Disappear](https://www.youtube.com/watch?v=wqhCDbagWh8) - Atmosphere

As subjective and personal as music is, I feel like this song successfully conveys a mood (at least to me) that resembles the ambience of the world. Jon Hopkins' music, in general, is something I draw inspiration from for this project.

The [beautiful](https://s-media-cache-ak0.pinimg.com/736x/d4/2d/17/d42d1776fd77f66582758f56cc86ffa5.jpg) [art](http://nerdreactor.com/wp-content/uploads/2014/06/art-of-watch-dogs-6.jpg) of [Dedsec](http://orig08.deviantart.net/d21f/f/2016/166/3/f/dedsec_skull_noise_2_by_junguler-da6cg74.gif) - Visual Aesthetic

_WatchDogs 2_'s creative direction is undeniably unique. Ever since the first game, I've had a deep interest in the digital-centric design of Dedsec's art. As much as I'd like to create visuals with this much detail, refinement, and *animation*, this is something that requires a lot of time dedicated to content creation. Time I simply don't have. However, this still acts as the primary inspiration for the graphical user interface, as there are many elements to the style that are not as time-consuming, but still very powerful.

###How it works

When the user logs in for the first time, their location is tracked. As the user roams around, entities are procedurally spawned in their surroundings.

The entities at these locations function in the same way every time. When they are triggered, they give the user a narrative sequence (a block of text, basically), with an ASCII visual attatched, and usually a few choices the player can make. The player must decide on how to interact with the few options given to them. Their choices affect how the entity they're interacting with reacts, how the story sequence plays out, and what future sequences will be generated. In larger scale 'quests', these decisions will also affect how other entities' narratives play out, what entities the player will come accross, and in what states.

As the player discovers more key entities and interacts with them, other key entities will be alerted to important decisions that the player has taken. These decisions will add new narrative modules to be included in the sequence generation, advancing the story.

Visually, all entities have visuals attatched to them. Since this is a text-only experience in a terminal-like environment, visuals are limited to ASCII. All visuals are parsed through an ASCII filter which translates regular images into ASCII characters.

###Plan

A breakdown of the remaining tasks to be completed for the production of this project, in (more or less) chronological order:

- Implement idle mode.

- Create map grid + algorithm to determine when to allocate entity location.

- Tie entity locations to narration generation.

- Create conditional conflict handling.

- Add entity locations in menu screen.

- Add interaction options for when the user is near entities, in menu.

- Create save functionality that triggers after every narrative sequence has been resolved.

- Add startup and transition animations.

- Make more narrative content and images, refine narrative system, create main and side 'quests'.