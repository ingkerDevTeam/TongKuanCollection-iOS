//
//  ProductDetailHeaderView.m
//  TongKuan
//
//  Created by Beny on 13-5-24.
//  Copyright (c) 2013年 TongKuan. All rights reserved.
//

#import "ProductDetailHeaderView.h"
#import "UIImageView+WebCache.h"

@interface ProductDetailHeaderView()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *buyButton;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@end

@implementation ProductDetailHeaderView

-(void)awakeFromNib
{
    [self.buyButton setBackgroundImage:[[UIImage imageNamed:@"btn-green.png"] stretchableImageWithLeftCapWidth:4 topCapHeight:4] forState:UIControlStateNormal];
    self.scrollView.backgroundColor = [UIColor colorWithRed:222.0/255.0 green:224.0/255.0 blue:227.0/255.0 alpha:1.0];
    self.scrollView.delegate = self;
}



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

//设置图片数组
-(void)setImagelist:(NSArray *)imagelist
{
    CGFloat originX = 0;
    for (int i=0; i<imagelist.count; i++) {
        NSString *url = [imagelist objectAtIndex:i];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(originX, 0, 320, 320)];
        [imageView setImageWithURL:[NSURL URLWithString:url]];
        [self.scrollView addSubview:imageView];
        originX = originX + 320;
    }
    self.scrollView.contentSize = CGSizeMake(originX, 320);
    self.pageControl.numberOfPages = imagelist.count;
}

#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControl.currentPage = page;
}


- (IBAction)buyButtonPressed:(id)sender {
    if ([self.delegate respondsToSelector:@selector(productDetailHeaderViewBuyButtonPressed)]) {
        [self.delegate productDetailHeaderViewBuyButtonPressed];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
