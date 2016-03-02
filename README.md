# RSSCodeTest
####About
The RSS Code test is an example of what I can produce in two to three days of work. 
This project was started and code complete within two days, small modifications and tune ups were then made in the third and final day.
<br />

The project is an iOS app written for iPhone in Swift 2.0. It requires iOS 9.2 to run properly. 
I learned some of Swift's syntax a few days prior to starting work on RSSCodeTest, so this could be considered my first Swift project.
<br />

####Libraries and Tools Used
To make the implentation easier I bring in several external libraries through [CocoaPods](https://cocoapods.org/). 
These are [SnapKit](https://github.com/SnapKit/SnapKit), and [ObjectMapper](https://github.com/Hearst-DD/ObjectMapper). SnapKit is never used, but I like to keep it around in case any UI elements need quick tweaking.
ObjectMapper fuels my JSON model construction and is critical to this project.

####How It Works
+ RSSCodeTest uses an embedded UIScrollView and a recyleable xib file to make cards the user can then scroll through.
+ Each card receives its data from a web GET call that returns JSON payloads.
+ These payloads are structured into models, persisted to memory, and then converted to UI elements.
+ Offline use is managed by saving the JSON payload after it is received. The images are loaded  on an "as-needed" basis, thus any offline use disallows images.
<br />

####Use Instructions
+ Stories are presented to the user through a card UI. Users swipe across the screen 
to see different cards and can tap on them to see the full story. 
+ Offline use is allowed and will show the user story titles as well as some of the story's content.
+ If the app is accessed for the first time without internet access a message is
presented to the user and the app must be relaunched with internet access.
+ These instructions can be seen within the app on the main screen by hitting the "Info" button in the lower right hand corner.


##Check out these great screenshots!

<img src="http://i.imgur.com/PN8hAX8.png" width="370">
<img src="http://i.imgur.com/wFguYcK.png" width="370">



