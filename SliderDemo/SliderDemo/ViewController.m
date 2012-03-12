//
//  ViewController.m
//  SliderDemo
//
//  Created by Ed Rackham on 12/03/2012.
//  Copyright (c) 2012 edrackham.com. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController
@synthesize percentSlider;
@synthesize steppedSlider;
@synthesize percentSliderLabel;
@synthesize steppedSliderLabel;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Setup for percent slider
    percentSlider = [[Slider alloc] initAtPoint:CGPointMake(20, 128) maxWidth:280];
    [percentSlider setDelegate:self];
    [self.view addSubview:percentSlider];
    
    // Setup for stepped slider
    steppedSlider = [[Slider alloc] initAtPoint:CGPointMake(20, 267) maxWidth:280];
    [steppedSlider setSliderStyle:SliderStyleSteps];
    [steppedSlider setMaxSteps:20];
    [steppedSlider setDelegate:self];
    [self.view addSubview:steppedSlider];
}

- (void)viewDidUnload
{
    [self setPercentSliderLabel:nil];
    [self setSteppedSliderLabel:nil];
    [super viewDidUnload];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

# pragma mark - Slider Delegate Method

- (void)slider:(id)slider didFinishSlidingWithMinVal:(float)minVal maxVal:(float)maxVal{
    if(slider == percentSlider){
        percentSliderLabel.text = [NSString stringWithFormat:@"Left: %.2f%% | Right: %.2f%%", minVal, maxVal];
    }
    
    if(slider == steppedSlider){
        steppedSliderLabel.text = [NSString stringWithFormat:@"Left: %.0f | Right: %.0f", minVal, maxVal];
    }
}

@end
