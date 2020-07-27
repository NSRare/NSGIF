//
//  NSGIF.h
//
//  Created by Sebastian Dobrincu
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <ImageIO/ImageIO.h>
#import <AVFoundation/AVFoundation.h>

#if TARGET_OS_IPHONE
    #import <MobileCoreServices/MobileCoreServices.h>
    #import <UIKit/UIKit.h>
#elif TARGET_OS_MAC
    #import <CoreServices/CoreServices.h>
    #import <WebKit/WebKit.h>
#endif

@interface NSGIF : NSObject

+ (void)optimalGIFfromURL:(NSURL *)videoURL loopCount:(int)loopCount progress:(void(^)(CGFloat progress))progressBlock completion:(void(^)(NSURL *GifURL))completionBlock;

+ (void)createGIFfromURL:(NSURL *)videoURL withFrameCount:(int)frameCount delayTime:(float)delayTime loopCount:(int)loopCount progress:(void(^)(CGFloat progress))progressBlock completion:(void(^)(NSURL *GifURL))completionBlock;

+ (void)createGIFfromImages:(NSArray *)imagesArray withDelayTime:(float)delayTime loopCount:(int)loopCount progress:(void(^)(CGFloat progress))progressBlock completion:(void(^)(NSURL *GifURL))completionBlock;

+ (void)cancel;

@end
