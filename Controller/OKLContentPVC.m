//
//  OKLContentPVC.m
//  OKLWeather
//
//  Created by YanqingLee on 16/9/7.
//  Copyright © 2016年 YanqingLee. All rights reserved.
//

#import "OKLContentPVC.h"




@interface OKLContentPVC ()
@property (nonatomic, strong) UILabel *contentLabel;
@end

@implementation OKLContentPVC

- (void)viewDidLoad{
    [super viewDidLoad];
//    self.view.backgroundColor = kRandomColor;
    _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, self.view.bounds.size.width, 100)];
    _contentLabel.numberOfLines = 0;
//    _contentLabel.backgroundColor = kRandomColor;
    [self.view addSubview:_contentLabel];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshLabelShow:) name:kLocateAddressSuccessNotification object:nil];
}

- (void) viewWillAppear:(BOOL)paramAnimated{
    [super viewWillAppear:paramAnimated];
    _contentLabel.text = _content;
}

#pragma mark - Notificaiton Methods
- (void)refreshLabelShow:(NSNotification *)notification {
    _contentLabel.text = notification.userInfo[@"City"];
    _contentLabel.textAlignment = NSTextAlignmentCenter;
}


@end
