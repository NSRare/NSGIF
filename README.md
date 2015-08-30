![NSGIF](https://dl.dropboxusercontent.com/s/0rq3fr0dtpvwd4h/NSGIF-header.png?dl=0)

NSGIF is an iOS Library for converting your videos into beautiful animated GIFs.
Check out _this example_. 

_Sometimes we need to deal with GIFs in Cocoa. This can really be a pain in the ass (believe me). And here comes our hero :octocat:. Breaking through errors and glitches and generating smooth GIFs :dash:._

## How it works
![NSGIF](https://dl.dropboxusercontent.com/s/nsh0s1shh9fbqpu/NSGIF-HIW.png?dl=0)
That's it really. If you want to go into some technical details though, here they are:

## Add to your project
 
There are 2 ways you can add NSGIF to your project:
 
### Manual installation
 
 Simply import the 'NSGIF' into your project then import the following in the class you want to use it: 
 ```objective-c
       #import "NSGIF.h";
 ```      
### Installation with CocoaPods

CocoaPods is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries like NSGIF in your projects. See the "[Getting Started](http://guides.cocoapods.org/syntax/podfile.html)" guide for more information.

### Podfile
```ruby
        platform :ios, '7.0'
        pod "NSGIF", "~> "1.0"
```

## Practical use

		[NSGIF createGIFfromURL:url withFrameCount:30 delayTime:.010 loopCount:0 		 completion:^(NSURL *GifURL) {
            NSLog(@"Finished generating GIF: %@", GifURL);
        }];

## License
Usage is provided under the [MIT License](http://http//opensource.org/licenses/mit-license.php). See LICENSE for the full details.


