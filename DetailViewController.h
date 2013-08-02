//
//  DetailViewController.h
//  CustomCalendarUICollectionView
//
//  Created by Erin Hochstatter on 8/2/13.
//  Copyright (c) 2013 Rex Fatahi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellBasedViewController.h"

@interface DetailViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *imageNoLabel;
@property int eventType;
@end
