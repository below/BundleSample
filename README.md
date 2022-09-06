# BundleSample
A sample to exemplify loading a bundle in iOS

## Prelude

Avid followers of my Twitter account know: I was looking for an easy, preferably human editable container for documents, and — being the old Mac developer I am — I went with bundles, stored in the Documents folder.

## The Problem

At some point in my app, the user can choose which file to use. And then, of course, on next launch, that file should be used. Selecting the file [works all nice and well](https://github.com/below/BundleSample/blob/19581d7fe48bc7d47ea788a0a19baf9f6b28a843/BundleSample/ContentView.swift#L53), including reading from the created `Bundle`. 

The problem occurs when the App is relaunched, and reads the `absoluteString` of the file from the UserDefaults. This works, and I can create a URL from it. But [creating a bundle fails](https://github.com/below/BundleSample/blob/19581d7fe48bc7d47ea788a0a19baf9f6b28a843/BundleSample/ContentView.swift#L76), and I don't get any error. This happens on iOS 15 and 16, on device and in the simulator.

Is this some permissions things? Is the url not formatted correctly? What is going on?

## To reproduce

* Launch the App, in the Simulator or on device
* Select "Copy Bundle" (You can "Test Resource Bundle", but it does not matter)
* Finally, select "Test Documents Bundle". You should see a picture
* Close the app, either by stopping it in Xcode or force quit
* Restart the App

### Expected Result
You see the picture

### Acutal Result
You see the "Gear" placeholder
