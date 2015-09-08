//
//  ViewController.m
//  NSGIF-OSX
//
//  Copyright (c) 2015 Sebastian Dobrincu. All rights reserved.
//

#import "ViewController.h"
#import "NSGIF.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)demoButtonClicked:(id)sender {
    
    self.activityIndicator.hidden = NO;
    [self.activityIndicator startAnimation:nil];
    
    NSURL *videoURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"video" ofType:@"mp4"]];
    [self.textField setStringValue:[videoURL path]];
    
    [NSGIF optimalGIFfromURL:videoURL loopCount:0 completion:^(NSURL *GifURL) {
        
        NSLog(@"Finished generating GIF: %@", GifURL);
        
        [self.activityIndicator stopAnimation:nil];
        self.activityIndicator.hidden = YES;
        [[self.webView mainFrame] loadRequest:[NSURLRequest requestWithURL:GifURL]];
        [[[[[self.webView mainFrame] frameView] documentView] superview] scaleUnitSquareToSize:NSMakeSize(.5, .5)];
    }];
    
}

- (IBAction)openButtonClicked:(id)sender {
    
    NSOpenPanel* openDlg = [NSOpenPanel openPanel];
    NSArray *fileTypesArray;
    fileTypesArray = @[@"mov", @"mp4", @"avi"];

    [openDlg setCanChooseFiles:YES];
    [openDlg setAllowedFileTypes:fileTypesArray];
    [openDlg setAllowsMultipleSelection:TRUE];
    
    if ([openDlg runModal] == NSModalResponseOK) {
        NSArray *files = [openDlg URLs];
        for(int i = 0; i < [files count]; i++ ) {
            NSURL *videoURL = [NSURL fileURLWithPath:[[files objectAtIndex:i] path]];
            [self.textField setStringValue:[[files objectAtIndex:i] path]];
            self.activityIndicator.hidden = NO;
            [self.activityIndicator startAnimation:nil];
            
            [NSGIF optimalGIFfromURL:videoURL loopCount:0 completion:^(NSURL *GifURL) { 
               
                NSLog(@"Finished generating GIF: %@", GifURL);

                [self.activityIndicator stopAnimation:nil];
                self.activityIndicator.hidden = YES;
                [[self.webView mainFrame] loadRequest:[NSURLRequest requestWithURL:GifURL]];
                [[[[[self.webView mainFrame] frameView] documentView] superview] scaleUnitSquareToSize:NSMakeSize(.5, .5)];
            }];
        }
    }
}

@end
