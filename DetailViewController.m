//
//  DetailViewController.m
//  CustomCalendarUICollectionView
//
//  Created by Erin Hochstatter on 8/2/13.
//  Copyright (c) 2013 Rex Fatahi. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    if (self.eventType == 0) {
        self.imageNoLabel.text = @"this shouldn't happen";
        
    }else if (self.eventType == 1){
        self.imageNoLabel.text = @"no. 1 event";

    } else if (self.eventType == 2){
        self.imageNoLabel.text = @"no. 2 event";
    
    } else {
        self.imageNoLabel.text = @"no. 3 event";
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
