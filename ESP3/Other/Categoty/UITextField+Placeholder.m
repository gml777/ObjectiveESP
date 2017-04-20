

#import "UITextField+Placeholder.h"
#import <objc/message.h>

@implementation UITextField (Placeholder)

+ (void)load
{
    Method setPlaceholderMethod = class_getInstanceMethod(self, @selector(setPlaceholder:));
  
    Method xmg_setPlaceholderMethod = class_getInstanceMethod(self, @selector(xmg_setPlaceholder:));
    
    method_exchangeImplementations(setPlaceholderMethod, xmg_setPlaceholderMethod);
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    objc_setAssociatedObject(self, @"placeholderColor", placeholderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    UILabel *placeholderLabel = [self valueForKeyPath:@"placeholderLabel"];
    placeholderLabel.textColor = placeholderColor;
}

- (void)xmg_setPlaceholder:(NSString *)placeholder
{
    [self xmg_setPlaceholder:placeholder];
    
    [self setPlaceholderColor:self.placeholderColor];
}

- (UIColor *)placeholderColor
{
    return objc_getAssociatedObject(self, @"placeholderColor");
}

@end
