//
//  ViewController.m
//  TestKVO
//
//  Created by yenkai huang on 2014/5/16.
//  Copyright (c) 2014年 yenkai huang. All rights reserved.
//

#import "ViewController.h"

#import "StockObject.h"

@interface ViewController ()

@end

@implementation ViewController{
    StockObject *stock;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    stock = [[StockObject alloc] init];
    stock.stockName = @"Apple";
    stock.price = @"100";
    
    [self setStockLabelWithStockObject:stock];
    
    // KVO
    [stock addObserver:self forKeyPath:@"price" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnPress:(id)sender {
    int priceInt = [stock.price intValue];
    priceInt = priceInt + 1;
    stock.price = [NSString stringWithFormat:@"%d", priceInt];
}

- (void) setStockLabelWithStockObject:(StockObject *)stockObject{
    [self.stockLabel setText:[NSString stringWithFormat:@"%@:$%@", stockObject.stockName, stockObject.price]];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    NSLog(@"keyPath = %@", keyPath);
    if ([keyPath isEqualToString:@"price"]) {
        NSLog(@"object =%@", object);
        NSLog(@"change =%@", change);
        [self setStockLabelWithStockObject:stock];
    }
}

@end
