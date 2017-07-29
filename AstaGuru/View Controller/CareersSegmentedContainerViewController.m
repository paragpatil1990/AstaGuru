//
//  SegmentedContainerViewController.m
//  XLMailBoxContainer ( https://github.com/xmartlabs/XLMailBoxContainer )
//
//  Copyright (c) 2014 Xmartlabs ( http://xmartlabs.com )
//
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "CareersSegmentedContainerViewController.h"
#import "WhyAstaGuruViewController.h"
#import "VacanciesViewController.h"

@interface CareersSegmentedContainerViewController ()

@end

@implementation CareersSegmentedContainerViewController

-(void)setUpNavigationItem
{
    self.title=@"Careers";
    [self setNavigationBarSlideButton];//Target:<#(id)#> selector:<#(SEL)#>]
    [self setNavigationBarCloseButton];
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.skipIntermediateViewControllers = NO;
    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpNavigationItem];
}

#pragma mark - XLSwipe

-(NSArray *)swipeContainerControllerViewControllers:(XLSwipeContainerController *)swipeContainerController
{
    // create child view controllers that will be managed by XLSwipeContainerController
    WhyAstaGuruViewController *child_1 = [self.storyboard instantiateViewControllerWithIdentifier:@"WhyAstaGuruViewController"];
    VacanciesViewController *child_2 = [self.storyboard instantiateViewControllerWithIdentifier:@"VacanciesViewController"];
        return @[child_1, child_2];
}


@end
