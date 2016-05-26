//
//  ViewController.m
//  RequestDemo
//
//  Created by jzl on 16/5/24.
//  Copyright © 2016年 jiaozhenlong. All rights reserved.
//

#import "ViewController.h"
#import "GHPNetWorking.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    UITextView* textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-64)];
    textView.editable = NO;
    textView.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:textView];
    
    [[GHPNetWorking sharedManager] requestWithMethod:GET WithPath:@"/lookup" WithParams:@{@"country":@"cn",@"bundleId":@"com.tencent.xin"} WithSuccessBlock:^(id responseObject) {
        textView.text = [[[responseObject objectForKey:@"results"] objectAtIndex:0] objectForKey:@"description"];
    } WithFailurBlock:^(NSError *error) {
        
    } delegate:self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
