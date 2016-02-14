# Project 2 - *Yelp*

**YelpLayout** is a Yelp search app using the [Yelp API](http://www.yelp.com/developers/documentation/v2/search_api).

Time spent: **X** hours spent in total

## User Stories

The following **required** functionality is completed:

- [x] Search results page
   - [x] Table rows should be dynamic height according to the content height.
   - [x] Custom cells should have the proper Auto Layout constraints.
   - [x] Search bar should be in the navigation bar (doesn't have to expand to show location like the real Yelp app does).
- [x] Filter page. Unfortunately, not all the filters are supported in the Yelp API.
   - [x] The filters you should actually have are: category, sort (best match, distance, highest rated), distance, deals (on/off).
   - [x] The filters table should be organized into sections as in the mock.
   - [x] You can use the default UISwitch for on/off states.
   - [x] Clicking on the "Search" button should dismiss the filters page and trigger the search w/ the new filter settings.
   - [x] Display some of the available Yelp categories (choose any 3-4 that you want).

The following **optional** features are implemented:

- [ ] Search results page
   - [ ] Infinite scroll for restaurant results.
   - [ ] Implement map view of restaurant results.
- [ ] Filter page
   - [ ] Implement a custom switch instead of the default UISwitch.
   - [ ] Distance filter should expand as in the real Yelp app
   - [ ] Categories should show a subset of the full list with a "See All" row to expand. Category list is [here](http://www.yelp.com/developers/documentation/category_list).
- [ ] Implement the restaurant detail page.

## TODO

**DELETE** this section before submitting for review.

This is a personal todo list as I step through the assignment.
- [x] Project setup: fork repo and build headless client
- [x] Add tableView with basic prototype cells
- [x] Use AutoLayout to configure custom cells
- [x] Add Search Bar in the navigation bar
- [x] Add Settings ViewController (using TableViewController and static cells)
  - [x] Embed Settings ViewController in NavigationController
  - [x] layout static cells
  - [x] disable cell selection
  - [x] configure IBOutlets back to UISwitch in FiltersTableViewController
  - [x] configure UITableCell selection in FiltersTableViewController delegate
- [x] Add FilterSettings class
- [x] Add API support for distance (`radius_filter`)
- [x] configure Distance cell selection in FiltersTableViewController
---
- [x] Search bar enhancements
  - [x] Hint text in empty search field
  - [x] Allow empty search (search button disabled on keyboard)
  - [x] Keyboard suggestions (`searchBar.autocorrectionType = .Default`)
- [ ] Search results list enhancements
  - [ ] scroll table back to top after search
  - [ ] no results view
- [ ] HUD for any asynchronous network calls
- [ ] Review Assignment #1 feedback
---
- [ ] LiceCap of required stories

<!---
***

The following **additional** features are implemented:

- [ ] List anything else that you can get done to improve the app functionality!

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1.
2.

## Video Walkthrough

Here's a walkthrough of implemented user stories:

<img src='http://i.imgur.com/link/to/your/gif/file.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

***
--->

## Notes

Describe any challenges encountered while building the app.

1. Getting cells to line up properly with Auto Layout was not easy.
2. Wasn't sure if I should use a `class` or a `struct` for the `FilterSettings` model

## License

    Copyright 2016 Marcel Weekes

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
