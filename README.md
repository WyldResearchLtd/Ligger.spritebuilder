# Ligger  
----------

[![Build Status](https://travis-ci.org/fezzee/Ligger.svg?branch=master)](https://travis-ci.org/fezzee/Ligger)

  
Built with Spritebuilder/Cocos2d 

NOTE: Deleting the LiggerGamedata.plist in the applications /Documents directory resets the app to FirstPass
  
  
Gameplay  
---------  
What is a Ligger?  
  
Rumour has it that was coined by the Big Hair Glam bands in the 70 and 80's but popularised by NME Magazine in the nineties as a nickname for persons who attend parties, concerts, and festivals with the sole intention of obtaining free food and drink. 

Objective  
  
Everyone knows that festival promotors are a gracious lot, and will happily walk you into the backstage area, if you run a simple errand for them. Get to the bar and return with at least one drink for Michael, John, Melvyn and Rob, and they'll escort you backstage. If you spill a drink, you can return to the bar to get yourself another, or just head back to the promotor with their drink. If you spill both, you'll loose your turn with that promotor, but don't worry, the others are queued up to take your bait. 
  
  
The field is a wonderful place, filled with a bevy of curtious girls and boys that will help you navigate your way. At the halfway point, you can take respite in the flower lined path. When you get to the bar area, a bartender  will be eagarly waiting to get your drinks. If you spill a drink  you'll be teleported to the flower lined path, to give you a bit of head space before you continue your trek.  As you pass each level, things speed up, to a point. A level 2, beware fo the giant frog that can now flatten you in the flower lined path at the half way point.
    Lookout for Phil O. Cybin, a new character in Level 3. On some days, once you meet Phil, life can be wonderful and full of Sunflowers that bring you much joy and 
    more points. But on other days, you'll be confronted by Multi-eyed Monsters, that seem to appear from nowhere and will haunt your dreams and rob your bank.  
  
  
==========================

On app start , if this is the first pass, then we display the registration wizard.
The first pass is determined if we have a LiggerGamedata.plist and there's a UniqueUserID in it.
If this is a first pass, we create a unique UserID, and then gather the DeviceID and log these along with the Username entered, to the 'LiggerGamedata.plist' file.

On game finish, we see if the game scored is > top3 saved personal best games, and if so, update 'LiggerGamedata.plist'

On leaderboard opened, query the api for new data, and if so wite it to the LiggerGamedata.plist. Write the LiggerGamedata.plist data to the Popup UI. 


TODO & Bugs
----------- 
P1   
X Leaderboard UI
X First time start wizard & name collection popup
X Add new music to setup
X The Game Manager Object- Save Settings, Gameplay, and Tally Best Personal Score- 

Bugs
-------
Scoring- after loosing one beer, score resets

*Finish Game Manager

    * Increase level speed
    * Extra Players

* Finish Wizard
* Finish Leaderboard (stub webservice)

* Ode to Joy at levels/game finish
* Exit sign on menu
* Pause doesnt really pause- neither does Resume, resume then
* GameOver screen- needs F&F






UI Refresh

GamePlay Fit & Finish
-----------------------------
* Multiple obstructions/row
* Increase level speed
* Extra Players
* Leaderboard Webservice
* Add Non-Scoring milestones- Collision1, Collision2, Levelup, Game Over to GameData

-----------------------------
* Trigger point sounds- collisions, start, bartender, button clicks  

  
P2  
* Should say Backstage or VIP  
* create an interface for ShowPopover/RemovePopover     
* instead of walking left to promotor, and then back to the right, have the promotor meet the ligger? or only allow the ligger    
* Mask the obstacles so collisions are more accurate- change anchor point for left to right movement?  
* Transitions for Popups  
  
P3   
* * Bartender should show only a single drink if player.state = OneBeer   
* The particle effect for a NoBeer Ligger shouldn't be a splash  
* Obstacles that disappear before fully existing screen  
  
  
  
Game Over- Looser- Scoring....with buttins to play again or menu  
Welcome back notification  
  
  
  
Rows  
-------  
11th-FStreakers-814.7 (63.5)  
10th-Bongo-751.2 (61)  
9th-Spinner- 690.2  (63)  
8th-Hula-627.2 (133)  
7th-Conga-563.2 (69)  
6th-Cart 494.2  
----  
5th-Spinners 372    (+66)  
4th-Fork Lift  306.5  (+66)  
3rd-Hugger-  238.5  (+64)  
2nd-Bongos-174.5   (+62.5)  
1st-Streaker-112     (+ 64)  
Ligger-           48  
  



