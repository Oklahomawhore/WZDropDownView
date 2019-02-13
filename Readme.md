# WZDropDownView

A Simple Drop Down Menu that is easy to use, and easy to customize.


Created by W.Zhu


## Installation

Drag WZDropDownView.h and WZDropDownView.m into your project.

import custom arrow with the name "arrowdown.png" or use the one in this repository(that is not good-looking)

#import "WZDropDownView.h" where you want to use it

and you are good to go...

## example

The example is included in this repository.

```
    _dropView = [[ULDropDownView alloc] initWithFrame:CGRectMake(200, 40, 300, 60)];
    NSString *logoPath = [[NSBundle mainBundle] pathForResource:@"网易Logo" ofType:@"jpg"];
    UIImage *logo = [UIImage imageWithContentsOfFile:logoPath];
    NSString *name = @"freewaterzws";
    NSString *lastLogin = @"2017年12月12日";
    
    NSDictionary *dic = @{@"name" : name,
                          @"image" : logo,
                          @"lastLogin" : lastLogin
                          };
    
    _dropView.optionArray = @[dic, dic, dic];
    _dropView.optionIDs = @[100, 120, 140];
    [_dropView didSelect:^(NSString * _Nonnull selectedText, NSInteger index, NSInteger identifier) {
        NSLog(@"登录用户： %@", selectedText);
    }];
    [self.view addSubview:_dropView];
```

## Author

Wangshu Zhu email: killnobody0514@gmail.com
