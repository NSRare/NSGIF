//
//  NSGIF.h
//
//  Created by Sebastian Dobrincu
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <ImageIO/ImageIO.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>

@interface NSGIF : NSObject

+ (void)createGIFfromURL:(NSURL*)videoURL withFrameCount:(int)frameCount delayTime:(int)delayTime loopCount:(int)loopCount completion:(void(^)(NSURL *GifURL))completionBlock;

@end
