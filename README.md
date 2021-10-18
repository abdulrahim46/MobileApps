# iOS Challenge
## Mobile App


- Develop a native mobile app that provides information about the mobile phones currently available in the market. This app should consume 2 endpoints from a web service and should display the information on a list and detailed page.

![Platform](https://img.shields.io/badge/Platform-iOS-orange.svg)
![Languages](https://img.shields.io/badge/Language-Swift-orange.svg)

## Installation
- Pod install.
- using SDWebImage framework for caching & displaying image in cells.
- Segmentio for tab bar.
- Firebase firestore for saving favourite mobiles.
- open MobileApps.xcworkspace. 
- Select the iphone simulator of your choice & run it. 
- Tested on iOS 14.3, iOS 14.5 ( iphone SE, iphone 12 pro).

## Design Pattern: Model-View-ViewModel-Coordinator (MVVM)
is a structural design pattern that separates objects into three distinct groups:
- #### Models 
  - hold application data. They’re usually structs or simple classes.
- #### Views 
  - display visual elements and controls on the screen. They’re typically subclasses of UIView.
- #### View models
  - transform model information into values that can be displayed on a view. They’re usually classes, so they can be passed around as references.


### High-level requirements:

## List screen
- The page is separated into sections by 2 tabs (list and favorites).
- Display list of mobile phones obtained from the API in the list section.
- Each item of the list should contain thumbnail image, title, description (tail truncated at two lines), price, rating and a favourite icon.
- When a user taps on the favorite icon, it should add the mobile phone to the favorite section.
- In the favorite section, a user should be able to swipe to delete to remove a mobile phone from their favorite.

- An options button on the top right of the list screen should offer sorting options. Tapping on the sorting button, the following list of options should appear: Sortby:
 1.Price(low to high)
 2.Price(hightolow)
 3.Rating(5to1)

- Sorting option that is selected should apply to both full list and favorite list sections.
- Tapping on a mobile phone entry should bring the user to the details screen.

## Details screen

- Obtain a list of images related to the mobile phone from the API.
- The images should be horizontally scrollable and should consume 35% of the screen height of the device.
- The price and rating should appear on top of the image as the overlay.
- The full description should appear below the images.

### Endpoints to be consumed

- Get list of mobile phones:

- GET https://scb-test-mobile.herokuapp.com/api/mobiles/

- Get images for mobile phone with id:

- GET https://scb-test-mobile.herokuapp.com/api/mobiles/{mobile_id}/images/

    
  ## Improvements / Need to be done
- Due to limited time constraints, wrote only few unit Tests and UI tests by using XCTest. Need to cover all unit test.
-  Delete favourite mobile from firebase need to be tested.
-  Authentication for firebase for different users.

## Technology/Tools

- iOS 13
- Xcode 12
- Swift 5
- UIKit
- URLSession
- Codable, Decodable
- Firebase, Firestore
- Segmentio
- [SDWebImage](https://github.com/SDWebImage/SDWebImage)
- StoryBoard
- Programmatically written UI
- AutoLayout
- MVVM
- XCTestCase for unit tests and UI Tests.
- Xcode Instruments for memory leaks and allocations.
- Symbolic Breakpoint


## 📱 Screenshots

<p float="left"> 
<img src="/Documentation/list.png" width="200">
<img src="/Documentation/favourite_view.png" width="200">
<img src="/Documentation/detail1.png" width="200">
<img src="/Documentation/delete_view.png" width="200">
</p>

<p float="left"> 
<img src="/Documentation/detail2.png" width="200"> 
<img src="/Documentation/sort_view.png" width="200">
<img src="/Documentation/emptyView.png" width="200">
<img src="/Documentation/delete_message.png" width="200">
<img src="/Documentation/added.png" width="200">
</p>

