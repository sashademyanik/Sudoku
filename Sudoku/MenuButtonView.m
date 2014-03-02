//
//  MenuButtonView.m
//  Sudoku
//
//  Created by Alexander Paul Demyanik on 2/27/14.
//  Copyright (c) 2014 WSUV. All rights reserved.
//

#import "MenuButtonView.h"

@implementation MenuButtonView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self layoutSubviews];
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    static const int buttonTagsPortrait[2][6] = {
        1, 2, 3, 4, 5, 11,
        6, 7, 8, 9, 10, 12
    };
    static const int buttonTagsLandscape[6][2] = {
        1, 2,
        3, 4,
        5, 6,
        7, 8,
        9, 10,
        11, 12
    };
    const CGRect myBounds = self.bounds;
    if (myBounds.size.width > myBounds.size.height) {
        const CGSize buttonSize = CGSizeMake(myBounds.size.width/6, myBounds.size.height/2);
        for (int row = 0; row < 2; row++) {
            for (int col = 0; col < 6; col++) {
                const int tag = buttonTagsPortrait[row][col];
                UIView *button = [self viewWithTag:tag];
                button.backgroundColor = [UIColor redColor];
                [[button layer] setBorderColor:[UIColor blueColor].CGColor ];
                button.frame = CGRectMake(buttonSize.width * col, buttonSize.height * row, buttonSize.width, buttonSize.height);
            }
            
        }
    }else {
        NSLog(@"Sideways");
        const CGSize buttonSize = CGSizeMake(myBounds.size.width/2, myBounds.size.height/6);
        for (int row = 0; row < 6; row++) {
            for (int col = 0; col < 2; col++) {
                const int tag = buttonTagsLandscape[row][col];
                UIView *button = [self viewWithTag:tag];
                button.frame = CGRectMake(buttonSize.width * col, buttonSize.height * row, buttonSize.width, buttonSize.height);
            }
        }
    }
}

- (void)drawRect:(CGRect)rect
{
   
}


@end
