## Flickr Search

#### Introduction
Flickr Search is a simple iOS application which, given a search query, shows a list of photos from Flickr that match the given query. The app supports endless scrolling and will also show a search history (currently not persisted between sessions).

#### Getting started
The app depends on the [Mantle](https://github.com/Mantle/Mantle) and [SDWebImage](https://github.com/rs/SDWebImage) frameworks, both of which are included using [Carthage](https://github.com/Carthage/Carthage).
Everything is included in the project so just open the project in XCode, compile and you should be good to go.

#### Architecture
Flickr Search uses a simple MVVM-based architecture and relies on (constructor-based) dependency injection. There are currently two view-models: 
- PhotoSearchViewModel which does the bulk of the work concerning querying the api and remembering search history
- PhotoViewModel whose only task is to build a image url so the view can actually display a photo.

#### Tests
The project includes some simple unit tests for the view models.

#### Other
Some things that are not included:
- Meaningful error reporting to the user
- Analytics
- Crash reporting
- Persistence of search history between sessions
- UI tests