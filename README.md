#Elyium

###What it is

_Elyium_ is a mobile game with a text-only interface that motivates users to investigate an alternative 'fantasy science' universe synchronized with our own.

The user is granted access to the world of _Elyium_ through their phone, a world parallel to our own. Through physical mobilization, users are met with objects, people, or entities. Each of these encounters presents a narrative sequence in which the player has a variety of choices to make.

Visually, the game is exclusively text based, inspired by the aesthetic of a computer terminal, with the regular use of ASCII art.

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

When the user logs in for the first time, their location is tracked. Using the google maps API, the system finds notable landmarks and creates points of interest that get triggered when the user is sufficiently close to them.

The entities at these locations function in the same way every time. When they are triggered, they give the user a narrative sequence (a block of text, basically), potentially with an ASCII visual attatched. Then, the player must decide on how to interact with a few options to choose from. Their choices affect how the entity they're interacting with reacts, how the story sequence plays out, and how future sequences will be generated, play out, and what entities the player will come accross, and in what states.

Each narrative sequence is constructed using a variety of modular bits of text. Depending on some key elements of the constructed text, a selection of appropriate player choices will be queried and picked at random whilst avoiding presenting players with a repetitive set of decisions.

As the player discovers more key entities and interacts with them, all other entities will be alerted to important decisions that the player has taken. The decisions will add new text modules to be included in the sequence generation, advancing the story.

Visually, some of the entities and narrative sequences would have visuals attatched to them. Since this is a text-only game in a terminal-like environment, I'm limited to ASCII. All content would be procedurally generated (to a degree), and that would include the visual art, as well. Whenever an image is needed, a quick google search would be conducted looking for a few key words. Once an appropriate image is found, it is processed through a filter that determines a pixel region's brightness, and replaces it with an ASCII character that represents said brightness (for instance, '@' would be much 'brighter' than '.', as it takes up more space).

###Scope - Plan

A breakdown of the remaining tasks to be completed for the production of this project, in (more or less) chronological order:

- Finish developing, organizing, and implementing narrative construction system + choice button functionality. This system handles the picking of narrative sequences, as well as managing the consequences of player choices.

- Create map grid + algorithm to determine when to allocate entity location, and tie that to the narration generation.

- Add entity locations in menu screen.

- Create save functionality. After every narrative sequence, this takes the player and entity stored in the narrative system, as well as all of the entities' last known location.

- Add startup and transition animations.

- Make more narrative content, refine narrative system, create main and side 'quests'.