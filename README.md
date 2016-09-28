# HFSideMenuViewController

SideMenuViewController show left view of your viewController.

<img src="https://raw.githubusercontent.com/HenryFanDi/HFSideMenuViewController/develop/demo.gif" width="320" height="563">

## Usage

Initialize your two viewControllers, includes mainly viewController and left menu viewController.

```swift
let mainViewController = MainViewController(nibName: "MainViewController", bundle: nil)
let leftMenuViewController = LeftMenuViewController(nibName: "LeftMenuViewController", bundle: nil)
```

Initialize sideMenuViewController with `mainViewController` and `leftMenuViewController`.

```swift
let sideMenuViewController = HFSideMenuViewController.init(mainViewController: mainViewController, 
														   leftMenuViewController: leftMenuViewController)

```

And you can setup sideMenuViewController like this:

* `AppDelegate` － RootViewController.

	```swift
	window?.rootViewController = sideMenuViewController
	```
	
* `ViewController` － Push viewController by using navigationController.

	```swift
	navigationController?.pushViewController(sideMenuViewController, animated: true)	
	```

### Properties

You can customize two of below preperties:

* `menuWidth: CGFloat` － Side menu width, default is (screenWidth - 100.0).
* `menuAnimationDuration: CGFloat` － Side menu animation duration, default is (0.5).

	```swift
	// Customize
	sideMenuViewController.menuWidth = 200.0
	sideMenuViewController.menuAnimationDuration = 1.0
	```

### Toggle

Toggle side menu animation behavior with `HFSideMenuHelper`.

```swift
HFSideMenuHelper.shard.toggleLeftMenuWithAnimation()
```

## Feature

* Show right view, lol.

## License

This project is under MIT License. Please feel free to use.

## Contact

If have any suggestions or improvements, welcome feel free to contact me at [@HenryFanDi](https://twitter.com/HenryHaoTi).