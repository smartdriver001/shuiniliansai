//
//  BLTextField.m
//  BasketballLeague
//
//  Created by 陈庭俊 on 14-2-27.
//  Copyright (c) 2014年 篮球大联盟  smartdriver001@163.com. All rights reserved.
//

#import "BLTextField.h"

@implementation BLTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void) drawPlaceholderInRect:(CGRect)rect  {
    
    if (self.placeholder)
    {
        
        // color of placeholder text
//        UIColor *placeHolderTextColor = [UIColor grayColor];
        
//        CGSize drawSize = [self.placeholder sizeWithAttributes:[NSDictionary dictionaryWithObject:self.font forKey:NSFontAttributeName]];
//        CGRect drawRect = rect;
        
        // verticially align text
        rect.origin.y = (rect.size.height - 20) * 0.5;
        
        // set alignment
//        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//        paragraphStyle.alignment = self.textAlignment;
        
        // dictionary of attributes, font, paragraphstyle, and color
//        NSDictionary *drawAttributes = @{NSFontAttributeName: self.font,
//                                         NSParagraphStyleAttributeName : paragraphStyle,
//                                         NSForegroundColorAttributeName : placeHolderTextColor};
        
//    (rect.size.height - drawSize.height) * 0.5
    [[UIColor grayColor] setFill];
//    [self.placeholder drawInRect:rect withFont:[UIFont boldSystemFontOfSize:17.0f]];
        
    [self.placeholder drawInRect:rect withFont:self.font];
        
        // draw
//        [self.placeholder drawInRect:drawRect withAttributes:drawAttributes];
        
    }
    
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
