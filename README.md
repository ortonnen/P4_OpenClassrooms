# Instagrid

## General description
Instagrid is an iPhone app that allows users to combine photos by choosing from multiple layouts. 
The end result is in a square format and can be shared with his friends.

<img width="406" alt="Capture d’écran 2021-06-18 à 09 54 30" src="https://user-images.githubusercontent.com/57671772/122527175-60b37480-d01b-11eb-801b-43c692536866.png">

***

## Features

### Selecting the layout of the photos

The photos are organized in a layout that the user can choose. The three available arrangements are recalled below:
By tapping on one of these provisions:

<img width="204" alt="Capture d’écran 2021-06-18 à 09 59 06" src="https://user-images.githubusercontent.com/57671772/122527733-e505f780-d01b-11eb-9448-746367a49777.png">

 
1. The previously selected layout is no longer marked as selected.
2. The typed selection is marked as selected.
3. The central grid (in dark blue) adapts to the new layout.

### Add photos

By tapping a plus button, the user has access to their photo library and can choose one of the photos from their phone. 
Once chosen, this one takes the place of the box corresponding to the button no longer typed.

<img width="199" alt="Capture d’écran 2021-06-18 à 10 01 36" src="https://user-images.githubusercontent.com/57671772/122528041-331afb00-d01c-11eb-9e7f-48c42bf4c5b7.png">

 
The photo must be centered, without being altered (the proportions are maintained) and take as much space as possible (no “white”).
If the user clicks on a photo in the grid, they can choose a new image from the photo library to replace it

### Swipe to share

The user can share the creation they have just made. For this he can realize a
swipe up (in portrait mode) or to the left (in landscape mode).
The swipe starts an animation that slides the main grid up (or down left) until it disappears from the screen.
When the animation is complete, the UIActivityController view is displayed and allows the user to choose their preferred application to share their creation.

<img width="208" alt="Capture d’écran 2021-06-18 à 10 07 01" src="https://user-images.githubusercontent.com/57671772/122528749-fa2f5600-d01c-11eb-82e9-d0b3dd736557.png">

 
 After sharing is completed, canceled or failed, the main grid automatically returns to its original place by reverse animation.
