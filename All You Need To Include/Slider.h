//
//  Slider.h
//  cottages
//
//  Created by Ed Rackham on 08/03/2012.
//  Copyright (c) 2012 Createanet. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    SliderStylePercent,
    SliderStyleSteps
} SliderStyle;

@protocol SliderDelegate <NSObject>
- (void)slider:(id)slider didFinishSlidingWithMinVal:(float)minVal maxVal:(float)maxVal;
@end

@interface Slider : UIView

@property (strong, nonatomic) id delegate;
@property (strong, nonatomic) UIImageView *sliderBgView;
@property (strong, nonatomic) UIImageView *sliderActiveBgView;
@property (strong, nonatomic) UIImage *sliderButtonImage;
@property (strong, nonatomic) UIButton *sliderButtonLeft;
@property (strong, nonatomic) UIButton *sliderButtonRight;
@property (assign, nonatomic) CGFloat width;
@property (assign, nonatomic) CGFloat leftStop;
@property (assign, nonatomic) CGFloat rightStop;
@property (assign, nonatomic) int maxVal;
@property (assign, nonatomic) SliderStyle sliderStyle;
@property (assign, nonatomic) int maxSteps;

- (id)initAtPoint:(CGPoint)point maxWidth:(float)w;
- (void)dragged:(UIControl *)control withEvent:(UIEvent *)event;
- (void)updateActiveBar;
@end
