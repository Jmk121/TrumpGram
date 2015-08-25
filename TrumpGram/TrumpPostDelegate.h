//
//  TrumpPostDelegate.h
//  TrumpGram
//
//  Created by jmk121 on 8/7/15.
//  Copyright (c) 2015 jmk121. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TrumpPost.h"
@protocol TrumpPostParseDelegate <NSObject>

-(void)fetchTrumpFeed:(NSMutableData *)data;

@end


@interface TrumpPostDelegate : NSObject<NSURLConnectionDataDelegate,NSURLConnectionDelegate>
@property(weak,nonatomic)id<TrumpPostParseDelegate>delegate;
-(void)downloadTrumpPost;

@end
