# Ligger  
----------

[![Build Status](https://travis-ci.org/fezzee/Ligger.svg?branch=master)](https://travis-ci.org/fezzee/Ligger)

Built with Spritebuilder/Cocos2d 

For iOS 6 and above (TBC)

Note- Ipad Retina and iPad Air- labels are limited in length! Test this!
  
Gameplay  
---------  
To add later---

    The Frog- Level 2

    Lookout for Phil O. Cybin, a new character in Level 3. On some days, once you meet Phil, life can be wonderful and full of Sunflowers that bring you much joy and 
    more points. But on other days, you'll be confronted by Multi-eyed Monsters, that seem to appear from nowhere and will haunt your dreams and rob your bank.  

==========================
App Notes


On app start, if this is the first pass, we display the simple setup (firstpass) wizard.
The first pass is determined if we have a LiggerGamedata.plist and there's a UniqueUserID in it.

If this is a first pass, we create a unique UserID, and then gather the DeviceID and log these along with the Username entered, to the 'LiggerGamedata.plist' file.

On game finish, we see if the game scored is > top3 saved personal best games, and if so, update 'LiggerGamedata.plist'

On leaderboard opened, query the api for new data, and if so wite it to the LiggerGamedata.plist. Write the LiggerGamedata.plist data to the Popup UI. 


==========================

Release Checklist
---------------------
const bool EASYPASS = false; //used to make it easy to level up
const bool TESTUTILS = false; //used to make it test options available- delete plist- it will automatically turn on in simulator- not as useful as it was.
const bool VERBOSE_CONSOLE = false; //turns printLog and logging settingss, on and off

NSString *const WEBSERVURL = @"http://ligger-api.fezzee.net"; //@"http://127.0.0.1:5433";

In Spritebuilder, set to Release and Publish

Update Version (108)


Change History
--------------
6-Oct-15 :: IOS9 issue- App Transport Security - New entries in Info.plist to turn off new security features- see
https://developer.apple.com/library/prerelease/ios/technotes/App-Transport-Security-Technote/index.html
7-Oct-15 :: Updated the Code Signing Licenses and Provisioing profiles



TODO for Release  
---------------------- 

TEST-
-what happens if you tie a score on PersonalBest- eg- PB is 100, 70, 50....you score 70 again...does it end up 100,70,50?
-DeviceID

* All text reviewed  
    * T&Cs  
    * Gameplay  * Advise users in First pass wizard to read about gameplay  
    * Credits  

* create new Amazon account



   
  
KNOWN ISSUES  
--------------------
-Mute audio and change selection- new selection not played   
-2G error uploading score data  
 

TODO- Future Release  
--------------------  

* Beers in HUD are lowres 

* Game Manager-Extra Players 

* add versioning to About view

* create callback to update Leaderboard in realtime (rather than at launch)- then remove blockng call on LiggerBoard UI startup

* the Service logging should include timestamp and create verbose mode for logging full objects 

* New Icons for swipe, touch, audio on/off, touchpad arrows  
* flowers as bullet points 
  
* Upgrade GameLog  
    * Add Non-Scoring milestones- Collision1, Collision2, Levelup, Game Over to GameData  
    * Trigger additional point sounds- collisions, start, bartender, button clicks   
  
P2  
* Add 'No. 'Beers' to Level/Game totals  
* create an interface for ShowPopover/RemovePopover    
* base class -- PopoverLayout  
* instead of walking left to promotor, and then back to the right, have the promotor meet the ligger? or only allow the ligger    
* Mask the obstacles so collisions are more accurate- change anchor point for left to right movement?  
* Transitions for Popups  
  
P3   
* Random delay for each character start  
* A particle effect for Returning home/Getting beer 
* Obstacles that disappear before fully existing screen  
  
 
extra nav to add  
----------------------------------  
Game Over- Leaderboard  
Game Over- play again 
Main Menu- exit  
 
  
Welcome back 'User' notification  
  
  
Technical Debt
----------------
Move FirstPass func from PopupLayer to its own class (already stubbed out as FirstPassLayer)

  
Removed from T&C's
-------------------
We may translate these terms into multiple languages, and in the event there is any difference between the English version and any other language version of these terms, the English version will apply (to the extent permitted by applicable law).



