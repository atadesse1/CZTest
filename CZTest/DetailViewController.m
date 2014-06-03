//
//  DetailViewController.m
//  CZTest
//
//  Created by Tadesse bantiweson on 6/2/14.
//  Copyright (c) 2014 Abel. All rights reserved.
//

#import "DetailViewController.h"

#import <GoogleMaps/GoogleMaps.h>


@interface DetailViewController ()
@property(strong, nonatomic) GMSMapView *mapView_;
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
@property (copy, nonatomic) NSSet *markers;
- (void)configureView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.86
                                                            longitude:151.20
                                                                 zoom:2];
    self.mapView_ = [GMSMapView mapWithFrame:self.view.bounds camera:camera];
    //self.mapView_.delegate  = self;
    self.mapView_.mapType = kGMSTypeNormal;
    self.mapView_.myLocationEnabled = YES;
    self.mapView_.settings.compassButton = YES;
    self.mapView_.settings.myLocationButton = YES;
    [self.view addSubview:self.mapView_];
    //self.view = mapView_;
    
    
    // Creates a marker in the center of the map.
    //GMSMarker *marker = [[GMSMarker alloc] init];
    //marker.position = CLLocationCoordinate2DMake(-33.86, 151.20);
    //marker.title = @"Sydney";
    //marker.snippet = @"Australia";
    //marker.appearAnimation = kGMSMarkerAnimationPop;
    //marker.map = self.mapView_;
    [self setupMarkerData];
    //[self prefersStatusBarHidden];
    //[self viewWillLayoutSubviews];
    [self configureView];
    
}

/*-(BOOL)prefersStatusBarHidden{
    return YES;
}

-(void) viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.mapView_.padding =
    UIEdgeInsetsMake(self.topLayoutGuide.length + 25,
                     0,
                     self.bottomLayoutGuide.length + 5,0);
}*/

- (void)setupMarkerData {
    GMSMarker *marker = [[GMSMarker alloc] init];
    GMSMarker *marker2 = [[GMSMarker alloc] init];
    GMSMarker *marker3 = [[GMSMarker alloc] init];
    
    
    marker.position = CLLocationCoordinate2DMake(-33.86, 151.20);
    marker.title = @"Sydney";
    marker.snippet = @"Australia";
    marker.appearAnimation = kGMSMarkerAnimationPop;
    marker.map = self.mapView_;
    marker.map = nil;
    
    marker2.position = CLLocationCoordinate2DMake(-31.86, 150.20);
    marker2.title = @"Sydney";
    marker2.snippet = @"Australia";
    marker2.appearAnimation = kGMSMarkerAnimationPop;
    marker2.map = self.mapView_;
    marker2.map = nil;
    
    marker3.position = CLLocationCoordinate2DMake(-40.86, 155.20);
    marker3.title = @"Sydney";
    marker3.snippet = @"Australia";
    marker3.appearAnimation = kGMSMarkerAnimationPop;
    marker3.map = self.mapView_;
    marker3.map = nil;
    
    self.markers =
    [NSSet setWithObjects: marker, marker2, marker3, nil];
    [self drawMarkers];
    
}
-(void)drawMarkers{
    for(GMSMarker *marker in self.markers){
        if(marker.map==nil){
            marker.map = self.mapView_;
        }
    }
}

-(UIView *)mapView_:(GMSMapView *)mapView
    markerInfoWindow:(GMSMarker *)marker{
    
    UIView *infoWindow = [[UIView alloc] init];
    infoWindow.frame = CGRectMake(0,0,200,70);
    infoWindow.backgroundColor = [UIColor grayColor];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(100,11,175,16);
    [infoWindow addSubview:titleLabel];
    titleLabel.text = marker.title;
    
    UILabel *snippetLabel = [[UILabel alloc] init];
    snippetLabel.frame = CGRectMake(14, 42, 175, 16);
    [infoWindow addSubview:snippetLabel];
    snippetLabel.text = marker.snippet;
    
    return infoWindow;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

@end
