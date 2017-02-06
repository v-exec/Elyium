#Elyium

###What it is

_Elyium_ is a mobile game with a text-only interface that motivates users to investigate an alternative 'fantasy science' universe synchronized with our own.

The user walks around with their phone, and at certain landmarks in the physical world (a store, a monument, a park, etc.), they are met with objects, people, or entities. Each of these encounters is a narrative sequence that reveals a portion of the events that have occured in the area and includes a player choice that affects the progression and branching of the narrative experience.

The narrative is relatively ambiguous, it isn't an explicit story. Through snippets of storytelling, the player would come to their own conclusions. More importantly, the grand majority of narrative sequences are generated procedurally, allowing for a variety of possible scenarios.

Visually, the game would be exclusively text based, inspired by the aesthetic of a computer terminal. I would like to utilize ASCII art for certain visuals as well, so as to make it more visually appealing and to convey the ambience of the environment. Using an image-to-ASCII filter, filtered images will accompany certain narrative sequences.

###Resources

[Processing for Android](http://android.processing.org/index.html)

A great tool developed in part by The Processing Foundation themselves, allowing PDE applications to make use of device sensors, and to be run on Android with little to no changes to the code.

[Google Maps API](https://developers.google.com/maps/)

If I want to implement a sort of geolocation, my best bet is google maps. Their google maps API is probably my only choice.

###Inspiration

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

Now, I realize that a non-linear, procedurally generated branching narrative with filtered google search images that uses geolocation for world navigation is not easy to make. In fact, I don't think I can do all of this within the given timeframe. The project above describes an 'ideal' version of this project. This 'ideal', of course, is likely to change over the course of the project, as it's likely that some parts do not require as much complexity as I initially intended to implement.

With that being said, here's a breakdown of the tasks to be completed for the production of this project, in (more or less) chronological order:

- ~~Get acquainted with Processing for Android. Create a few sketches, make sure they run, and test location services and accelorometer.~~

- ~~Create a simple application that increases a counter when the device is shaken, using the accelorometer. This will replace geolocation for now, the number of steps will determine how far the player has travelled, and after passing a certain number of steps, a random encounter with an entity would trigger.~~

- ~~Create an image-to-ASCII algorithm. Hand-pick the images to be used for the story. This will replace the google-searched images, because searching through google images and automating a curating process for which image best suits the narrative sequence is not easy to make.~~

- ~~Create a simple interface engine for the application. This is when the application starts to be put together.~~

- Create a preliminary selection of characters and objects to interact with. These are actually quite simple, as both objects and characters have relatively similar functionality: present a narrative, give the player a choice. The main difference between the two is how characters would potentially have 'standing' with the player that would evolve over time and affect how the player interacts with them, whereas objects would not.

- Create a few static stories that go along with the preliminary entities. This would replace a narrative constructor algorithm. This system would need to divide a 'sequence' into a few key parts, each of which would have a selection of attributes that describe what other pieces it can be fitted with. Additionally, it would need to make sure not to repeat phrases (like, ever), as that'd be very immersion breaking and would give away the procedural generation to the player.

- Implement story bits and interactive entities as content in interface engine.


At this point, we have the minimum viable product. A game where you shake your phone enough times to get some text with a cool image and make some choices in it, with *some* effect on the rest of the game world. It's not incredibly exciting, but it has the potential to convey the idea quite accurately. I think that, in all likelyhood, it won't take much time to get to this point, giving me a lot of time to work on the more advanced versions of the features. Here is the continuation of the project plan:

- Create narrative construction system, and implement it into the game. This system would handle constructing sequences out of small textual bits, as well as managing the consequences of player choices, i.e. keeping a set of values that represent the key choices the player has made, and the player's relationship to other entities. I choose to focus on this immediately after finishing the minimum viable product, because it is the heart of the game experience. Pretty interfaces and fancy animations are not central to the idea, and so they're left for later.

- ~~Familiarize myself with the Google Maps API, and find a way to spawn entities in hotspots marked by Google Maps around the player's area. Now, this is getting into uncharted territory, as I've never used Google Maps' API and have no clue if it'll even work the way I envision it. Since this is also a relatively integral part of the experience, it's possible that it switches places with the previous step, depending on how the production is going.~~

- Refine narrative system, create more entities, add to story. At this point, we're reaching the final stages of the project, where the all of the base functionality is there (except for saving, which I've decided to do after this because as important as saving is, it's nowhere near as cool as getting all this other stuff done), and the polishing and refining phase begins. There's a lot of technical stuff that's working, but until now, there actually hasn't been a huge focus on creating more content for the story. Content creation is a *huge* deal in game dev, but this is a creative computation class, not a creative writing class, so I'm leaving the creation of content for later, though I would likely develop the content in parallel to the system in other circumstances.

- Create save functionality (finally). This would take the player data stored in the narrative system, as well as all of the entities in whichever area they last were. How, exactly? I don't know.

- Make everything prettier, add visual polish, add sound effects, add music(?), add cool startup animation, make more narrative content, refine narrative system. This is the final stage.


In all honesty, I doubt that I will be able to reach the final stage by the project deadline. I think it's most likely that I create the minimum viable product, then spend a bunch of time on the narrative system, and have a bit of time to maybe get the Google Maps thing to work. I say this because I'm certain that I've overlooked at least a few things, and many unforseen challenges will come up. Though I do believe that I will, at the very least, create something that acts as a prototype and showcases the ideas I'd like to express.
