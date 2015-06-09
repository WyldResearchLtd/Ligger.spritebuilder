# Ligger  
  
Built with Spritebuilder/Cocos2d  
  
  
Gameplay  
---------  
What is a Ligger?  
  
Rumour has it that was derived and popularised by NME Magazine in the nineties as a nickname for 'Liam Gallagher', and others who 
attend parties, concerts, and festivals with the sole intention of obtaining free food and drink and being seen with 
celebrities. For the record, we don't believe this is true, we don't know who started this rumour, and as far we know, Liam has 
never needed to blag his way anywhere. He's a nice lad and we're sure if you asked nicely, he'd be happy to fetch you a 
drink.  
  
Objective  
  
Everyone knows that festival promotors are a gracious lot, and will happily walk you into the backstage area, if you run a simple 
errand for them. Get to the bar and return with at least one drink for the promotor, and the promotor will escort you backstage. 
If you spill a drink, you can return to the bar to get yourself another, or just head back to the promotor with their drink. If 
you spill both, you'll loose your turn with that promotor, but don't worry, there are others queued up to take your bait. 
  
Level 1  
  
The field is a wonderful place, filled with a bevy of curtious girls and boys that will help you navigate your way. 
At the halfway point, you can take respite in the flower lined path. When you get to the bar area, a bartender  will be eagarly 
waiting to get your drinks. If you spill a drink  you'll be teleported to the flower lined path, to give you a bit of head space 
before you continue your trek.  
  
Level 2  
  
Things get a little faster here, and yes, you didn't imagine that, that is a giant frog on the flower lined path. Careful, your 
Ligger can be flattened by the Frogger. ;-)  
  
  
Level 3  
  
Lookout for Phil O. Cybin, a new character in Level 3. On some days, once you meet Phil, life can be wonderful and full of 
Sunflowers that bring you much joy and more points. But on other days, you'll be confronted by Multi-eyed Monsters, that seem 
to appear from nowhere and will haunt your dreams and rob your bank.  
  
  
TODO  
----  
P1  
* Slide out the backstage entrance  
* instead of walking left to promotor, and then back to the right, have the promotor meet the ligger? or only allow the ligger  
to return to the spot by the promotor?  
* don't allow Ligger to enter inside the promotors area'  
* create a level controller  
* add all obstacles incl new female streaker  
  
P2  
* Bartender should show only a single drink if player.state = OneBeer  
* Add particle effect for getting drink  
* add timeline for walking Ligger (2Beers and 1Beer)  
* if the Bartender comes to Ligger, the ligger isn't flipped to face forward as it does when the Ligger goes to the Bartender  
* Mask the obstacles so collisions are more accurate  
  
P3 (Optional)  
* Ligger movement too blocky (Jack)  
* ((CCNode*)self.promotors[0])  -- used a collection generic <CCNode*> to eliminate the casts  
* In startGame and pauseGame, loop through obstacle collection  
* The particle effect for a NoBeer Ligger shouldn't be a splash  
* FIx the obstacles that disappear before fully existing screen  
  
OTHER  
Add Crashlytics  
Add to Travis  

  
Game Over- Looser- Scoring....with buttins to play again or menu  
  
Menu
===================
*Play Ligger*  
*Credits(The Garden)*  
  
*Options*  
*Leaderboard*  
*About, The Story, Rules, Instructions, Gameplay)...need a better word*  
  
Profile  
==================  
registration info  
change character  
sound on/off  
connect with facebook
  
Welcome Back Notification like Frogger!  
  
