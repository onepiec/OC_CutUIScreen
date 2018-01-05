//
//  ViewController.m
//  CutUIScreen
//
//  Created by yishu on 2018/1/5.
//  Copyright © 2018年 TL. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic,strong)UIScrollView *scrollView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    [self initBtn];
    [self initScrollView];
    [self initImageView];
}
- (void)initBtn{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(20, 30, 50, 50);
    btn.backgroundColor = [UIColor redColor];
    btn.titleLabel.text = @"截屏";
    [btn addTarget:self action:@selector(cutUIScreen) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
-(void)initScrollView{
    
    self.scrollView = [[UIScrollView alloc]init];
    self.scrollView.frame = CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height -100);
    self.scrollView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.scrollView];
    if (@available(iOS 11.0, *)){
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}
-(void)initImageView{
    
    UIImageView *imageView = [[UIImageView alloc]init];
    UIImage *image = [UIImage imageNamed:@"demo.png"];
    imageView.image = image;
    imageView.frame = CGRectMake(0, 0, self.view.frame.size.width, (image.size.height/image.size.width) *self.view.frame.size.width);
    self.scrollView.contentSize = CGSizeMake( imageView.frame.size.width,imageView.frame.size.height);
    [self.scrollView addSubview:imageView];
}
- (void)cutUIScreen{
    
    UIImage *image = [self captureScrollView:self.scrollView];
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
    
}
- (UIImage *)captureScrollView:(UIScrollView *)scrollView{
    
    UIImage* image = nil;
    UIGraphicsBeginImageContext(scrollView.contentSize);
    
    CGPoint savedContentOffset = scrollView.contentOffset;
    CGRect savedFrame = scrollView.frame;
    
    scrollView.contentOffset = CGPointZero;
    scrollView.frame = CGRectMake(0, 0, scrollView.contentSize.width, scrollView.contentSize.height);
    [scrollView.layer renderInContext: UIGraphicsGetCurrentContext()];
    image = UIGraphicsGetImageFromCurrentImageContext();
    
    scrollView.contentOffset = savedContentOffset;
    scrollView.frame = savedFrame;
    UIGraphicsEndImageContext();
    
    return image;
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    
    NSLog(@"image = %@, error = %@, contextInfo = %@", image, error, contextInfo);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
