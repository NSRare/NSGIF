//
//  ViewController.m
//  NSGIF
//
//  Created by Sebastian Dobrincu on 30/08/15. (My birthday 🎉)
//  Copyright (c) 2015 Sebastian Dobrincu. All rights reserved.
//

#import "ViewController.h"
#import <Photos/Photos.h>
#import "NSGIF.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithRed:0.13 green:0.16 blue:0.19 alpha:1];

}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [self dismissViewControllerAnimated:YES completion:nil];
    
    NSURL *url = info[UIImagePickerControllerMediaURL];
    if (url) {
       
        
        [NSGIF createGIFfromURL:url withFrameCount:10 delayTime:0.2 loopCount:0 completion:^(NSURL *GifURL) {
            NSLog(@"Finished generating GIF: %@", GifURL);
            
            UIAlertView *alert;
            if (GifURL)
                alert = [[UIAlertView alloc] initWithTitle:@"Yaay!" message:@"You successfully created your GIF!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            else
                alert = [[UIAlertView alloc] initWithTitle:@"Ooops!" message:@"Hmm... Something went wrong here!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }];
        
        
    }
}

-(void)viewDidAppear:(BOOL)animated {
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.videoQuality = UIImagePickerControllerQualityTypeMedium;
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.mediaTypes = @[(NSString *)kUTTypeMovie];
    
    // Present the picker
    [self presentViewController:picker animated:YES completion:nil];
}

@end
