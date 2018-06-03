//
//  UIView+Constraints.m
//  Vibereel
//
//  Created by Abdullah Bakhach on 9/12/14.
//  Copyright (c) 2014 tohtt. All rights reserved.
//

#import "UIView+Constraints.h"
#import "NSArray+Addons.h"
#import "VBAppSettings.h"

#import <CocoaLumberjack/DDLog.h>
#import "VBCustomLoggers.h"
#import "VBGlobalDebugLevel.h"

@implementation UIView (Constraints)


-(void)createConstraintFormats:(NSArray *)constraintsFormats withBindingDict:(NSDictionary *)bindingDictionary withOrderedViewsArray:(NSArray *)orderedViews isAnimated:(BOOL)isAnimated {

    if (!orderedViews) {
        // if no order is defined.. we pick them
        // randomly from the binding dictionary
        orderedViews = [bindingDictionary allValues];
    }

    [orderedViews mapObjectsApplyingBlock:^(UIView *view) {
        UIView *superview = [view superview];
        [view removeFromSuperview];
        [view setTranslatesAutoresizingMaskIntoConstraints:NO];
        [view setHidden:NO];
        [superview addSubview:view];
    }];

    NSArray *constraints = [constraintsFormats mapObjectsUsingBlock:^id(NSString *formatString, NSUInteger idx){
        return [NSLayoutConstraint constraintsWithVisualFormat:formatString options:0 metrics:nil views:bindingDictionary];
    }];

    [self addConstraints:[constraints flattenArray]];

    if (isAnimated) {
        [self layoutIfNeeded];
    }

}

-(void)createConstraintFormats:(NSArray *)constraintsFormats withBindingDict:(NSDictionary *)bindingDictionary isAnimated:(BOOL)isAnimated {
    [self createConstraintFormats:constraintsFormats withBindingDict:bindingDictionary withOrderedViewsArray:nil isAnimated:isAnimated];
}

-(void)addConstraintFormats:(NSArray *)constraintsFormats withBindingDict:(NSDictionary *)bindingDictionary isAnimated:(BOOL)isAnimated {
    NSArray *views = [bindingDictionary allValues];
    [views mapObjectsApplyingBlock:^(UIView *view) {
        [view setTranslatesAutoresizingMaskIntoConstraints:NO];
        [view setHidden:NO];
    }];

    NSArray *constraints = [constraintsFormats mapObjectsUsingBlock:^id(NSString *formatString, NSUInteger idx){
        return [NSLayoutConstraint constraintsWithVisualFormat:formatString options:0 metrics:nil views:bindingDictionary];
    }];

    [self addConstraints:[constraints flattenArray]];

    if (isAnimated) {
        [self layoutIfNeeded];
    }
}

#pragma mark - native constraints

- (void)setWidthContraintToConstant:(CGFloat)width
{
    NSLayoutConstraint *cn = [NSLayoutConstraint constraintWithItem:self
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1 constant:width];

    [self addConstraint:cn];
}

- (void)setWidthContraintToConstant:(CGFloat)width withRelationship:(NSLayoutRelation)relation
{
    NSLayoutConstraint *cn = [NSLayoutConstraint constraintWithItem:self
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:relation
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1 constant:width];

    [self addConstraint:cn];
}

- (void)setHeightContraintToConstant:(CGFloat)height
{
    NSLayoutConstraint *cn = [NSLayoutConstraint constraintWithItem:self
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1 constant:height];

    [self addConstraint:cn];
}

- (void)setWidthEqualityToView:(UIView *)view constant:(CGFloat)width
{
    NSLayoutConstraint *cn = [NSLayoutConstraint constraintWithItem:self
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:view
                                                          attribute:NSLayoutAttributeWidth
                                                         multiplier:1 constant:width];

    [self addConstraint:cn];
}

- (void)setHeightEqualityToView:(UIView *)view constant:(CGFloat)height
{
    NSLayoutConstraint *cn = [NSLayoutConstraint constraintWithItem:self
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:view
                                                          attribute:NSLayoutAttributeHeight
                                                         multiplier:1 constant:height];

    [self addConstraint:cn];
}


- (void)constraintWidthEqualTo:(UIView *)toView constant:(CGFloat)constant
{
    NSLayoutConstraint *cn = [NSLayoutConstraint constraintWithItem:self
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:toView
                                                          attribute:NSLayoutAttributeWidth
                                                         multiplier:1 constant:constant];

    [toView addConstraint:cn];
}

- (void)constraintWidthOfView:(UIView *)fromView EqualTo:(UIView *)toView constant:(CGFloat)constant
{
    NSLayoutConstraint *cn = [NSLayoutConstraint constraintWithItem:fromView
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:toView
                                                          attribute:NSLayoutAttributeWidth
                                                         multiplier:1 constant:constant];

    [self addConstraint:cn];
}

- (void)constraintHeightEqualTo:(UIView *)toView constant:(CGFloat)constant
{
    NSLayoutConstraint *cn = [NSLayoutConstraint constraintWithItem:self
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:toView
                                                          attribute:NSLayoutAttributeHeight
                                                         multiplier:1 constant:constant];

    [toView addConstraint:cn];
}

- (NSLayoutConstraint *)constraintBottomEqualTo:(UIView *)toView constant:(CGFloat)constant
{
    NSLayoutConstraint *cn = [NSLayoutConstraint constraintWithItem:self
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:toView
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1 constant:constant];

    [toView addConstraint:cn];
    return cn;
}

- (void)setBottomConstraintOfViews:(UIView *)superview subView:(UIView *)subivew constant:(CGFloat)constant
{
    NSLayoutConstraint *cn1 = [NSLayoutConstraint constraintWithItem:superview
                                                           attribute:NSLayoutAttributeBottom
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:subivew
                                                           attribute:NSLayoutAttributeBottom
                                                          multiplier:1 constant:constant];

    [self addConstraint:cn1];

}

- (NSLayoutConstraint *)constraintTopEqualTo:(UIView *)toView constant:(CGFloat)constant withRelation:(NSLayoutRelation)relation
{
    NSLayoutConstraint *cn = [NSLayoutConstraint constraintWithItem:self
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:relation
                                                             toItem:toView
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1 constant:constant];

    [toView addConstraint:cn];
    return cn;
}

- (NSLayoutConstraint *)constraintBottomEqualTo:(UIView *)toView constant:(CGFloat)constant withRelation:(NSLayoutRelation)relation
{
    NSLayoutConstraint *cn = [NSLayoutConstraint constraintWithItem:self
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:relation
                                                             toItem:toView
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1 constant:constant];

    [toView addConstraint:cn];
    return cn;
}




- (NSLayoutConstraint *)constraintTopEqualTo:(UIView *)toView constant:(CGFloat)constant
{
    NSLayoutConstraint *cn = [NSLayoutConstraint constraintWithItem:self
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:toView
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1 constant:constant];

    [toView addConstraint:cn];
    return cn;
}


- (id)constraintLeadingEqualTo:(UIView *)toView constant:(CGFloat)constant
{
    NSLayoutConstraint *cn = [NSLayoutConstraint constraintWithItem:self
                                                          attribute:NSLayoutAttributeLeading
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:toView
                                                          attribute:NSLayoutAttributeLeading
                                                         multiplier:1 constant:constant];

    [toView addConstraint:cn];
    return self;
}

- (NSLayoutConstraint *)constraintTrailingEqualTo:(UIView *)toView constant:(CGFloat)constant
{
    NSLayoutConstraint *cn = [NSLayoutConstraint constraintWithItem:self
                                                          attribute:NSLayoutAttributeTrailing
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:toView
                                                          attribute:NSLayoutAttributeTrailing
                                                         multiplier:1 constant:constant];

    [toView addConstraint:cn];
    return cn;
}

- (void)constraintLeftEqualTo:(UIView *)toView constant:(CGFloat)constant
{
    NSLayoutConstraint *cn = [NSLayoutConstraint constraintWithItem:self
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:toView
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1 constant:constant];

    [toView addConstraint:cn];
}


- (void)constraintLeftOfView:(UIView *)fromView equalTo:(UIView *)toView constant:(CGFloat)constant
{
    NSLayoutConstraint *cn = [NSLayoutConstraint constraintWithItem:fromView
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:toView
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1 constant:constant];

    [self addConstraint:cn];
}

- (void)constraintTrailingAndLeadingMakesCenterTo:(UIView *)toView havingWidth:(CGFloat)viewWidth
{
    CGFloat screenWidth = [VBAppSettings screenWidth];
    CGFloat paddingConstraint = (screenWidth - viewWidth)/2;

    NSLayoutConstraint *lcn = [NSLayoutConstraint constraintWithItem:self
                                                           attribute:NSLayoutAttributeLeading
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:toView
                                                           attribute:NSLayoutAttributeLeading
                                                          multiplier:1 constant:paddingConstraint];

    [toView addConstraint:lcn];

    NSLayoutConstraint *rcn = [NSLayoutConstraint constraintWithItem:toView
                                                           attribute:NSLayoutAttributeTrailing
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self
                                                           attribute:NSLayoutAttributeTrailing
                                                          multiplier:1 constant:paddingConstraint];

    [toView addConstraint:rcn];
}

- (void)constraintTopAndBottomMakesCenterTo:(UIView *)toView havingHeight:(CGFloat)viewHeight
{
    CGFloat screenHeight = [VBAppSettings screenHeight];
    CGFloat paddingConstraint = (screenHeight - viewHeight)/2;

    NSLayoutConstraint *tcn = [NSLayoutConstraint constraintWithItem:self
                                                           attribute:NSLayoutAttributeTop
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:toView
                                                           attribute:NSLayoutAttributeTop
                                                          multiplier:1 constant:paddingConstraint];

    [toView addConstraint:tcn];

    NSLayoutConstraint *bcn = [NSLayoutConstraint constraintWithItem:toView
                                                           attribute:NSLayoutAttributeBottom
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self
                                                           attribute:NSLayoutAttributeBottom
                                                          multiplier:1 constant:paddingConstraint];

    [toView addConstraint:bcn];
}

- (void)constraintRightEqualTo:(UIView *)toView constant:(CGFloat)constant
{
    NSLayoutConstraint *cn = [NSLayoutConstraint constraintWithItem:self
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:toView
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1 constant:constant];

    [toView addConstraint:cn];
}

- (void)alignTopView:(UIView *)view withView:(UIView *)otherView
{
    NSLayoutConstraint *cn = [NSLayoutConstraint constraintWithItem:view
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:otherView
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1 constant:0];

    [self addConstraint:cn];
}


- (NSLayoutConstraint *)constraintCenterXEqualTo:(UIView *)toView constant:(CGFloat)constant
{
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSLayoutConstraint *cn = [NSLayoutConstraint constraintWithItem:self
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:toView
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1 constant:constant];

    [toView addConstraint:cn];
    return cn;
}

- (NSLayoutConstraint *)constraintCenterXOfView:(UIView *)fromView equalToView:(UIView *)toView constant:(CGFloat)constant
{
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSLayoutConstraint *cn = [NSLayoutConstraint constraintWithItem:fromView
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:toView
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1 constant:constant];

    [self addConstraint:cn];
    return cn;
}

- (NSLayoutConstraint *)constraintCenterYEqualTo:(id)toView constant:(CGFloat)constant
{
    NSLayoutConstraint *cn = [NSLayoutConstraint constraintWithItem:self
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:toView
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1 constant:constant];

    [toView addConstraint:cn];
    return cn;
}

- (NSLayoutConstraint *)constraintCenterYOfView:(UIView *)fromView equalToView:(UIView *)toView constant:(CGFloat)constant
{
    NSLayoutConstraint *cn = [NSLayoutConstraint constraintWithItem:fromView
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:toView
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1 constant:constant];

    [self addConstraint:cn];
    return cn;
}

- (void)centerViewToParent:(UIView *)toView
{
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self constraintCenterXEqualTo:toView constant:0];
    [self constraintCenterYEqualTo:toView constant:0];
}

- (void)setConstraintWidth:(CGFloat)width height:(CGFloat)height
{
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self setWidthContraintToConstant:width];
    [self setHeightContraintToConstant:height];
}

- (void)setOrAdjustConstraintWidth:(CGFloat)width height:(CGFloat)height
{
    if ([self containsSelfConstraintAttribute:NSLayoutAttributeWidth] && [self containsSelfConstraintAttribute:NSLayoutAttributeHeight]) {
        [self adjustConstraintsWidth:width andHeight:height];
    } else {
        [self setConstraintWidth:width height:height];
    }
}

- (void)setConstraintsWidth:(CGFloat)width height:(CGFloat)height left:(CGFloat)left top:(CGFloat)top toView:(UIView *)toView
{
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self setWidthContraintToConstant:width];
    [self setHeightContraintToConstant:height];
    [self constraintLeftEqualTo:toView constant:left];
    [self constraintTopEqualTo:toView constant:top];
}

- (void)cloneSizeAndOriginOfView:(UIView *)view
{
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self constraintWidthEqualTo:view constant:0];
    [self constraintHeightEqualTo:view constant:0];
    [self constraintCenterXEqualTo:view constant:0];
    [self constraintCenterYEqualTo:view constant:0];
}

- (void)pinBordersToView:(UIView *)view
{
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self constraintTopEqualTo:view constant:0];
    [self constraintBottomEqualTo:view constant:0];
    [self constraintLeadingEqualTo:view constant:0];
    [self constraintTrailingEqualTo:view constant:0];
    [self setNeedsLayout];
}

- (void)constrainSelfToScrollView:(UIScrollView*)sv
{
    [self constrainSelfToScrollView:sv top:0 trailing:0 bottom:0 leading:0];
}

- (void)constrainSelfToScrollView:(UIScrollView*)sv top:(CGFloat)top trailing:(CGFloat)trailing bottom:(CGFloat)bottom leading:(CGFloat)leading
{
    sv.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:sv attribute:NSLayoutAttributeLeading multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:sv attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:sv attribute:NSLayoutAttributeTrailing multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:sv attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
}

- (void)constrainScrollViewToSelf:(UIScrollView *)sv
{
    [self constrainScrollViewToSelf:sv top:0 trailing:0 bottom:0 leading:0];
}

- (void)constrainScrollViewToSelf:(UIScrollView *)sv top:(CGFloat)top trailing:(CGFloat)trailing bottom:(CGFloat)bottom leading:(CGFloat)leading
{
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [sv addConstraint:[NSLayoutConstraint constraintWithItem:sv attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self  attribute:NSLayoutAttributeLeading multiplier:1 constant:-leading]];
    [sv addConstraint:[NSLayoutConstraint constraintWithItem:sv attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1 constant:-trailing]];
    [sv addConstraint:[NSLayoutConstraint constraintWithItem:sv attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:-top]];
    [sv addConstraint:[NSLayoutConstraint constraintWithItem:sv attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:bottom]];
    [sv addConstraint:[NSLayoutConstraint constraintWithItem:sv attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1 constant:(leading+trailing)]];
}

- (void)constrainScrollViewToSelf:(UIScrollView *)sv top:(CGFloat)top trailing:(CGFloat)trailing leading:(CGFloat)leading
{
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [sv addConstraint:[NSLayoutConstraint constraintWithItem:sv attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self  attribute:NSLayoutAttributeLeading multiplier:1 constant:-leading]];
    [sv addConstraint:[NSLayoutConstraint constraintWithItem:sv attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1 constant:-trailing]];
    [sv addConstraint:[NSLayoutConstraint constraintWithItem:sv attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:-top]];
    [sv addConstraint:[NSLayoutConstraint constraintWithItem:sv attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1 constant:(leading+trailing)]];
}

- (void)constrainScrollViewToSelf:(UIScrollView *)sv bottom:(CGFloat)bottom
{
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [sv addConstraint:[NSLayoutConstraint constraintWithItem:sv attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:bottom]];
}

- (void)pinBordersToView:(UIView *)view top:(CGFloat)top trailing:(CGFloat)trailing bottom:(CGFloat)bottom leading:(CGFloat)leading
{
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self constraintTopEqualTo:view constant:top];
    [self constraintBottomEqualTo:view constant:bottom];
    [self constraintLeadingEqualTo:view constant:leading];
    [self constraintTrailingEqualTo:view constant:trailing];
}

- (void)setConstraintsWidth:(CGFloat)width height:(CGFloat)height left:(CGFloat)left bottom:(CGFloat)bottom toView:(UIView *)toView
{
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self setWidthContraintToConstant:width];
    [self setHeightContraintToConstant:height];
    [self constraintLeftEqualTo:toView constant:left];
    [self constraintBottomEqualTo:toView constant:bottom];
}

- (void)setConstraintsWidth:(CGFloat)width height:(CGFloat)height right:(CGFloat)right bottom:(CGFloat)bottom toView:(UIView *)toView
{
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self setWidthContraintToConstant:width];
    [self setHeightContraintToConstant:height];
    [self constraintRightEqualTo:toView constant:right];
    [self constraintBottomEqualTo:toView constant:bottom];
}

- (void)setConstraintsWidth:(CGFloat)width height:(CGFloat)height right:(CGFloat)right top:(CGFloat)top toView:(UIView *)toView
{
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self setWidthContraintToConstant:width];
    [self setHeightContraintToConstant:height];
    [self constraintRightEqualTo:toView constant:right];
    [self constraintTopEqualTo:toView constant:top];
}

- (void)constraintHorizontalSpacingSubviewsFrom:(UIView *)fromView to:(UIView *)toView constant:(CGFloat)constant
{
    NSLayoutConstraint *cn = [NSLayoutConstraint constraintWithItem:fromView
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:toView
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1
                                                           constant:constant];
    [self addConstraint:cn];
}

- (void)constraintHorizontalSpacingSubviewsFromRightView:(UIView *)rightView toLeftView:(UIView *)leftView constant:(CGFloat)constant
{
    NSLayoutConstraint *cn = [NSLayoutConstraint constraintWithItem:rightView
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:leftView
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1
                                                           constant:constant];
    [self addConstraint:cn];
}

- (NSLayoutConstraint *)constraintHorizontalSpacingSubviewsFromLeftView:(UIView *)leftView toRightView:(UIView *)rightView constant:(CGFloat)constant
{
    NSLayoutConstraint *cn = [NSLayoutConstraint constraintWithItem:leftView
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:rightView
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1
                                                           constant:-constant];
    [self addConstraint:cn];
    return cn;
}



- (void)constraintVerticalSpacingSubviewsFromBottomView:(UIView *)fromView toTopView:(UIView *)toView constant:(CGFloat)constant

{
    NSLayoutConstraint *cn = [NSLayoutConstraint constraintWithItem:fromView
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:toView
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1
                                                           constant:constant];
    [self addConstraint:cn];
}

- (void)constraintVerticalSpacingSubviewsFromBottomView:(UIView *)fromView toTopView:(UIView *)toView constant:(CGFloat)constant relation:(NSLayoutRelation)relation
{
    NSLayoutConstraint *cn = [NSLayoutConstraint constraintWithItem:fromView
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:relation
                                                             toItem:toView
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1
                                                           constant:constant];
    [self addConstraint:cn];
}

- (void)constraintVerticalSpacingSubviewsFromTopView:(UIView *)fromView toBottomView:(UIView *)toView constant:(CGFloat)constant
{
    NSLayoutConstraint *cn = [NSLayoutConstraint constraintWithItem:fromView
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:toView
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1
                                                           constant:-constant];
    [self addConstraint:cn];
}

- (void)removeSubviews
{
    for (UIView *view in [self subviews]) {
        [view removeFromSuperview];
    }
}

- (void)removeSubviewsApartFromView:(UIView *)exceptionView
{
    for (UIView *view in [self subviews]) {
        if (![view isEqual:exceptionView]) {
            [view removeFromSuperview];
        }
    }
}

- (void)hideSubviewsApartFromView:(UIView *)exceptionView
{
    for (UIView *view in [self subviews]) {
        if (![view isEqual:exceptionView]) {
            [view setHidden:YES];
        }
    }
}

# pragma mark - adjust existing constraints

- (BOOL)containsSelfConstraintAttribute:(NSLayoutAttribute)attribute
{
    for (NSLayoutConstraint *constraint in [self constraints]) {
        if ([constraint firstAttribute] == attribute) {
            return YES;
        }
    }

    return NO;
}
- (void)adjustSelfConstraintWithFirstAttribute:(NSLayoutAttribute)attribute to:(CGFloat)constant
{
    [self adjustSelfConstraintWithFirstAttribute:attribute to:constant layout:YES];
}

- (void)adjustSelfConstraintWithFirstAttribute:(NSLayoutAttribute)attribute to:(CGFloat)constant layout:(BOOL)layout
{
    for (NSLayoutConstraint *constraint in [self constraints]) {
        if ([constraint firstAttribute] == attribute) {
            constraint.constant = constant;
            if (layout)
                [self layoutIfNeeded];
            return;
        }
    }


    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:@"view doesn't have constraint that needs to be adjusted"
                                 userInfo:@{@"view": self,
                                            @"attribute": [NSNumber numberWithInteger:attribute]}];

}

- (void)adjustConstraintsWidth:(CGFloat)width andHeight:(CGFloat)height
{
    [self adjustSelfConstraintWithFirstAttribute:NSLayoutAttributeWidth to:width];
    [self adjustSelfConstraintWithFirstAttribute:NSLayoutAttributeHeight to:height];

}

// the idea here is that a relative to constraint will belong to the "to" view.. as opposed to 'self' views such as width and height
- (void)adjustParentConstraintWithFirstAttribute:(NSLayoutAttribute)attribute toConstant:(CGFloat)constant;
{
    for (NSLayoutConstraint *constraint in [[self superview] constraints]) {
        if ([constraint firstAttribute] == attribute && ([constraint.firstItem isEqual:self] || [constraint.secondItem isEqual:self])) {
            constraint.constant = constant;
            [[self superview] layoutIfNeeded];
            return;
        }
    }


    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:@"view doesn't have constraint that needs to be adjusted"
                                 userInfo:@{@"view": self,
                                            @"attribute": [NSNumber numberWithInteger:attribute]}];

}

- (id)getParentConstraintOfAttribute:(NSLayoutAttribute)attribute
{
    for (NSLayoutConstraint *constraint in [[self superview] constraints]) {
        if ([constraint firstAttribute] == attribute && ([constraint.firstItem isEqual:self] || [constraint.secondItem isEqual:self])) {
            return constraint;
        }
    }
    return nil;
}

// there are some constraints we add to elements relative to sibling elements
- (void)adjustParentConstraintWithFirstAttribute:(NSLayoutAttribute)attribute toConstant:(CGFloat)constant relativeToSiblingElement:(UIView *)siblingElement
{
    for (NSLayoutConstraint *constraint in [[self superview] constraints]) {
        if ([constraint firstAttribute] == attribute && [[constraint secondItem] isEqual:siblingElement]) {
            constraint.constant = constant;
            [[self superview] layoutIfNeeded];
            return;
        }
    }


    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:@"view doesn't have constraint that needs to be adjusted"
                                 userInfo:@{@"view": self,
                                            @"attribute": [NSNumber numberWithInteger:attribute]}];

}

- (void)adjustSelfConstraintOnParentWithFirstAttribute:(NSLayoutAttribute)attribute toConstant:(CGFloat)constant relativeToSiblingElement:(UIView *)siblingElement
{
    for (NSLayoutConstraint *constraint in [[self superview] constraints]) {
        if ([[constraint firstItem] isEqual:self] && [constraint firstAttribute] == attribute && [[constraint secondItem] isEqual:siblingElement]) {
            constraint.constant = constant;
            [[self superview] layoutIfNeeded];
            return;
        }
    }


    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:@"view doesn't have constraint that needs to be adjusted"
                                 userInfo:@{@"view": self,
                                            @"attribute": [NSNumber numberWithInteger:attribute]}];
}

- (void)adjustContainingConstraintWithFirstAttribute:(NSLayoutAttribute)attribute toConstant:(CGFloat)constant relativeToSiblingElement:(UIView *)siblingElement
{
    for (NSLayoutConstraint *constraint in [self constraints]) {
        if ([constraint firstAttribute] == attribute && [[constraint secondItem] isEqual:siblingElement]) {
            constraint.constant = constant;
            [self layoutIfNeeded];
            return;
        }
    }


    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:@"view doesn't have constraint that needs to be adjusted"
                                 userInfo:@{@"view": self,
                                            @"attribute": [NSNumber numberWithInteger:attribute]}];
}

- (void)constraintWithEqualityOfSubview:(UIView *)subview another:(UIView *)another
{
    NSLayoutConstraint *cn = [NSLayoutConstraint constraintWithItem:subview
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:another
                                                          attribute:NSLayoutAttributeWidth
                                                         multiplier:1
                                                           constant:0];
    [self addConstraint:cn];
}

- (NSLayoutConstraint *)getFirstConstraintWithAttribute:(NSLayoutAttribute)attribute
{
    return [self getFirstConstraintWithAttribute:attribute forSibling:self];
}

- (NSLayoutConstraint *)getFirstConstraintWithAttribute:(NSLayoutAttribute)attribute forSibling:(UIView *)sibling
{
    NSLayoutConstraint *cn = nil;
    for (cn in self.constraints) {
        if ((cn.firstAttribute == attribute && cn.firstItem == sibling) ||
            (cn.secondAttribute == attribute && cn.secondItem == sibling))
            break;
    }
    return cn;
}

- (void)clearConstraintsOfSubview:(UIView *)subview
{
    for (NSLayoutConstraint *constraint in [self constraints]) {
        if ([[constraint firstItem] isEqual:subview] || [[constraint secondItem] isEqual:subview]) {
            [self removeConstraint:constraint];
        }
    }
}

# pragma mark - getts

- (CGFloat)getSelfConstraintConstantWithFirstAttribute:(NSLayoutAttribute)attribute
{
    for (NSLayoutConstraint *constraint in [self constraints]) {
        if ([constraint firstAttribute] == attribute) {
            return constraint.constant;
        }
    }


    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:@"view doesn't have specified constraint"
                                 userInfo:@{@"view": self,
                                            @"attribute": [NSNumber numberWithInteger:attribute]}];
}



@end
