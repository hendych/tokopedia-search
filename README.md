# Build Status

[![Build Status](https://travis-ci.org/hendych/tokopedia-search.svg)](https://travis-ci.org/hendych/tokopedia-search) [![codecov](https://codecov.io/gh/hendych/tokopedia-search/branch/master/graph/badge.svg)](https://codecov.io/gh/hendych/tokopedia-search)


# Introduction
Welcome to Tokopedia mini assignment test repo. This project is written based on [Memory Leak Free VIPER TDD](https://github.com/hendych/VIPER-TDD). For more details VIPER, click this [link](https://www.objc.io/issues/13-architecture/viper/).

# Folder Structure
The main source folder is located at `Classes/` with structure below:
- `Extension/` – contains extension of existing iOS Framework (UIImage, UIView, etc). 
- `Component/` – contains partial view that can be reused on another screen. 
- `View/` – contains main UI (UIViewController, XIB) and related protocols for the related view.
- `Interactor/` – contains all business logic, API and local data managements.
- `Presenter/` – contains presenter of each related view that manages events that translates into routing, inputs or outputs.
- `Entity/` – contains entities that exist in the app.
- `Router/` – contains all router that manage dependency injection, navigations and VIPER creation.

# Environment
This code is built on `Xcode 10` with minimum iOS Requirement is `10.0`, and written in `Swift 4`

# Dependencies
This project is using `Cocoapods` version `1.5.3` for dependency management. It's dependencies are:
- `Alamofire` for networking.
- `AlamofireImage` for image caching and fetch from url.
- `NMRangeSlider` is custom slider with lower and upper value.

To install these dependencies, go to the project root folder and run `pod install` and open `Search.xcworkspace` if you want to open the project.

# Goals
This project also using Travis CI to build, test, check and linting. You can see the build status above.

Also, code coverage is shown on above. The goals is to reach code coverage at least `85%`

# Author
Created by [Hendy Christianto](https://www.linkedin.com/in/hendy-christianto-1a47729a/). Contact me at hendychrst90@gmail.com