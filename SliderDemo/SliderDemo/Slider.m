//
//  Slider.m
//  cottages
//
//  Created by Ed Rackham on 08/03/2012.
//  Copyright (c) 2012 edrackham.com. All rights reserved.
//

#import "Slider.h"

@implementation Slider
@synthesize delegate;

@synthesize sliderBgView;
@synthesize sliderActiveBgView;
@synthesize sliderButtonImage;
@synthesize sliderButtonLeft;
@synthesize sliderButtonRight;

@synthesize width;
@synthesize leftStop;
@synthesize rightStop;
@synthesize maxVal;
@synthesize sliderStyle;
@synthesize maxSteps;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initAtPoint:(CGPoint)point maxWidth:(float)w{
    
    // Set up iVars yo x
    self.sliderButtonImage  = [UIImage imageNamed:@"SliderButton.png"];
    self.width              = w;
    self.leftStop           = self.sliderButtonImage.size.width/2;
    self.rightStop          = self.width - self.leftStop;
    self.maxVal             = self.width - self.sliderButtonImage.size.width;
    self.maxSteps           = 9;
    self.sliderStyle        = SliderStylePercent;
    
    // Dimensions
    if(self == [super initWithFrame:CGRectMake(point.x, point.y, w, sliderButtonImage.size.height)]){
        
        // Background Bar
        UIImage *sliderBg = [[UIImage imageNamed:@"SliderBg.png"] stretchableImageWithLeftCapWidth:3 topCapHeight:0]; 
        self.sliderBgView = [[UIImageView alloc] initWithFrame:CGRectMake(self.leftStop, 
                                                                          self.frame.size.height - sliderBg.size.height, 
                                                                          self.rightStop-self.leftStop, 
                                                                          sliderBg.size.height)];
        [self.sliderBgView setImage:sliderBg];
        [self addSubview:self.sliderBgView];
        
        // Background Bar (Active)
        UIImage *sliderActiveBg = [[UIImage imageNamed:@"SliderActiveBg.png"] stretchableImageWithLeftCapWidth:0 topCapHeight:0]; 
        self.sliderActiveBgView = [[UIImageView alloc] initWithFrame:CGRectMake(self.leftStop, 
                                                                          self.frame.size.height - sliderActiveBg.size.height, 
                                                                          self.rightStop-self.leftStop, 
                                                                          sliderActiveBg.size.height)];
        [self.sliderActiveBgView setImage:sliderActiveBg];
        [self addSubview:self.sliderActiveBgView];
        
        // Slider Buttons
        self.sliderButtonLeft  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.sliderButtonImage.size.width, self.sliderButtonImage.size.height)];
        [self.sliderButtonLeft setImage:self.sliderButtonImage forState:UIControlStateNormal];
        [self.sliderButtonLeft addTarget:self 
                             action:@selector(dragged:withEvent:) 
                   forControlEvents:UIControlEventTouchDragInside | UIControlEventTouchDragOutside];
        [self addSubview:self.sliderButtonLeft];
        
        self.sliderButtonRight = [[UIButton alloc] initWithFrame:CGRectMake((self.frame.size.width - self.sliderButtonImage.size.width), 0, self.sliderButtonImage.size.width, self.sliderButtonImage.size.height)];
        [self.sliderButtonRight setImage:self.sliderButtonImage forState:UIControlStateNormal];
        [self.sliderButtonRight addTarget:self 
                             action:@selector(dragged:withEvent:) 
                   forControlEvents:UIControlEventTouchDragInside | UIControlEventTouchDragOutside];
        [self addSubview:self.sliderButtonRight];
        
        
        
    }
    
    return self;
}

- (void)dragged:(UIButton *)control withEvent:(UIEvent *)event{
    CGPoint point = [[[event allTouches] anyObject] locationInView:self]; 
    
    // Fix Y position
    point.y = control.center.y;
    
    // Did we hit the left or right boundaries?
    // If so, stop sliding fool!
    if(point.x < self.leftStop || point.x > self.rightStop) return;
    
    // Did the control hit the other control?
    // If so, stop again!
    if(control == self.sliderButtonLeft){
        if(point.x + (self.sliderButtonImage.size.width / 2) >= self.sliderButtonRight.frame.origin.x) return;
    }
    
    if(control == self.sliderButtonRight){
        if(point.x - (self.sliderButtonImage.size.width * 1.5) <= self.sliderButtonLeft.frame.origin.x) return;
    }
    
    // Set point
    control.center = point;
    
    // Grab left and right points
    CGPoint leftPoint   = self.sliderButtonLeft.frame.origin;
    CGPoint rightPoint  = self.sliderButtonRight.frame.origin;
    
    // Convert left and right points to percentages.
    CGFloat pcLeft  = (leftPoint.x / maxVal) * 100;
    CGFloat pcRight = (rightPoint.x / maxVal) * 100;
    
    [self updateActiveBar];
    
    if(self.sliderStyle == SliderStylePercent){
        // Return percentages
        [delegate slider:self didFinishSlidingWithMinVal:pcLeft maxVal:pcRight];
    }else{
        int pointLeft   = round(maxSteps * (pcLeft / 100));
        int pointRight  = round(maxSteps * (pcRight / 100));
        
        // Return steps
        [delegate slider:self didFinishSlidingWithMinVal:pointLeft maxVal:pointRight];
    }
}

- (void)updateActiveBar{
    CGFloat leftX  = sliderButtonLeft.frame.origin.x + (sliderButtonImage.size.width / 2);
    CGFloat rightX = sliderButtonRight.frame.origin.x + (sliderButtonImage.size.width / 2);
    
    self.sliderActiveBgView.frame = CGRectMake(leftX, 
                                               self.sliderActiveBgView.frame.origin.y, 
                                               rightX - leftX, 
                                               self.sliderActiveBgView.frame.size.height);
    
}

@end
