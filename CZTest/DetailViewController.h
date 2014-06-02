//
//  DetailViewController.h
//  CZTest
//
//  Created by Tadesse bantiweson on 6/2/14.
//  Copyright (c) 2014 Abel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
