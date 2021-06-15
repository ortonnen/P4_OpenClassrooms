# Instagrid

## General description
Instagrid is an iPhone app that allows users to combine photos by choosing from multiple layouts. 
The end result is in a square format and can be shared with his friends.

***

## Features

### Selecting the layout of the photos

The photos are organized in a layout that the user can choose. The three available arrangements are recalled below:
By tapping on one of these provisions:
 * insert photo
 
1. The previously selected layout is no longer marked as selected.
2. The typed selection is marked as selected.
3. The central grid (in dark blue) adapts to the new layout.

### Add photos

By tapping a plus button, the user has access to their photo library and can choose one of the photos from their phone. 
Once chosen, this one takes the place of the box corresponding to the button no longer typed.
 * insert photo
 
The photo must be centered, without being altered (the proportions are maintained) and take as much space as possible (no “white”).
If the user clicks on a photo in the grid, they can choose a new image from the photo library to replace it

### Swipe to share

The user can share the creation they have just made. For this he can realize a
swipe up (in portrait mode) or to the left (in landscape mode).
The swipe starts an animation that slides the main grid up (or down left) until it disappears from the screen.
When the animation is complete, the UIActivityController view is displayed and allows the user to choose their preferred application to share their creation.
 * insert photo
 
 After sharing is completed, canceled or failed, the main grid automatically returns to its original place by reverse animation.
