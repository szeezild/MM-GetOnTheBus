//
//  DetailViewController.m
//  GetOnTheBus
//
//  Created by Dan Szeezil on 3/26/14.
//  Copyright (c) 2014 Dan Szeezil. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"%@", self.busStopDictionary);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
