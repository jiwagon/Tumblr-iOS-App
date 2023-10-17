# Project 5 - Tumblr Feed

Submitted by: Ji Zhang

This simple social media app fetches a feed of blog posts from the Tumblr API and displays them in a scrolling list via a table view. Users can pull to refresh and view more posts alternating content from two Tumblr accounts. The posts are shuffled to display in random order. 

Time spent: 10 hours spent in total

## Required Features

The following **required** functionality is completed:

- [X] App has a configured table view and table view call
- [X] App populates the table view with data fetched from an API

The following **optional** features are implemented:

- [X] App fetches posts from a different Tumblr blog ([https://www.tumblr.com/storyfund](url))
- [X] App has a refresh control to update the table view

The following **additional** features are implemented:

- [X] Shuffle the posts to get them in random order
- [X] Alternate the two Tumblr API URLs at each refresh pull

## Video Walkthrough

<a href="https://imgur.com/nnFYgcc">
    <img src="https://i.imgur.com/nnFYgccm.gif" title="source: imgur.com" />
</a>

## Notes

- Setting constraints is the most difficult part for me. I spent an unnecessarily long time making sure the scroll list view was organized.
- It was also challenging to set up the PostCell because I was unable to Ctrl+drag the imageView into PostCell. I made sure that the class and Identifier were changed to PostCell, but the issue still remained. I eventually restarted the project, and the issue went away.
- There were some challenges in making the refresh control work properly as intended. I had to change the original way to initialize the URL object. Instead, I created a parameter for a URL string and only converted it into an object after the fetch post is called. In this case, we can take in the two API URLs as strings from the array list where they were stored and then convert them to URL objects as needed.

## License

    Copyright [yyyy] [name of copyright owner]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
