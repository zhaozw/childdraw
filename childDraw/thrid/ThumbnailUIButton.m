//
//  ThumbnailUIButton.m
//  childDraw
//
//  Created by meng qian on 13-4-7.
//  Copyright (c) 2013年 thinktube. All rights reserved.
//

#import "ThumbnailUIButton.h"
#import <QuartzCore/QuartzCore.h>
#import "UIImageView+AFNetworking.h"

@interface ThumbnailUIButton()

@property(strong, nonatomic)UIImageView *avatarView;
@property(strong, nonatomic)NSArray *colorArray;
@end
@implementation ThumbnailUIButton
@synthesize avatarView;
@synthesize colorArray;
@synthesize buttonIndex;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.avatarView = [[UIImageView alloc]initWithFrame:frame];
        [self.layer setCornerRadius:10.0f];
        [self.layer setMasksToBounds:YES];
        [self.layer setBorderColor:BORDERCOLOR.CGColor];
        [self.layer setBorderWidth:1.0f];
        
        self.colorArray = [[NSArray alloc] initWithObjects:
                           RGBCOLOR(230,255,193),
                           RGBCOLOR(214,243,255),
                           RGBCOLOR(255,229,244),
                           RGBCOLOR(237,237,237),
                           RGBCOLOR(249,235,229),
                           RGBCOLOR(242,247,211),
                           RGBCOLOR(221,255,243),
                           RGBCOLOR(254,232,232),nil];
        
//        self.colorArray = [[NSArray alloc] initWithObjects:
//                           RGBCOLOR(231,117,117),
//                           RGBCOLOR(151,206,45),
//                           RGBCOLOR(117,198,231),
//                           RGBCOLOR(238,175,212),
//                           RGBCOLOR(231,158,130),
//                           RGBCOLOR(66,166,211),
//                           RGBCOLOR(136,143,154),nil];
        self.backgroundColor = [UIColor whiteColor];

        NSUInteger randomIndex = arc4random() % [self.colorArray count];
        self.backgroundColor = [UIColor clearColor];
        
        UIImage *normalImage = [self createImageWithColor:[self.colorArray objectAtIndex:randomIndex]];
        UIImage *selectedImage = [self createImageWithColor:GRAYCOLOR];
        [self setBackgroundImage:normalImage forState:UIControlStateNormal];
        [self setBackgroundImage:selectedImage forState:UIControlStateHighlighted];
    }
    return self;
}

- (UIImage *) createImageWithColor: (UIColor *) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


- (UIButtonType)buttonType
{
    return UIButtonTypeCustom;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    //
}

- (void)setAvatar:(NSString *)filename
{
    NSString *prefix = [[NSUserDefaults standardUserDefaults] objectForKey:@"thumbnail_prefix"];
    NSString *url = [NSString stringWithFormat:@"%@%@.png",prefix,filename];
    NSLog(@"URL %@",url);
//    [self.avatarView setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"icon.png"]];
//    [self addSubview:self.avatarView];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [self.avatarView setImageWithURLRequest:request
                           placeholderImage:nil
                                    success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        
        [self setImage:image forState:UIControlStateNormal];
        [self setImage:image forState:UIControlStateHighlighted];
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;


    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        //
        [self setImage:[UIImage imageNamed:@"icon.png"] forState:UIControlStateNormal];
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
