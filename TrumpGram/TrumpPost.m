//
//  TrumpPost.m
//  TrumpGram
//
//  Created by jmk121 on 8/7/15.
//  Copyright (c) 2015 jmk121. All rights reserved.
//

#import "TrumpPost.h"

@implementation TrumpPost


-(id)initWithPost:(NSString *)username andCaption:(NSString *)caption andImage:(UIImage *)image{
    self =[super init];
    if(self)
    {
        _username = username;
        _caption = caption;
        _trumpImage = image;
    
    }
    return self;
}


-(id)init{

    return [self initWithPost:nil andCaption:nil andImage:nil];
}
@end
