//
//  NSGIF.m
//  
//  Created by Sebastian Dobrincu
//

#import "NSGIF.h"

@implementation NSGIF

// Declare constants
#define fileName     @"NSGIF.gif"
#define timeInterval @(600)
#define tolerance    @(0.01)

+ (void)createGIFfromURL:(NSURL*)videoURL withFrameCount:(int)frameCount delayTime:(int)delayTime loopCount:(int)loopCount completion:(void(^)(NSURL *GifURL))completionBlock {
    
    // Convert the video at the given URL to a GIF, and return the GIF's URL if it was created.
    // The frames are spaced evenly over the video, and each has the same duration.
    // delayTime is the amount of time for each frame in the GIF.
    // loopCount is the number of times the GIF will repeat. Defaults to 0, which means repeat infinitely.
    
    // Create properties dictionaries
    NSDictionary *fileProperties = @{(NSString *)kCGImagePropertyGIFDictionary:
                                        @{(NSString *)kCGImagePropertyGIFLoopCount: @(loopCount)}
                                    };
    
    NSDictionary *frameProperties = @{(NSString *)kCGImagePropertyGIFDictionary:
                                          @{(NSString *)kCGImagePropertyGIFDelayTime: @(delayTime)}
                                      };

    AVURLAsset *asset = [AVURLAsset assetWithURL:videoURL];
    
    // Get the length of the video in seconds
    float videoLength = (float)asset.duration.value/asset.duration.timescale;
    
    // How far along the video track we want to move, in seconds.
    float increment = (float)videoLength/frameCount;
    
    // Add frames to the buffer
    NSMutableArray *timePoints = [NSMutableArray array];

    for (int currentFrame = 0; currentFrame<frameCount; ++currentFrame) {
        
        float seconds = (float)increment * currentFrame;
        CMTime time = CMTimeMakeWithSeconds(seconds, [timeInterval intValue]);
        [timePoints addObject:[NSValue valueWithCMTime:time]];
        
    }

    // Prepare group for firing completion block
    dispatch_group_t gifQueue = dispatch_group_create();
    dispatch_group_enter(gifQueue);
    
    __block NSURL *gifURL;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        gifURL = [self createGIFforTimePoints:timePoints fromURL:videoURL fileProperties:fileProperties frameProperties:frameProperties frameCount:frameCount];

        dispatch_group_leave(gifQueue);
    });
    
    dispatch_group_notify(gifQueue, dispatch_get_main_queue(), ^{
        // Return GIF URL
        completionBlock(gifURL);
    });
    
}

+ (NSURL *)createGIFforTimePoints:(NSArray *)timePoints fromURL:(NSURL *)url fileProperties:(NSDictionary *)fileProperties frameProperties:(NSDictionary *)frameProperties frameCount:(int)frameCount {
    
    NSString *temporaryFile = [NSTemporaryDirectory() stringByAppendingString:fileName];
    NSURL *fileURL = [NSURL fileURLWithPath:temporaryFile];
    CGImageDestinationRef destination = CGImageDestinationCreateWithURL((__bridge CFURLRef)fileURL, kUTTypeGIF , frameCount, NULL);
    
    if (fileURL == nil)
        return nil;

    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:url options:@{}];
    AVAssetImageGenerator *generator = [AVAssetImageGenerator assetImageGeneratorWithAsset:asset];
    generator.appliesPreferredTrackTransform = YES;
    
    CMTime tol = CMTimeMakeWithSeconds([tolerance floatValue], [timeInterval intValue]);
    generator.requestedTimeToleranceBefore = tol;
    generator.requestedTimeToleranceAfter = tol;
    
    NSError *error = nil;
    for (NSValue *time in timePoints) {
        
        CGImageRef imageRef = [generator copyCGImageAtTime:[time CMTimeValue] actualTime:nil error:&error];
        if (error) {
            NSLog(@"Error copying image: %@", error);
            return nil;
        }
        
        CGImageDestinationAddImage(destination, imageRef, (CFDictionaryRef)frameProperties);
    }
    
    CGImageDestinationSetProperties(destination, (CFDictionaryRef)fileProperties);
    // Finalize the GIF
    if (!CGImageDestinationFinalize(destination)) {
        NSLog(@"Failed to finalize GIF destination: %@", error);
        return nil;
    }
    
    return fileURL;
}


@end
