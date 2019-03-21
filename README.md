# TsgsSelector

[![CI Status](https://img.shields.io/travis/yusuke-tech/TsgsSelector.svg?style=flat)](https://travis-ci.org/yusuke-tech/TsgsSelector)
[![Version](https://img.shields.io/cocoapods/v/TsgsSelector.svg?style=flat)](https://cocoapods.org/pods/TsgsSelector)
[![License](https://img.shields.io/cocoapods/l/TsgsSelector.svg?style=flat)](https://cocoapods.org/pods/TsgsSelector)
[![Platform](https://img.shields.io/cocoapods/p/TsgsSelector.svg?style=flat)](https://cocoapods.org/pods/TsgsSelector)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

No dependencies.

## Installation

TsgsSelector is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'TsgsSelector'
```

## How to use

1. in Interface Builder
1. Add new UIView to the ViewController that you want to put the TagBar.
2. Select identity inspector tab at inspectors, and set "TSTagBar" at custom class field.
3. Make IBOutlet for TSTagBar
2. in Source Code
1. import TagsSelector.
2. Set an array of TSTags at the `tags` property of tagBar instance.


## Author

uskithub, yusuke.saito@jibunstyle.com

## License

TsgsSelector is available under the MIT license. See the LICENSE file for more info.
