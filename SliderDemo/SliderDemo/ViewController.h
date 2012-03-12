//
//  ViewController.h
//  SliderDemo
//
//  Created by Ed Rackham on 12/03/2012.
//  Copyright (c) 2012 edrackham.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Slider.h"

@interface ViewController : UIViewController <SliderDelegate>

@property (strong, nonatomic) Slider *percentSlider;
@property (strong, nonatomic) Slider *steppedSlider;

@property (strong, nonatomic) IBOutlet UILabel *percentSliderLabel;
@property (strong, nonatomic) IBOutlet UILabel *steppedSliderLabel;
@end
