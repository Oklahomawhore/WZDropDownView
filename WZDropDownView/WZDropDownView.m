//
//  ULDropDownTextField.m
//  uluGameSDK
//
//  Created by Wangshu Zhu on 2019/2/12.
//  Copyright © 2019 ulugame. All rights reserved.
//

#import "WZDropDownView.h"

@interface WZDropDownView () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *textLabel;
@property (strong, nonatomic) UILabel *subtitleLabel;
@property (strong, nonatomic) UIView *rightView;
@property (strong, nonatomic) UITableViewCell *displayCell;

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIView *shadow;

@property (strong, nonatomic) NSArray *dataArray;
@property (strong, nonatomic) NSDictionary *selectedObject;

@property (nonatomic) BOOL isSelected;
@property (nonatomic) CGFloat tableHeightX;

@property (strong, nonatomic) void (^didSelectCompletion)(NSString* selectedText, NSInteger index, NSInteger identifier);

@end

IB_DESIGNABLE
@implementation WZDropDownView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _rowHeight = frame.size.height;
        _listHeight = 150;
        _arrowSize = 15;
        [self setupUI];
        [self displaySelectedObject];
        _isSelected = false;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupUI];
        [self displaySelectedObject];
        _isSelected = false;
    }
    return self;
}

- (void)setupUI {
    
    [self setBackgroundColor:UIColor.whiteColor];
    _displayCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"singlecell"];
    [self addSubview:self.displayCell];
    _displayCell.frame = self.bounds;
    if (self.displayCell) {
        NSLog(@"Cell exists on dropview");
        NSLog(@"Cell Frame: x: %f y: %f width:%f height: %f , Dropview Frame: x:%f y:%f width:%f height: %f",
              self.displayCell.frame.origin.x,
              self.displayCell.frame.origin.y,
              self.displayCell.frame.size.width,
              self.displayCell.frame.size.height,
              self.frame.origin.x,
              self.frame.origin.y,
              self.frame.size.width,
              self.frame.size.height);
    } else  {
        NSLog(@"Cell does not exist");
    }
    [self addGesture];
}   

- (void)displaySelectedObject {
    //展示selectedObject字典中的内容
    CGFloat height = self.frame.size.height;
    UIImageView *arrowContainerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, height, height)];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"arrowdown" ofType:@"png"];
    UIImage *arrow = [UIImage imageWithContentsOfFile:filePath];
    arrowContainerView.image = arrow;
    
    self.displayCell.accessoryView = arrowContainerView;
    self.displayCell.backgroundColor = UIColor.whiteColor;
    
    UIImage *logo = [self.selectedObject objectForKey:@"image"];
    NSString *name = [self.selectedObject objectForKey:@"name"];
    NSString *sub = [self.selectedObject objectForKey:@"lastLogin"];
    [self.displayCell.textLabel setText:name];
    [self.displayCell.detailTextLabel setText:[NSString stringWithFormat:@"上次登录：%@", sub]];
    [self.displayCell.detailTextLabel setTextColor:UIColor.lightGrayColor];
    self.displayCell.imageView.image = logo;
    
    [self addSubview:self.displayCell];
}

- (void)addGesture {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchAction:)];
    [self addGestureRecognizer:tapGesture];
}

- (void)touchAction:(id)sender {
    if (self.isSelected) {
        [self hideList];
    } else {
        [self showList];
    }
}

- (void)showList {
    _tableView = [[UITableView alloc] initWithFrame:self.frame];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.alpha = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.layer.cornerRadius = 3;
    self.tableView.backgroundColor = self.rowBackgroundColor;
    self.tableView.rowHeight = self.rowHeight;
    self.tableView.bounces = NO;
    
    self.isSelected = YES;
    
    [self.superview insertSubview:self.tableView aboveSubview:self];
    
    if (self.listHeight > self.rowHeight * (CGFloat)self.dataArray.count) {
        self.tableHeightX = self.listHeight;
    } else {
        
        self.tableHeightX = self.rowHeight * (CGFloat)self.dataArray.count;
    }
    
    [UIView animateWithDuration:0.9
                          delay:0
         usingSpringWithDamping:0.4
          initialSpringVelocity:0.1
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.tableView.frame = CGRectMake(self.frame.origin.x,
                                                           self.frame.origin.y,
                                                           self.frame.size.width,
                                                           self.tableHeightX);
                         self.tableView.alpha = 1;
                     } completion:^(BOOL finished) {
                     }];
}

- (void)hideList {
    [UIView animateWithDuration:0.9
                          delay:0
         usingSpringWithDamping:0.4
          initialSpringVelocity:0.1
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.tableView.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, 0);
                         
                     }
                     completion:^(BOOL finished) {
                         [self.tableView removeFromSuperview];
                         self.isSelected = NO;
                     }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *customCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (customCell == nil) {
        customCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    NSDictionary *userDic = self.dataArray[indexPath.row];
    UIImage *logo = [userDic objectForKey:@"image"];
    NSString *nameText = [userDic objectForKey:@"name"];
    NSString *lastLoginTime = [userDic objectForKey:@"lastLogin"];
    
    [customCell.imageView setImage:logo];
    [customCell.textLabel setText:nameText];
    [customCell.detailTextLabel setText:[NSString stringWithFormat:@"上次登录：%@", lastLoginTime]];
    [customCell.detailTextLabel setTextColor:UIColor.lightGrayColor];
    
    return customCell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self hideList];
    self.selectedIndex = indexPath.row;
    self.selectedObject = self.dataArray[indexPath.row];
    [self displaySelectedObject];
    //callback
    if (self.didSelectCompletion) {
        self.didSelectCompletion([self.selectedObject objectForKey:@"name"], indexPath.row, (NSInteger)self.optionIDs[indexPath.row]);
    }
}

- (void)didSelect:(void (^)(NSString *selectedText, NSInteger index, NSInteger identifier))callbackBlock {
    self.didSelectCompletion = callbackBlock;
}


//Getter and Setter

- (void)setOptionArray:(NSArray *)optionArray {
    _optionArray = optionArray;
    self.dataArray = self.optionArray;
    self.selectedObject = self.optionArray.firstObject;
    [self displaySelectedObject];
}

//- (void)setArrowSize:(CGFloat)arrowSize {
//    _arrowSize = arrowSize;
//    CGPoint center = _arrow.superview.center;
//    [_arrow setFrame:CGRectMake(center.x - arrowSize/2, center.y - arrowSize/2, arrowSize, arrowSize)];
//}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
