//
//  UIView+Constraints.h
//  Vibereel
//
//  Created by Abdullah Bakhach on 9/12/14.
//  Copyright (c) 2014 tohtt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Constraints)

/**
 A convenience method that simplifies the process of creating and attaching a constraint to a view from scratch

 It accomplishes things necessary before and after creating a constraint, such as clearing the view
 from autoresizing masks, and ensures it's hidden and so on.

 self here is the view that the constraint will be added to

 IMPORTANT NOTE: there must be a width and height constraint manually entered in the constraints array..
 otherwise this won't work. The reason being is that when we remove the autoresize mask constraint, the width and
 height of the view is reset to 0.. to address that, a width and height constraint must be added

 @param constraintFormats An array of format specifications for the constraints.
 @param bindingDictionary A dictionary of views that appear in the visual format string. The keys must be the string values used in the visual format string, and the values must be the view objects. See + (NSArray *)constraintsWithVisualFormat:(NSString *)format  options:(NSLayoutFormatOptions)opts  metrics:(NSDictionary *)metrics  views:(NSDictionary *)views
 @param isAnimated a flag to indicate of applying the constraint should be animated
 @return nil
 */
-(void)createConstraintFormats:(NSArray *)constraintsFormats withBindingDict:(NSDictionary *)bindingDictionary isAnimated:(BOOL)isAnimated;


/**
 A convenience method that simplifies the process of creating and attaching a constraint to a view from scratch

 It accomplishes things necessary before and after creating a constraint, such as clearing the view
 from autoresizing masks, and ensures it's hidden and so on.

 self here is the view that the constraint will be added to

 IMPORTANT NOTE: there must be a width and height constraint manually entered in the constraints array..
 otherwise this won't work. The reason being is that when we remove the autoresize mask constraint, the width and
 height of the view is reset to 0.. to address that, a width and height constraint must be added

 @param constraintFormats An array of format specifications for the constraints.
 @param bindingDictionary A dictionary of views that appear in the visual format string. The keys must be the string values used in the visual format string, and the values must be the view objects. See + (NSArray *)constraintsWithVisualFormat:(NSString *)format  options:(NSLayoutFormatOptions)opts  metrics:(NSDictionary *)metrics  views:(NSDictionary *)views
 @param orderedViews an array containing views in the order that they must be added as subviews to the parent view, with the first view being the first view that will be added to the parent view and so on.
 @param isAnimated a flag to indicate of applying the constraint should be animated
 @return nil
 */
-(void)createConstraintFormats:(NSArray *)constraintsFormats withBindingDict:(NSDictionary *)bindingDictionary withOrderedViewsArray:(NSArray *)orderedViews isAnimated:(BOOL)isAnimated;




/**
 A convenience method that simplifies the process of appending constraints to existing constraints of a view

 It accomplishes things necessary before and after creating a constraint, such as clearing the view
 from autoresizing masks, and ensures it's hidden and so on.

 self here is the view that the constraint will be added to

 IMPORTANT NOTE: there must be a width and height constraint manually entered in the constraints array..
 otherwise this won't work. The reason being is that when we remove the autoresize mask constraint, the width and
 height of the view is reset to 0.. to address that, a width and height constraint must be added

 @param constraintFormats An array of format specifications for the constraints.
 @param bindingDictionary A dictionary of views that appear in the visual format string. The keys must be the string values used in the visual format string, and the values must be the view objects. See + (NSArray *)constraintsWithVisualFormat:(NSString *)format  options:(NSLayoutFormatOptions)opts  metrics:(NSDictionary *)metrics  views:(NSDictionary *)views
 @param isAnimated a flag to indicate of applying the constraint should be animated
 @return nil
 */
-(void)addConstraintFormats:(NSArray *)constraintsFormats withBindingDict:(NSDictionary *)bindingDictionary isAnimated:(BOOL)isAnimated;



- (void)setWidthContraintToConstant:(CGFloat)width;
- (void)setWidthContraintToConstant:(CGFloat)width withRelationship:(NSLayoutRelation)relation;
- (void)setHeightContraintToConstant:(CGFloat)height;
- (void)setWidthEqualityToView:(UIView *)view constant:(CGFloat)width;
- (void)setHeightEqualityToView:(UIView *)view constant:(CGFloat)height;

- (void)constraintWidthEqualTo:(UIView *)toView constant:(CGFloat)constant;
- (void)constraintWidthOfView:(UIView *)fromView EqualTo:(UIView *)toView constant:(CGFloat)constant;
- (void)constraintHeightEqualTo:(UIView *)toView constant:(CGFloat)constant;
- (NSLayoutConstraint *)constraintBottomEqualTo:(UIView *)toView constant:(CGFloat)constant;
- (void)setBottomConstraintOfViews:(UIView *)superview subView:(UIView *)subivew constant:(CGFloat)constant;
- (NSLayoutConstraint *)constraintTopEqualTo:(UIView *)toView constant:(CGFloat)constant withRelation:(NSLayoutRelation)relation;
- (NSLayoutConstraint *)constraintBottomEqualTo:(UIView *)toView constant:(CGFloat)constant withRelation:(NSLayoutRelation)relation;
- (NSLayoutConstraint *)constraintTopEqualTo:(UIView *)toView constant:(CGFloat)constant;

- (id)constraintLeadingEqualTo:(UIView *)toView constant:(CGFloat)constant;
- (NSLayoutConstraint *)constraintTrailingEqualTo:(UIView *)toView constant:(CGFloat)constant;

- (void)constraintLeftEqualTo:(UIView *)toView constant:(CGFloat)constant;
- (void)constraintLeftOfView:(UIView *)fromView equalTo:(UIView *)toView constant:(CGFloat)constant;
- (void)constraintRightEqualTo:(UIView *)toView constant:(CGFloat)constant;

- (void)constraintTrailingAndLeadingMakesCenterTo:(UIView *)toView havingWidth:(CGFloat)viewWidth;
- (void)constraintTopAndBottomMakesCenterTo:(UIView *)toView havingHeight:(CGFloat)viewHeight;

- (NSLayoutConstraint *)constraintCenterXEqualTo:(UIView *)toView constant:(CGFloat)constant;
- (NSLayoutConstraint *)constraintCenterXOfView:(UIView *)fromView equalToView:(UIView *)toView constant:(CGFloat)constant;
- (NSLayoutConstraint *)constraintCenterYEqualTo:(id)toView constant:(CGFloat)constant;
- (NSLayoutConstraint *)constraintCenterYOfView:(UIView *)fromView equalToView:(UIView *)toView constant:(CGFloat)constant;
- (void)centerViewToParent:(UIView *)toView;

- (void)constraintHorizontalSpacingSubviewsFrom:(UIView *)fromView to:(UIView *)toView constant:(CGFloat)constant;
- (void)constraintHorizontalSpacingSubviewsFromRightView:(UIView *)rightView toLeftView:(UIView *)leftView constant:(CGFloat)constant;
- (NSLayoutConstraint *)constraintHorizontalSpacingSubviewsFromLeftView:(UIView *)leftView toRightView:(UIView *)rightView constant:(CGFloat)constant;
- (void)constraintVerticalSpacingSubviewsFromBottomView:(UIView *)fromView toTopView:(UIView *)toView constant:(CGFloat)constant;
- (void)constraintVerticalSpacingSubviewsFromBottomView:(UIView *)fromView toTopView:(UIView *)toView constant:(CGFloat)constant relation:(NSLayoutRelation)relation;
- (void)constraintVerticalSpacingSubviewsFromTopView:(UIView *)fromView toBottomView:(UIView *)toView constant:(CGFloat)constant;

- (void)setConstraintWidth:(CGFloat)width height:(CGFloat)height;
- (void)setOrAdjustConstraintWidth:(CGFloat)width height:(CGFloat)height;
- (void)setConstraintsWidth:(CGFloat)width height:(CGFloat)height left:(CGFloat)left top:(CGFloat)top toView:(UIView *)toView;
- (void)setConstraintsWidth:(CGFloat)width height:(CGFloat)height right:(CGFloat)right bottom:(CGFloat)bottom toView:(UIView *)toView;
- (void)setConstraintsWidth:(CGFloat)width height:(CGFloat)height right:(CGFloat)right top:(CGFloat)top toView:(UIView *)toView;
- (void)setConstraintsWidth:(CGFloat)width height:(CGFloat)height left:(CGFloat)left bottom:(CGFloat)bottom toView:(UIView *)toView;

- (void)removeSubviews;
- (void)removeSubviewsApartFromView:(UIView *)exceptionView;
- (void)hideSubviewsApartFromView:(UIView *)exceptionView;

- (BOOL)containsSelfConstraintAttribute:(NSLayoutAttribute)attribute;
- (void)adjustSelfConstraintWithFirstAttribute:(NSLayoutAttribute)attribute to:(CGFloat)constant;
- (void)adjustSelfConstraintWithFirstAttribute:(NSLayoutAttribute)attribute to:(CGFloat)constant layout:(BOOL)layout;
- (void)adjustConstraintsWidth:(CGFloat)width andHeight:(CGFloat)height;
- (void)adjustParentConstraintWithFirstAttribute:(NSLayoutAttribute)attribute toConstant:(CGFloat)constant;
- (id)getParentConstraintOfAttribute:(NSLayoutAttribute)attribute;
- (void)adjustParentConstraintWithFirstAttribute:(NSLayoutAttribute)attribute toConstant:(CGFloat)constant relativeToSiblingElement:(UIView *)siblingElement;
- (void)adjustSelfConstraintOnParentWithFirstAttribute:(NSLayoutAttribute)attribute toConstant:(CGFloat)constant relativeToSiblingElement:(UIView *)siblingElement;
- (void)adjustContainingConstraintWithFirstAttribute:(NSLayoutAttribute)attribute toConstant:(CGFloat)constant relativeToSiblingElement:(UIView *)siblingElement;

- (void)cloneSizeAndOriginOfView:(UIView *)view;
- (void)pinBordersToView:(UIView *)view;
- (void)pinBordersToView:(UIView *)view top:(CGFloat)top trailing:(CGFloat)trailing bottom:(CGFloat)bottom leading:(CGFloat)leading;

// used for container that contains scrollview
- (void)constrainSelfToScrollView:(UIScrollView*)sv;
- (void)constrainSelfToScrollView:(UIScrollView*)sv top:(CGFloat)top trailing:(CGFloat)trailing bottom:(CGFloat)bottom leading:(CGFloat)leading;

// used to give scrollview dimensions based on its conatining view
- (void)constrainScrollViewToSelf:(UIScrollView *)sv;
- (void)constrainScrollViewToSelf:(UIScrollView *)sv top:(CGFloat)top trailing:(CGFloat)trailing bottom:(CGFloat)bottom leading:(CGFloat)leading;
- (void)constrainScrollViewToSelf:(UIScrollView *)sv top:(CGFloat)top trailing:(CGFloat)trailing leading:(CGFloat)leading;
- (void)constrainScrollViewToSelf:(UIScrollView *)sv bottom:(CGFloat)bottom;

- (void)constraintWithEqualityOfSubview:(UIView *)subview another:(UIView *)another;

- (NSLayoutConstraint *)getFirstConstraintWithAttribute:(NSLayoutAttribute)attribute;
- (NSLayoutConstraint *)getFirstConstraintWithAttribute:(NSLayoutAttribute)attribute forSibling:(UIView *)sibling;

- (void)clearConstraintsOfSubview:(UIView *)subview;

- (CGFloat)getSelfConstraintConstantWithFirstAttribute:(NSLayoutAttribute)attribute;
- (void)alignTopView:(UIView *)view withView:(UIView *)otherView;
@end
