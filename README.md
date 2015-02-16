## Yelp

This is a Yelp search app using the [Yelp API](http://developer.rottentomatoes.com/docs/read/JSON).

Time spent: 12

### Features

#### Required

- [X] Search results page
   - [X] Table rows should be dynamic height according to the content height
   - [X] Custom cells should have the proper Auto Layout constraints
   - [X] Search bar should be in the navigation bar (doesn't have to expand to show location like the real Yelp app does). (Please see notes.)
- [X] Filter page. Unfortunately, not all the filters are supported in the Yelp API.
   - [X] The filters you should actually have are: category, sort (best match, distance, highest rated), radius (meters), deals (on/off).
   - [X] The filters table should be organized into sections as in the mock.
   - [X] You can use the default UISwitch for on/off states. Optional: implement a custom switch
   - [X] Clicking on the "Search" button should dismiss the filters page and trigger the search w/ the new filter settings.
   - [X] Display some of the available Yelp categories (choose any 3-4 that you want). (Please see notes.)

Notes:

* The categories search field is implemented as a text field. The user enters a comma-separated list of category codes.
* I couldn't get the sort field to work. Selecting on a table cell does not select the cell. I think it has to do with the tap gesture that I created in that same view.
* I've added a search bar, but didn't get it to work.   

#### Optional

- [ ] Search results page
   - [ ] Infinite scroll for restaurant results
   - [ ] Implement map view of restaurant results
- [ ] Filter page
   - [ ] Radius filter should expand as in the real Yelp app
   - [ ] Categories should show a subset of the full list with a "See All" row to expand. Category list is here: http://www.yelp.com/developers/documentation/category_list (Links to an external site.)
- [ ] Implement the restaurant detail page.

### Walkthrough
![Video Walkthrough](yelp_demo.gif)

Credits
---------
* [Yelp API](http://www.yelp.com/developers/documentation)
* [AFNetworking](https://github.com/AFNetworking/AFNetworking)
* [LiceCap](http://www.cockos.com/licecap/)
