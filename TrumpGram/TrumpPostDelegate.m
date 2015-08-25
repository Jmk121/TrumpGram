//
//  TrumpPostDelegate.m
//  TrumpGram
//
//  Created by jmk121 on 8/7/15.
//  Copyright (c) 2015 jmk121. All rights reserved.
//

#import "TrumpPostDelegate.h"
@interface TrumpPostDelegate()
@property(strong,nonatomic)NSMutableData *trumpData;
@end


@implementation TrumpPostDelegate
-(void)downloadTrumpPost{
    
    //Create a string variable to hold the url;
    NSString *trumpURLString = @"https://api.instagram.com/v1/tags/trump/media/recent?access_token=2041925534.1fb234f.bbdf783cea6e40c8824c3e7b573a7edc";
 //Create an object of tupe NSURL and wrap the url String
    NSURL *trumpURL = [NSURL URLWithString:trumpURLString];
    
    //Create an NSURLRequesst based on the url.
    NSURLRequest *trumpRequest=[NSURLRequest requestWithURL:trumpURL];

    //Create a NRUSLConnection with the request
    NSURLConnection *connection = [NSURLConnection connectionWithRequest:trumpRequest delegate:self];
    
    [connection start];

}

#pragma mark -NSURLConnection Delegate Methods

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    _trumpData =[[NSMutableData alloc]init];

}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{

    [_trumpData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{

//THis is where we will Parse JSON
    [self.delegate fetchTrumpFeed:_trumpData];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    UIAlertView *alertView =[[UIAlertView alloc]initWithTitle:@"Error" message:[NSString stringWithFormat:@"%@",error] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alertView show];
    
}
@end
