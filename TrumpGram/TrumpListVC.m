//
//  ViewController.m
//  TrumpGram
//
//  Created by jmk121 on 8/7/15.
//  Copyright (c) 2015 jmk121. All rights reserved.
//

#import "TrumpListVC.h"
#import "TrumpPost.h"
#import "TrumpDetailVC.h"
@interface TrumpListVC ()<UITableViewDataSource,UITableViewDelegate>
@property(strong,nonatomic)NSMutableArray *posts;
@property(strong,nonatomic)TrumpPost *trumpPost;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TrumpListVC
 NSURL *imageURL;
 NSString *createdTime;


- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    TrumpPostDelegate *postDelegate =[[TrumpPostDelegate alloc]init];
    postDelegate.delegate =self;
    [postDelegate downloadTrumpPost];
  
}
/**/

 


-(void)fetchTrumpFeed:(NSMutableData *)data{
    
    
    
    NSError *error = nil;
    //Create a dictionary for the json document
    NSDictionary *jsonObject =[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    NSLog(@"%@",jsonObject);
    self.posts =[[NSMutableArray alloc]init];
    NSArray *immutablePost = jsonObject[@"data"];
    for (NSDictionary* dict in immutablePost) {
        createdTime = dict[@"created_time"];
        NSDictionary *imageDict = dict[@"images"];
        if (![imageDict isEqual:[NSNull null]]) {
            NSDictionary *thumbnail = imageDict[@"thumbnail"];
            NSString *imageString = thumbnail[@"url"];
            UIImage *postImage = [self imagewithURL:imageString];
            NSDictionary *caption =dict[@"caption"];
            NSString *username;
            NSString *captionString;
            if (![caption isEqual:[NSNull null]]) {
                captionString = caption[@"text"];
                NSDictionary *fromUserDict = caption[@"from" ];
                username = fromUserDict[@"username"];
            }
            
            else{
                captionString =@"There is no caption";
            }
            
            self.trumpPost =[[TrumpPost alloc]initWithPost:username andCaption:captionString andImage:postImage];
            [self.posts addObject:self.trumpPost];
        }
    }
    [self.tableView reloadData];

}

-(UIImage*)imagewithURL:(NSString *)url{
    NSURL *imgURL =[NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:imgURL];
    NSData *data =[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    UIImage *img =[UIImage imageWithData:data];
    return img;

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [_posts count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellID = @"TrumpCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    TrumpPost *post =_posts[indexPath.row];
    cell.textLabel.text = post.username;
    cell.detailTextLabel.text = post.caption;
    cell.imageView.image = post.trumpImage;
    return cell;

}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.destinationViewController isKindOfClass:[TrumpDetailVC class]]) {
        TrumpDetailVC *tdvc = (TrumpDetailVC *)segue.destinationViewController;
        NSIndexPath *indexPath =[self.tableView indexPathForSelectedRow];
        TrumpPost *selectedPost = _posts[indexPath.row];
        tdvc.passedPost = selectedPost;
        
    }

    

}
@end
