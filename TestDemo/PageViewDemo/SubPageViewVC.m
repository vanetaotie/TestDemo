//
//  SubPageViewVC.m
//  TestDemo
//
//  Created by vane on 2019/5/5.
//  Copyright © 2019 vane.greenisland. All rights reserved.
//

#import "SubPageViewVC.h"

@interface SubPageViewVC ()

@property (nonatomic, strong) UILabel *infoLabel;
@property (nonatomic, copy) NSString *infoStr;

@end

@implementation SubPageViewVC

- (instancetype)initWithPageNumber:(NSInteger)pageNum {
    self = [super init];
    if (self) {
        self.infoStr = [NSString stringWithFormat:@"当前页--%ld", (long)pageNum];
        NSArray *colors = @[[UIColor redColor], [UIColor blueColor], [UIColor greenColor], [UIColor cyanColor], [UIColor magentaColor]];
        self.view.backgroundColor = colors[pageNum%5];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.infoLabel];
    [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
    }];
    
    self.infoLabel.text = self.infoStr;
}

- (UILabel *)infoLabel {
    if (!_infoLabel){
        _infoLabel = [[UILabel alloc] init];
        _infoLabel.textAlignment = NSTextAlignmentCenter;
        _infoLabel.font = [UIFont systemFontOfSize:20.0];
    }
    return _infoLabel;
}

@end
