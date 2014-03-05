//
//  SudokuViewController.m
//  Sudoku
//
//  Created by Alexander Paul Demyanik on 2/20/14.
//  Copyright (c) 2014 WSUV. All rights reserved.
//

#import "SudokuViewController.h"


@interface SudokuViewController ()

@end

@implementation SudokuViewController{
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.sudokuModel = [[SudokuModel alloc] init];
    self.BoardView.model = self.sudokuModel;
    _selectedRow = _selectedColumn = -1;
    NSArray *simpleGames;
    NSString *pathSimple = [[NSBundle mainBundle] pathForResource:@"simple" ofType:@"plist"];
    simpleGames = [[NSArray alloc] initWithContentsOfFile:pathSimple];
    NSString *newGame = [self randomGame:simpleGames];
    [self.sudokuModel freshGame:newGame];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString*)randomGame:(NSArray*) game {
    const int n = [game count];
    const int i = arc4random() % n;
    return [game objectAtIndex:i];
}

-(IBAction)handleTap:(UITapGestureRecognizer*)sender{
    NSLog(@"handleTap");
    const CGRect square = [self.BoardView boardSquare];
    const CGPoint tapPoint = [sender locationInView:_BoardView];
    const CGFloat squareSize = square.size.width/9;
    const int col = floor((tapPoint.x - square.origin.x)/squareSize);
    const int row = floor((tapPoint.y - square.origin.y)/squareSize);
    [self.BoardView setRow:self.selectedRow Col:self.selectedColumn];
    if (col != _selectedColumn || row != _selectedRow) {
        if (self.sudokuModel != nil && ![self.sudokuModel numberIsFixedAtRow:row Column:col]) {
            NSLog(@"tapped square at row %d, col %d",row,col);
            _selectedColumn = col;
            _selectedRow = row;
            [self.BoardView setNeedsDisplay];
        }
        
    }
}

- (IBAction)buttonPressed:(UIButton*)sender {
    if (sender.tag >=1 && sender.tag <= 9) {
        if (_selectedColumn != -1 && _selectedRow != -1) {
            //
            [self.sudokuModel setNumber:sender.tag AtRow:self.selectedRow Column:self.selectedColumn];
            [self.BoardView drawNumAtRow:self.selectedRow Column:self.selectedColumn Number:sender.tag];
        }
    }else if (sender.tag == 10){
        if (self.ButtonView.pencil ==YES) {
            self.ButtonView.pencil = NO;
            sender.backgroundColor = [UIColor whiteColor];
        }else{
            self.ButtonView.pencil = YES;
            sender.backgroundColor = [UIColor lightGrayColor];
        }
    }else if (sender.tag == 11){
        
    }else if (sender.tag == 12){
        
    }
    [self.ButtonView setNeedsDisplay];
    [self.BoardView setNeedsDisplay];
    
}




-(void)viewWillLayoutSubviews {
    
    const CGRect statusBarFrame = [UIApplication sharedApplication].statusBarFrame;
    const CGRect viewBounds = self.view.bounds;
    const bool isPortrait = viewBounds.size.height >= viewBounds.size.width;
    
    if(isPortrait) {
        const CGFloat statusBarHeight = statusBarFrame.size.height;
        const float boardSize = viewBounds.size.width;
        const float buttonHeight = viewBounds.size.height - boardSize - statusBarHeight;
        _BoardView.frame = CGRectMake(0, statusBarHeight, boardSize, boardSize);
        _ButtonView.frame = CGRectMake(0, boardSize + statusBarHeight, boardSize, buttonHeight);
    }else {
        const CGFloat statusBarHeight = statusBarFrame.size.width;
        const float boardSize = viewBounds.size.height - statusBarHeight;
        const float buttonsWidth = viewBounds.size.width - boardSize;
        _BoardView.frame = CGRectMake(0, statusBarHeight, boardSize, boardSize);
        _ButtonView.frame = CGRectMake(boardSize, statusBarHeight, buttonsWidth, boardSize);
    }
   
}


@end
