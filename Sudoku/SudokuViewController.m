//
//  SudokuViewController.m
//  Sudoku
//
//  Created by Alexander Paul Demyanik on 2/20/14.
//  Copyright (c) 2014 WSUV. All rights reserved.
//

#import "SudokuViewController.h"


@interface SudokuViewController () <UIActionSheetDelegate>

@end

@implementation SudokuViewController{
    NSArray *simpleGames;
    NSArray *hardGames;
    BOOL lock;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.sudokuModel = [[SudokuModel alloc] init];
    self.BoardView.model = self.sudokuModel;
    lock = NO;
    _selectedRow = _selectedColumn = -1;
    NSString *pathSimple = [[NSBundle mainBundle] pathForResource:@"simple" ofType:@"plist"];
    simpleGames = [[NSArray alloc] initWithContentsOfFile:pathSimple];
    NSString *pathHard = [[NSBundle mainBundle] pathForResource:@"hard" ofType:@"plist"];
    hardGames = [[NSArray alloc] initWithContentsOfFile:pathHard];
    
    NSString *newGame = [self randomGame:simpleGames];
    [self.sudokuModel freshGame:newGame];
    //[self.sudokuModel freshGame:@"37486159285924376121657938449871523652369417816738245968143792574295681393512864."];

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
    if (col != _selectedColumn || row != _selectedRow) {
        if (self.sudokuModel != nil && ![self.sudokuModel numberIsFixedAtRow:row Column:col]) {
            NSLog(@"tapped square at row %d, col %d",row,col);
            _selectedColumn = col;
            _selectedRow = row;
            [self.BoardView setRow:self.selectedRow Col:self.selectedColumn];
            [self.BoardView setNeedsDisplay];
        }
        
    }
}

- (IBAction)buttonPressed:(UIButton*)sender {
    if (sender.tag >=1 && sender.tag <= 9) {
        if (self.selectedColumn != -1 && self.selectedRow != -1 && !lock) {
            if (self.ButtonView.pencil) {
                if ([self.sudokuModel isSetPencil:sender.tag AtRow:self.selectedRow Column:self.selectedColumn]) {
                    [self.sudokuModel clearPencil:sender.tag AtRow:self.selectedRow Column:self.selectedColumn];
                }else{
                    [self.sudokuModel setPencil:sender.tag AtRow:self.selectedRow Column:self.selectedColumn];
                }
                
                
                //[self.BoardView];
            }else{
                [self.sudokuModel setNumber:sender.tag AtRow:self.selectedRow Column:self.selectedColumn];
                if (![self.sudokuModel isConflictingEntryAtRow:self.selectedRow Column:self.selectedColumn]) {
                    [self.sudokuModel setConflictRow:self.selectedRow Column:self.selectedColumn Num:0];
                }else{
                    [self.sudokuModel setConflictRow:self.selectedRow Column:self.selectedColumn Num:1];
                }
                if ([self.sudokuModel isWon]) {
                    [self winAlert:self];
                    lock = YES;
                }
            }
        }
        
    }else if (sender.tag == 10 && !lock){
        if (self.ButtonView.pencil ==YES) {
            self.ButtonView.pencil = NO;
            sender.backgroundColor = [UIColor whiteColor];
        }else{
            self.ButtonView.pencil = YES;
            sender.backgroundColor = [UIColor lightGrayColor];
        }
    }else if (sender.tag == 11){
        if (self.selectedRow != -1 && self.selectedColumn != -1) {
            if ([self.sudokuModel anyPencilsSetAtRow:self.selectedRow Column:self.selectedColumn]) {
                [self clearWarning:self];
                //[self.sudokuModel clearAllPencilsAtRow:self.selectedRow Column:self.selectedColumn];
            }else{
                [self.sudokuModel setNumber:0 AtRow:self.selectedRow Column:self.selectedColumn];
                [self.sudokuModel setConflictRow:self.selectedRow Column:self.selectedColumn Num:0];
            }
            
        }
    }else if (sender.tag == 12){
        UIActionSheet *menu = [[UIActionSheet alloc] initWithTitle:@"Menu"
                                                          delegate:self
                                                 cancelButtonTitle:@"Kancel"
                                            destructiveButtonTitle:nil
                                                 otherButtonTitles:@"New Easy Game", @"New Hard Game", @"Clear Conflicting Cells",@"Clear All Cells", nil];
        [menu showInView:self.view];
    }
    [self.ButtonView setNeedsDisplay];
    [self.BoardView setNeedsDisplay];
    
}

-(void)clearWarning:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning!"
                                                    message:@"Do you want to clear all pencil marks?"
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"Yes", nil];
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if([alertView.title isEqualToString:@"Warning!"]){
        if(buttonIndex != 0){
            [self.sudokuModel clearAllPencilsAtRow:self.BoardView.selectedRow Column:self.BoardView.selectedColumn];
            [self.BoardView setNeedsDisplay];
        }
    }
}

-(void)winAlert:(id)sender{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Congratulations!" message:@"You have won!" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
    [alert show];
}

-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    NSLog(@"actionSheet:didDismissWithButtonIndex: %d", buttonIndex);
    if (buttonIndex == 0) {
        NSString *newGame = [self randomGame:simpleGames];
        [self.sudokuModel freshGame:newGame];
        lock = NO;
    }else if (buttonIndex == 1){
        NSString *newGame = [self randomGame:hardGames];
        [self.sudokuModel freshGame:newGame];
        lock = NO;
    }else if (buttonIndex == 2){
        for (int i = 0; i < 9; i++) {
            for (int j = 0; j < 9; j++) {
                int con = [self.sudokuModel getConflictRow:i Column:j];
                if (con == 1) {
                    [self.sudokuModel setNumber:0 AtRow:i Column:j];
                    [self.sudokuModel setConflictRow:i Column:j Num:0];
                }
            }
        }
        
    }else if (buttonIndex == 3){
        for (int i = 0; i < 9; i++) {
            for (int j = 0; j < 9; j++) {
                int fix = [self.sudokuModel getFixedIndexRow:i Column:j];
                if (fix == 0) {
                    [self.sudokuModel setNumber:0 AtRow:i Column:j];
                    [self.sudokuModel setConflictRow:i Column:j Num:0];
                }
            }
        }
    }
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
