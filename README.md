this is a category file that was used in the [Vibereel](http://www.vibereel.com) project. 

exapmle usage:
```

- (void)setupCenterView
{
    // scroll view
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.maskView addSubview:scrollView];
    [scrollView pinBordersToView:self.maskView];
    self.scrollView = scrollView;
    
    // scroll content view
    UIView *scrollContentView = [[UIView alloc] init];
    scrollContentView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scrollView addSubview:scrollContentView];
    [scrollContentView pinBordersToView:self.scrollView];
    [self.scrollView setWidthEqualityToView:scrollContentView constant:0];
    [self.scrollView setHeightEqualityToView:scrollContentView constant:0];
    self.scrollContentView = scrollContentView;
    [self setupKeyboardDismissal];
    
    // center view
    UIView *view = [[UIView alloc] init];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    view.backgroundColor = [UIColor clearColor];
    [self.scrollContentView addSubview:view];
    self.centerView = view;
    
    [[view constraintCenterYEqualTo:self.scrollContentView constant:0] setPriority:UILayoutPriorityDefaultHigh];
    [view constraintLeadingEqualTo:self.scrollContentView constant:[[self class] sidePadding]];
    [view constraintTrailingEqualTo:self.scrollContentView constant:-[[self class] sidePadding]];
}

```
