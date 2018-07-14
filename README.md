
# Game-ify

Xcode 9.4, iOS 9.0

HuntShowdown(App Name) displays a guessing game.

## Architecture

- `MasterViewController.swift`:  Use TableView as container of quiz 

- `JeopardyTableViewCell.swift`:  Cell with Photos & Answers, After guessing show standfirst and buttons(next & read article)

- `DetailViewController.swift`: Read Article 

- `ExtractionPoint.swift`: A json decoder, should be requsting from server in reality

- `DailyBuzz.swift`: Model: DailyBuzz & Quiz

- `ProgressView.swift`: A moderate health bar


## Pod
Pod download Images

```objective-c
pod 'Kingfisher', '~> 4.0'
```

## Unit Tests
includes a suite of unit tests within the Tests subdirectory. These tests can be run simply be executed the test action on the platform framework you would like to test.
- `HuntShowdownTests.swift`





