//
//  CellBasedViewController.m
//  CustomCalendarUICollectionView
//
//  Created by Erin Hochstatter on 8/1/13.
//  Copyright (c) 2013 Rex Fatahi. All rights reserved.
//

#import "CellBasedViewController.h"

@interface CellBasedViewController ()
{
    NSMutableArray  *daysArray;
}

-(void)getCalendarJSONData;

@end


@implementation CellBasedViewController

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
    [self getCalendarJSONData];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma
#pragma mark Get JSON from Flickr

-(void)getCalendarJSONData
{
    
    NSString *urlString = [NSString stringWithFormat:@"http://boiling-river-4676.herokuapp.com/augCal.json"];

    NSURL *calendarURL = [NSURL URLWithString:urlString];
    
    NSURLRequest *calendarURLRequest = [NSURLRequest requestWithURL: calendarURL];
        
    
    [NSURLConnection sendAsynchronousRequest:calendarURLRequest
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *urlResponse, NSData *data, NSError *error){
                               
                               
                               NSMutableArray *responseArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                               NSDictionary *queryDictionary = [responseArray objectAtIndex:0];
                               NSMutableArray *hiddenArray = [queryDictionary objectForKey:@"hidden"];
                               NSMutableArray *imageArray = [queryDictionary objectForKey:@"image"];
                              
                               daysArray = [[NSMutableArray alloc] init];
                               
                               for (int i = 0; i <35; i++) {

                                   
                                   DayClass *day = [[DayClass alloc] init];

                                   day.cellIsShown = [[hiddenArray objectAtIndex:i] boolValue];
                                   day.imageNumber = [[imageArray objectAtIndex:i] intValue];
                                   
                                   [daysArray   addObject:day];
                                   NSLog (@" days array count: %d",daysArray.count);
                                   
                               }
                               
                               [self.collectionView reloadData];
                               
                           }];
}


#pragma
#pragma mark Set Collection View

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    NSLog(@"this logs the sections in view");
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    NSLog(@"this logs the items in section:%d", daysArray.count);
    return daysArray.count;
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    DayClassCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"dailyCell" forIndexPath:indexPath];
    DayClass *dayForCell = daysArray[indexPath.row];
    //self.imageNoForSegue = dayForCell.imageNumber;
    //NSLog(@"image for segue: %d",self.imageNoForSegue );
    
    

    if (dayForCell.cellIsShown == NO)
    {
        [cell setAlpha:0.0];
        [cell setUserInteractionEnabled:NO];
        
    } else if (dayForCell.imageNumber ==0)
    
    {
        cell.imageView.image = nil;

    }
    else if (dayForCell.imageNumber ==1)
        {
        cell.imageView.image= [UIImage imageNamed:@"Image01.png"];

        } else if (dayForCell.imageNumber ==2)
        {
        cell.imageView.image = [UIImage imageNamed:@"Image02.png"];

        } else
        {
        cell.imageView.image =[UIImage imageNamed:@"Image03.png"];

        }

    return cell;
}

#pragma 
#pragma Segue Prepare & Send

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"segueToDetail"]){
        
        
        NSIndexPath *selectedIndexPath = [[self.collectionView indexPathsForSelectedItems] objectAtIndex:0];
        NSString *eventImageNo = [daysArray valueForKey:@"imageNumber"][selectedIndexPath.row];
      
        ((DetailViewController*)(segue.destinationViewController)).eventType = [eventImageNo intValue];

        NSLog(@"number being passed %d",((DetailViewController*)(segue.destinationViewController)).eventType);
    }
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
   [self performSegueWithIdentifier:@"segueToDetail" sender:self];
    

}

@end
